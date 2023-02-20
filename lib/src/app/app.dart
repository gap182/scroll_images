import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final userSettings = ref.watch(userSettingsProvider);
    return ScreenUtilInit(
      designSize: const Size(390, 844), //Iphone 14 pixels
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Omni pro scroll images',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(userSettings.settings.languageSelected),
          routerConfig: router,
        );
      },
    );
  }
}
