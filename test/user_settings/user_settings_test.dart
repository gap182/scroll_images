import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';
import 'package:scroll_images/src/shared/user_settings/state/user_settings_state.dart';
import 'package:scroll_images/src/shared/user_settings/user_settings_entity.dart';

class Listener extends Mock {
  void call(UserSettingsState? previous, UserSettingsState value);
}

void main() {
  group('locale language', () {
    test('test initial value for locale', () {
      final container = ProviderContainer();
      addTearDown(() => container.dispose());
      final listener = Listener();

      container.listen<UserSettingsState>(
        userSettingsProvider,
        listener,
        fireImmediately: true,
      );

      verify(listener(null, UserSettingsState.empty())).called(1);
    });

    test('test change locale', () async {
      final container = ProviderContainer();
      addTearDown(() => container.dispose());
      final listener = Listener();

      container.listen<UserSettingsState>(
        userSettingsProvider,
        listener,
        fireImmediately: true,
      );

      verify(listener(null, UserSettingsState.empty())).called(1);
      verifyNoMoreInteractions(listener);

      container
          .read(userSettingsProvider.notifier)
          .changeLocale('es', saveInfo: false);

      verify(listener(
              const UserSettingsState(
                  settings: UserSettingsEntity(languageSelected: 'en')),
              const UserSettingsState(
                  settings: UserSettingsEntity(languageSelected: 'es'))))
          .called(1);
      verifyNoMoreInteractions(listener);
    });
  });
}
