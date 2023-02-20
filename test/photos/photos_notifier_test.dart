import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scroll_images/src/features/photos/data/models/photo_model.dart';
import 'package:scroll_images/src/features/photos/domain/repositories/photos_repository.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_state.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_status.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/models/error_model.dart';

import 'photos_notifier_test.mocks.dart';

class Listener extends Mock {
  void call(PhotosState? previous, PhotosState value);
}

@GenerateNiceMocks([MockSpec<PhotosRepository>()])
void main() {
  final photosResponse = [
    PhotoModel(
        albumId: 1,
        id: 1,
        title: 'one',
        url: 'oneURL',
        thumbnailUrl: 'oneThumb'),
    PhotoModel(
        albumId: 2,
        id: 2,
        title: 'two',
        url: 'twoURL',
        thumbnailUrl: 'twoThumb'),
    PhotoModel(
        albumId: 3,
        id: 3,
        title: 'third',
        url: 'thirdURL',
        thumbnailUrl: 'thirdThumb'),
  ];

  final page2Response = [
    PhotoModel(
        albumId: 21,
        id: 21,
        title: '2one',
        url: '2oneURL',
        thumbnailUrl: '2oneThumb'),
    PhotoModel(
        albumId: 22,
        id: 22,
        title: '2two',
        url: '2twoURL',
        thumbnailUrl: '2twoThumb'),
    PhotoModel(
        albumId: 23,
        id: 23,
        title: '2third',
        url: '2thirdURL',
        thumbnailUrl: '2thirdThumb'),
  ];

  group('load photos', () {
    test('initial values', () async {
      final container = ProviderContainer(overrides: [
        photosRepositoryProvider.overrideWith((ref) => MockPhotosRepository())
      ]);
      addTearDown(() => container.dispose());

      expect(container.read(photosProvider), PhotosState.empty());
    });

    test('load initial values', () async {
      final mockRepository = MockPhotosRepository();
      final container = ProviderContainer(overrides: [
        photosRepositoryProvider.overrideWith((ref) => mockRepository)
      ]);
      addTearDown(() => container.dispose());

      when(mockRepository.getPhotosByPage(1))
          .thenAnswer((_) async => photosResponse);
      expect(container.read(photosProvider).photosStatus,
          const PhotosStatus.loading());

      await container.read(photosProvider.notifier).loadPhotosInitial();

      verify(mockRepository.getPhotosByPage(1)).called(1);

      expect(container.read(photosProvider).photos, photosResponse);
      expect(container.read(photosProvider).photosStatus,
          const PhotosStatus.loaded());
    });
  });

  test('socket exception error', () async {
    final mockRepository = MockPhotosRepository();
    final container = ProviderContainer(overrides: [
      photosRepositoryProvider.overrideWith((ref) => mockRepository)
    ]);
    addTearDown(() => container.dispose());

    when(mockRepository.getPhotosByPage(1))
        .thenThrow(const SocketException('test'));

    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.loading());

    await container.read(photosProvider.notifier).loadPhotosInitial();

    verify(mockRepository.getPhotosByPage(1)).called(1);

    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.error(ErrorModel(errorType: ErrorType.connection)));
  });

  test('unknown exception error', () async {
    final mockRepository = MockPhotosRepository();
    final container = ProviderContainer(overrides: [
      photosRepositoryProvider.overrideWith((ref) => mockRepository)
    ]);
    addTearDown(() => container.dispose());

    when(mockRepository.getPhotosByPage(1))
        .thenThrow(PlatformException(code: '1'));

    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.loading());

    await container.read(photosProvider.notifier).loadPhotosInitial();

    verify(mockRepository.getPhotosByPage(1)).called(1);

    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.error(ErrorModel(errorType: ErrorType.unknown)));
  });

  test('load page 2', () async {
    final mockRepository = MockPhotosRepository();
    final container = ProviderContainer(overrides: [
      photosRepositoryProvider.overrideWith((ref) => mockRepository)
    ]);
    addTearDown(() => container.dispose());

    when(mockRepository.getPhotosByPage(2))
        .thenAnswer((realInvocation) async => page2Response);
    when(mockRepository.getPhotosByPage(1))
        .thenAnswer((realInvocation) async => photosResponse);

    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.loading());

    await container.read(photosProvider.notifier).loadPhotosInitial();

    verify(mockRepository.getPhotosByPage(1)).called(1);

    expect(container.read(photosProvider).photos, photosResponse);
    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.loaded());

    await container.read(photosProvider.notifier).loadPhotosByPage();

    verify(mockRepository.getPhotosByPage(2)).called(1);

    expect(container.read(photosProvider).photos,
        [...photosResponse, ...page2Response]);
    expect(container.read(photosProvider).photosStatus,
        const PhotosStatus.loaded());
    expect(container.read(photosProvider).currentPage, 3);
  });
}
