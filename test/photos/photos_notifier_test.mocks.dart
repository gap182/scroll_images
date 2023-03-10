// Mocks generated by Mockito 5.3.2 from annotations
// in scroll_images/test/photos/photos_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:scroll_images/src/features/photos/data/models/photo_model.dart'
    as _i4;
import 'package:scroll_images/src/features/photos/domain/repositories/photos_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PhotosRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPhotosRepository extends _i1.Mock implements _i2.PhotosRepository {
  @override
  _i3.Future<List<_i4.PhotoModel>> getPhotosByPage(int? page) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPhotosByPage,
          [page],
        ),
        returnValue: _i3.Future<List<_i4.PhotoModel>>.value(<_i4.PhotoModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.PhotoModel>>.value(<_i4.PhotoModel>[]),
      ) as _i3.Future<List<_i4.PhotoModel>>);
}
