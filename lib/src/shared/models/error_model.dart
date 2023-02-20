import 'dart:convert';

import 'package:equatable/equatable.dart';

enum ErrorType {
  unknown,
  connection,
}

class ErrorModel extends Equatable {
  const ErrorModel({
    this.details,
    this.errorType,
  });
  final String? details;
  final ErrorType? errorType;

  ErrorModel copyWith({
    String? details,
    ErrorType? errorType,
  }) {
    return ErrorModel(
      details: details ?? this.details,
      errorType: errorType ?? this.errorType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (details != null) {
      result.addAll({'details': details});
    }
    if (errorType != null) {
      result.addAll({'errorType': errorType});
    }

    return result;
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      details: map['details'],
      errorType: map['errorType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorModel(details: $details, errorType: $errorType)';

  @override
  List<Object?> get props => [details, errorType];
}
