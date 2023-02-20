import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_images/l10n/l10n.dart';
import 'package:scroll_images/src/features/photos/presentation/components/photos_list.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/models/error_model.dart';
import 'package:scroll_images/src/shared/static_data/colors.dart';

class PhotosPage extends ConsumerStatefulWidget {
  const PhotosPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotosPageState();
}

class _PhotosPageState extends ConsumerState<PhotosPage> {
  @override
  void initState() {
    _loadInitData();
    super.initState();
  }

  void _loadInitData() async {
    await ref.read(photosProvider.notifier).loadPhotosInitial();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(photosProvider, (previous, next) {
      next.photosStatus?.whenOrNull(error: (e) {
        showDialog(
          context: context,
          builder: (_) {
            String? errorText;

            switch (e.errorType) {
              case ErrorType.connection:
                errorText = context.l10n.errorConnection;
                break;
              case ErrorType.unknown:
                errorText = context.l10n.errorUnknown;
                break;
              default:
            }

            return AlertDialog(
              title: Text(context.l10n.error),
              content: Text(errorText ?? ''),
            );
          },
        );
      });
    });

    final photosState = ref.watch(photosProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackLogo,
        title: Text(context.l10n.photos),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: photosState.photosStatus?.whenOrNull(
        loading: () => PhotosList(
          photos: photosState.photos,
          loadMoreData: () {
            ref.read(photosProvider.notifier).loadPhotosByPage();
          },
          loading: true,
        ),
        loaded: () => PhotosList(
          photos: photosState.photos,
          loadMoreData: () {
            ref.read(photosProvider.notifier).loadPhotosByPage();
          },
        ),
        error: (e) => PhotosList(
          photos: photosState.photos,
          loadMoreData: () {
            ref.read(photosProvider.notifier).loadPhotosByPage();
          },
        ),
      ),
    );
  }
}
