import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:scroll_images/src/features/photos/data/models/photo_model.dart';
import 'package:scroll_images/src/features/photos/domain/repositories/photos_repository.dart';
import 'package:scroll_images/src/shared/static_data/links.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  PhotosRepositoryImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<List<PhotoModel>> getPhotosByPage(int page) async {
    final photos = await client
        .get(Uri.parse('${AppLinks.mainLink}photos?_page=$page&_limit=10'));
    final photosModel = <PhotoModel>[];
    final photosDecoded = json.decode(photos.body);
    if (photosDecoded is List) {
      for (var photo in photosDecoded) {
        photosModel.add(PhotoModel.fromMap(photo));
      }
    }
    return photosModel;
  }
}
