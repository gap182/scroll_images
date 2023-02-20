import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_images/l10n/l10n.dart';
import 'package:scroll_images/src/shared/components/big_button.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/static_data/colors.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSettings = ref.watch(userSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        backgroundColor: AppColors.blackLogo,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                context.l10n.settings,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.l10n.spanish),
                Switch(
                  activeColor: AppColors.blueLogo,
                  value: userSettings.settings.languageSelected == 'en',
                  onChanged: (value) {
                    ref
                        .read(userSettingsProvider.notifier)
                        .changeLocale(value ? 'en' : 'es');
                  },
                ),
                Text(context.l10n.english),
              ],
            )
          ],
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BigButton(
              onTap: () {
                context.pushNamed('photos');
              },
              child: Text(context.l10n.photos),
            ),
            BigButton(
              onTap: () {
                context.pushNamed('posts');
              },
              child: Text(context.l10n.posts),
            ),
          ],
        ),
      ),
    );
  }
}
