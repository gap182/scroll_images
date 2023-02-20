import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scroll_images/l10n/l10n.dart';
import 'package:scroll_images/src/features/photos/data/models/photo_model.dart';
import 'package:scroll_images/src/shared/static_data/colors.dart';

class PhotosList extends StatefulWidget {
  const PhotosList({
    super.key,
    required this.photos,
    required this.loadMoreData,
    this.loading = false,
  });

  final List<PhotoModel> photos;
  final bool loading;
  final VoidCallback loadMoreData;

  @override
  State<PhotosList> createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: scrollController,
          itemCount: widget.photos.length,
          itemBuilder: (context, index) {
            final currentPhoto = widget.photos[index];
            if (currentPhoto.url == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '${context.l10n.album}: ${currentPhoto.albumId}')),
                  Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('${context.l10n.title}: ${currentPhoto.title}')),
                  CachedNetworkImage(imageUrl: widget.photos[index].url!),
                ],
              ),
            );
          },
        ),
        if (widget.loading)
          Positioned.fill(
            child: Container(
              color: AppColors.blueLogo.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
