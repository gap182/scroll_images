part of 'dependencies.dart';

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  return PhotosRepositoryImpl(client: ref.read(httpProvider));
});
