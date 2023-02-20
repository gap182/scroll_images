import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_images/src/features/photos/data/repositories/photos_repository_impl.dart';
import 'package:scroll_images/src/features/photos/domain/repositories/photos_repository.dart';
import 'package:scroll_images/src/features/photos/presentation/bloc/photos_notifier.dart';
import 'package:scroll_images/src/features/photos/presentation/state/photos_state.dart';
import 'package:scroll_images/src/shared/user_settings/bloc/user_settings_notifier.dart';
import 'package:scroll_images/src/shared/user_settings/data/repositories/persist_data_impl.dart';
import 'package:scroll_images/src/shared/user_settings/domain/repositories/persist_data.dart';
import 'package:scroll_images/src/shared/user_settings/state/user_settings_state.dart';
import 'package:http/http.dart' as http;

part 'dependencies_ui.dart';
part 'dependencies_domain.dart';
part 'dependencies_data.dart';
