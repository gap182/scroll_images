import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scroll_images/src/shared/models/error_model.dart';

part 'photos_status.freezed.dart';

@freezed
class PhotosStatus with _$PhotosStatus {
  const factory PhotosStatus.loading() = _Loading;
  const factory PhotosStatus.loaded() = _Loaded;
  const factory PhotosStatus.error(ErrorModel e) = _Error;
}
