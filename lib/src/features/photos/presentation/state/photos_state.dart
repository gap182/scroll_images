import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:scroll_images/src/features/photos/data/models/photo_model.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_status.dart';

class PhotosState extends Equatable {
  const PhotosState({
    required this.photos,
    this.currentPage = 1,
    this.photosStatus,
  });

  final List<PhotoModel> photos;
  final int currentPage;
  final PhotosStatus? photosStatus;

  PhotosState copyWith({
    List<PhotoModel>? photos,
    PhotosStatus? photosStatus,
    int? currentPage,
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      photosStatus: photosStatus ?? this.photosStatus,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  static PhotosState empty() {
    return const PhotosState(
      photos: [],
      photosStatus: PhotosStatus.loading(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'photos': photos.map((x) => x.toMap()).toList()});

    return result;
  }

  factory PhotosState.fromMap(Map<String, dynamic> map) {
    return PhotosState(
      photos: List<PhotoModel>.from(
          map['photos']?.map((x) => PhotoModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotosState.fromJson(String source) =>
      PhotosState.fromMap(json.decode(source));

  @override
  String toString() =>
      'PhotosState(photos: $photos, photosStatus: $photosStatus)';

  @override
  List<Object?> get props => [photos, photosStatus];
}
