# Changelog

## 3.0.0-dev.4

- Fix scaling issues with turns and orientations.
- Fix lint issues on Flutter 2.10.
- Export `CameraPickerPageRoute`.

Breaking changes:
- Abstract `CamearPickerConfig`, which moved all arguments from `pickFromCamera` to `pickerConfig`.

## 3.0.0-dev.3

- Improve semantics expressions.
- Make camera controllers available as soon as possible.

## 3.0.0-dev.2

- Add `lockCaptureOrientation`, allowing users to determine lock to the specific orientation during captures. (#68)
- Tweak asynchronous methods call during initializations.
- Add full semantics support. (#72)
- Improve camera initializes by adding a lock.

## 3.0.0-dev.1

- Migrate to the latest photo_manager.

## 2.6.5

- Remove duplicate future requests when saving an entity.

## 2.6.4

- Drop initialize when the controller has been already initialized. (#70)

## 2.6.3

- Fix set exposure point crashes when switching between cameras. (#66)

## 2.6.2

- Bind circular progress color with the theme.

## 2.6.1

- Allow saving entities when the permission is limited on iOS.

## 2.6.0

- Add `preferredLensDirection`, allowing users to choose which lens direction is preferred when first using the camera.
- Add `enableTapRecording`, allowing users to determine whether to allow the record can start with a single tap.
- Add `shouldAutoPreviewVideo`, allowing users to determine whether the video should be played instantly in the preview.

## 2.5.2

- Request the permission state again when saving.
- Provide better experiences when video records need to be prepared.

## 2.5.1

- Fix invalid widgets binding observer caller.

## 2.5.0

- Add `onError` to handle errors during the picking process.
- `SaveEntityCallback` -> `EntitySaveCallback`.
- Improve folder structure of the plugin.

## 2.4.2

- Flip the preview if the user is using a front camera.

## 2.4.1

- Handle save exceptions more gracefully.
- Dispose the controller when previewing for better performance.

## 2.4.0

- Bump `camera` to `0.9.x` .
- Remove `shouldLockPortrait` in picking.

## 2.3.1

- Expose `enablePullToZoomInRecord` for the `pickFromCamera` method.
- Trigger shooting preparation only when start recording on iOS.

## 2.3.0

- Expose `useRootNavigator` while picking.
- Initialize a new controller if failed to stop recording. (#39)
- Throw or rethrow exceptions that used to be caught. (#41)
- Update the back icon with preview.
- Enhance video capture on iOS with preparation.

## 2.2.0

- Add `EntitySaveCallback` for the custom save method.

## 2.1.2

- Improve the UI of the exposure point widget when manually focus.

## 2.1.1

- Use basename when saving entities.

## 2.1.0

- Add `shouldLockPortrait` to fit orientation for the device.
- Fix exposure offset issue when resetting the exposure point after adjusting the exposure offset manually.

## 2.0.0

### New Features

- Add `enableSetExposure`, allowing users to update the exposure from the point tapped on the screen.
- Add `enableExposureControlOnPoint`, allowing users to control the exposure offset with an offset slide from the exposure point.
- Add `enablePinchToZoom`, allowing users to zoom by pinching the screen.
- Add `enablePullToZoomInRecord`, allowing users to zoom by pulling up when recording video.
- Add `foregroundBuilder`, allowing users to build customized widgets beyond the camera preview.
- Add `shouldDeletePreviewFile`, allowing users to choose whether the captured file should be deleted.
- Sync `imageFormatGroup` from the `camera` plugin.

### Breaking Changes

- Migrate to non-nullable by default.
- `isAllowRecording` -> `enableRecording`
- `isOnlyAllowRecording` -> `onlyAllowRecording`

### Fixes

- All fixes from the `camera` plugin.

## 1.3.1

- Constraint dependencies version. #22

## 1.3.0

- Add `enableAudio` parameter to control whether the package will require audio integration. #17

## 1.2.3

- Fix `maximumRecordingDuration` not passed in static method. #14

## 1.2.2

- Raise dependencies versions.

## 1.2.1

- Add `cameraQuarterTurns`.

## 1.2.0

- Expose resolution preset control.

## 1.1.2

- Remove common exports.

## 1.1.1

- Documents update.

## 1.1.0+1

- Link confirm button's text with delegate. Fix #6.

## 1.1.0

- Add `isOnlyAllowRecording` . Resolves #4.
- Make camera switching available. Resolves #5.

## 1.0.0+1

- Fix potential non exist directory access.

## 1.0.0

- Support taking pictures and videos.
- Support video recording duration limitation.
