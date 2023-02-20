import 'package:scroll_images/src/features/photos/data/models/photo_model.dart';

abstract class PhotosRepository {
  Future<List<PhotoModel>> getPhotosByPage(int page);
}
