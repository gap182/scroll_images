import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            return InkWell(
              onTap: () {
                context.goNamed('photo', queryParams: {
                  'url': currentPhoto.url,
                  'title': currentPhoto.id.toString(),
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blueLogo.withOpacity(0.2),
                        spreadRadius: 1.0,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Column(
                  children: [
                    Text('${context.l10n.album}: ${currentPhoto.albumId}'),
                    Text('${context.l10n.title}: ${currentPhoto.title}'),
                    CachedNetworkImage(
                        imageUrl: widget.photos[index].thumbnailUrl!),
                  ],
                ),
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
