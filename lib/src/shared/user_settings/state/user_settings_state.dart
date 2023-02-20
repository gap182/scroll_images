import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:scroll_images/src/shared/user_settings/user_settings_entity.dart';

class UserSettingsState extends Equatable {
  final UserSettingsEntity settings;
  const UserSettingsState({
    required this.settings,
  });

  UserSettingsState copyWith({
    UserSettingsEntity? settings,
  }) {
    return UserSettingsState(
      settings: settings ?? this.settings,
    );
  }

  static UserSettingsState empty() {
    return const UserSettingsState(
      settings: UserSettingsEntity(languageSelected: 'en'),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'settings': settings.toMap()});

    return result;
  }

  factory UserSettingsState.fromMap(Map<dynamic, dynamic> map) {
    return UserSettingsState(
      settings: UserSettingsEntity.fromMap(map['settings']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsState.fromJson(String source) =>
      UserSettingsState.fromMap(json.decode(source));

  @override
  String toString() => 'UserSettingsState(settings: $settings)';

  @override
  List<Object> get props => [settings];
}
