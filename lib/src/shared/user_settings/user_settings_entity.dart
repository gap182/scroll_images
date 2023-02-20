import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserSettingsEntity extends Equatable {
  final String languageSelected;
  const UserSettingsEntity({
    required this.languageSelected,
  });

  UserSettingsEntity copyWith({
    String? languageSelected,
  }) {
    return UserSettingsEntity(
      languageSelected: languageSelected ?? this.languageSelected,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'languageSelected': languageSelected});

    return result;
  }

  factory UserSettingsEntity.fromMap(Map<dynamic, dynamic> map) {
    return UserSettingsEntity(
      languageSelected: map['languageSelected'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsEntity.fromJson(String source) =>
      UserSettingsEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserSettingsEntity(languageSelected: $languageSelected)';

  @override
  List<Object> get props => [languageSelected];
}
