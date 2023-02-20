part of 'dependencies.dart';

final httpProvider = Provider<http.Client>((ref) {
  return http.Client();
});
