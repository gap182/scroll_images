import 'package:go_router/go_router.dart';
import 'package:scroll_images/src/features/home/presentation/home_page.dart';
import 'package:scroll_images/src/features/photos/presentation/photos_page.dart';
import 'package:scroll_images/src/features/splash/presentation/splash_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'photos',
          name: 'photos',
          builder: (context, state) => const PhotosPage(),
        ),
      ],
    ),
  ],
);
