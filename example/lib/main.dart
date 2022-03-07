import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeChat Camera Picker Demo',
      theme: ThemeData(
        brightness: MediaQueryData.fromWindow(ui.window).platformBrightness,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AssetEntity? entity;
  Uint8List? data;

  Future<void> pick(BuildContext context) async {
    NativeDeviceOrientation? currentOrientation;
    final Size size = MediaQuery.of(context).size;
    final double scale = MediaQuery.of(context).devicePixelRatio;

    AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 13,
        requestType: RequestType.image,
        specialItemPosition: SpecialItemPosition.prepend,
        specialItemBuilder:
            (BuildContext context, AssetPathEntity? assetPathentity, int? i) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final AssetEntity? result = await CameraPicker.pickFromCamera(
                  context,
                  pickerConfig: CameraPickerConfig(
                      enableRecording: true,
                      lockCaptureOrientation: DeviceOrientation.portraitUp,
                      onCameraShutterPressed: () async {
                        currentOrientation =
                            await NativeDeviceOrientationCommunicator()
                                .orientation(useSensor: true)
                                .timeout(const Duration(milliseconds: 300),
                                    onTimeout: () =>
                                        NativeDeviceOrientation.portraitUp);
                      },
                      onEntitySaving: (
                          {BuildContext? context,
                          File? file,
                          CameraPickerViewType? viewType}) async {
                        final image.Image imagee =
                            image.decodeImage(file!.readAsBytesSync())!;
                        final image.Image? orientationFixedImg =
                            await _fixExifRotation(imagee, currentOrientation!);
                        if (orientationFixedImg != null) {
                          await file.writeAsBytes(
                              image.encodeJpg(orientationFixedImg));
                          print('wtf');
                        }
                      }));

              if (result == null) {
                return;
              }

              try {
                // NativeDeviceOrientationCommunicator().onOrientationChanged(useSensor: true).listen((event) {
                //   currentOrientation ??= event;
                //   print('vkl $event');
                // });
                final AssetEntity _entity = result;
                if (entity != _entity) {
                  entity = _entity;
                  // final image.Image imagee =
                  //     image.decodeImage((await entity!.originFile)!.readAsBytesSync())!;
                  // final image.Image? orientationFixedImg =
                  //     await _fixExifRotation(imagee, currentOrientation!);
                  // if (orientationFixedImg != null) {
                  //   File file = (await entity!.file)!;
                  //   await file.writeAsBytes(image.encodeJpg(orientationFixedImg));
                  // }
                  if (mounted) {
                    setState(() {});
                  }
                  data = await _entity.thumbnailDataWithSize(
                    ThumbnailSize((size.width * scale).toInt(),
                        (size.height * scale).toInt()),
                  );
                  if (mounted) {
                    setState(() {});
                  }
                }
              } catch (e) {
                rethrow;
              }

              final AssetPicker<AssetEntity, AssetPathEntity>? picker =
                  context.findAncestorWidgetOfExactType();
              final DefaultAssetPickerProvider? p =
                  (picker?.builder as DefaultAssetPickerBuilderDelegate?)
                      ?.provider;
              if (p != null) {
                p.currentPath = await p.currentPath!.obtainForNewProperties();
                await p.switchPath(p.currentPath);
                p.selectAsset(result);
              }
            },
            child: const Center(
              child: Icon(Icons.camera_enhance, size: 42.0),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WeChat Camera Picker Demo')),
      body: Stack(
        children: <Widget>[
          if (entity != null && data != null)
            Positioned.fill(child: Image.memory(data!, fit: BoxFit.contain))
          else if (entity != null && data == null)
            const Center(child: CircularProgressIndicator())
          else
            const Center(child: Text('Click the button to start picking.')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pick(context),
        tooltip: 'Increment',
        child: const Icon(Icons.camera_enhance),
      ),
    );
  }
}

Future<image.Image?> _fixExifRotation(
    image.Image bakedImage, NativeDeviceOrientation orientation) async {
  switch (orientation) {
    case NativeDeviceOrientation.landscapeLeft:
      return image.copyRotate(bakedImage, -90);
    case NativeDeviceOrientation.landscapeRight:
      return image.copyRotate(bakedImage, 90);
    case NativeDeviceOrientation.portraitDown:
      return image.copyRotate(bakedImage, 180);
    default:
      return null;
  }
}
