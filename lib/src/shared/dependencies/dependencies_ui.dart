part of 'dependencies.dart';

final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, UserSettingsState>((ref) {
  return UserSettingsNotifier(ref);
});

final persistentDataProvider = Provider<PersistDataRepository>((ref) {
  return PersistDataImplementation();
});

final photosProvider =
    StateNotifierProvider.autoDispose<PhotosNotifier, PhotosState>((ref) {
  return PhotosNotifier(ref.read(photosRepositoryProvider));
});
