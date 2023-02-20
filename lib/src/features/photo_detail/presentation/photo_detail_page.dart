import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_images/l10n/l10n.dart';
import 'package:scroll_images/src/shared/static_data/colors.dart';

class PhotoDetailPage extends StatelessWidget {
  const PhotoDetailPage({
    super.key,
    required this.url,
    required this.title,
  });

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackLogo,
        title: Text('${context.l10n.photo} $title'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
        ),
      ),
    );
  }
}
