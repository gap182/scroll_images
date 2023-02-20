import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_images/src/shared/dependencies/dependencies.dart';

import 'package:scroll_images/src/shared/user_settings/state/user_settings_state.dart';

class UserSettingsNotifier extends StateNotifier<UserSettingsState> {
  UserSettingsNotifier(
    this.ref,
  ) : super(UserSettingsState.empty());

  final Ref ref;

  void changeLocale(String locale, {bool saveInfo = true}) {
    state = state.copyWith(
        settings: state.settings.copyWith(languageSelected: locale));

    if (saveInfo) {
      final persData = ref.read(persistentDataProvider);
      persData.writeInfo('settings', 'user-settings', state.toMap());
    }
  }

  void updateState(UserSettingsState newState) {
    state = newState;
  }
}
