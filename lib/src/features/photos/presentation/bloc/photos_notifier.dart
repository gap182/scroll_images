import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scroll_images/src/features/photos/domain/repositories/photos_repository.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_state.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_status.dart';
import 'package:scroll_images/src/shared/models/error_model.dart';

class PhotosNotifier extends StateNotifier<PhotosState> {
  PhotosNotifier(
    this.repository,
  ) : super(PhotosState.empty());

  final PhotosRepository repository;

  Future<void> loadPhotosInitial() async {
    try {
      final photos = await repository.getPhotosByPage(1);
      state = state.copyWith(
        photos: photos,
        currentPage: 2,
        photosStatus: const PhotosStatus.loaded(),
      );
    } on SocketException {
      const errorModel = ErrorModel(errorType: ErrorType.connection);
      state =
          state.copyWith(photosStatus: const PhotosStatus.error(errorModel));
    } catch (e) {
      const errorModel = ErrorModel(errorType: ErrorType.unknown);
      state =
          state.copyWith(photosStatus: const PhotosStatus.error(errorModel));
    }
  }

  Future<void> loadPhotosByPage() async {
    try {
      if (state.photosStatus == const PhotosStatus.loading()) return;
      state = state.copyWith(photosStatus: const PhotosStatus.loading());
      final currentPage = state.currentPage;
      final photos = await repository.getPhotosByPage(currentPage);
      final finalPhotos = [...state.photos, ...photos];
      state = state.copyWith(
        photos: finalPhotos,
        currentPage: currentPage + 1,
        photosStatus: const PhotosStatus.loaded(),
      );
    } on SocketException {
      const errorModel = ErrorModel(errorType: ErrorType.connection);
      state =
          state.copyWith(photosStatus: const PhotosStatus.error(errorModel));
    } catch (e) {
      const errorModel = ErrorModel(errorType: ErrorType.unknown);
      state =
          state.copyWith(photosStatus: const PhotosStatus.error(errorModel));
    }
  }
}
