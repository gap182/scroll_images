import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/static_data/images.dart';
import 'package:scroll_images/src/shared/user_settings/state/user_settings_state.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _loadPersistentData();
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation =
        Tween<double>(begin: 0.0, end: 200.0).animate(animationController);

    animation.addListener(() {
      if (animation.isCompleted) {
        context.go('/home');
      }
    });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _loadPersistentData() async {
    final box = ref.read(persistentDataProvider);
    await box.init('settings');
    final values = await box.readInfo('settings', 'user-settings');
    ref
        .read(userSettingsProvider.notifier)
        .updateState(UserSettingsState.fromMap(values));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Image.asset(
              AppImages.logo,
              height: animation.value,
              width: animation.value,
            );
          },
        ),
      ),
    );
  }
}
