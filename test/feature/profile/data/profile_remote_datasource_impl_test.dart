import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:stream_pro/core/error/exceptions/server_exception.dart';

import 'package:stream_pro/core/networking/api_service.dart';
import 'package:stream_pro/core/networking/api_constants.dart';
import 'package:stream_pro/feature/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:stream_pro/feature/profile/data/models/profile_model.dart';

// 1. Create Mock
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late ProfileRemoteDataSourceImpl dataSource;
  late Directory tempDirectory;
  late File avatarFile;

  // Sample response data
  final profileJson = <String, dynamic>{
    'id': '123',
    'name': 'Wael',
    'email': 'wael@example.com',
    'avatarUrl': null,
    'createdAt': '2025-01-01T10:00:00.000Z',
    'updatedAt': '2025-01-02T10:00:00.000Z',
    'videoCount': 10,
    'totalViews': 500,
  };

  setUp(() async {
    mockApiService = MockApiService();
    dataSource = ProfileRemoteDataSourceImpl(mockApiService);
    tempDirectory = await Directory.systemTemp.createTemp(
      'profile_update_test_',
    );

    avatarFile = File('${tempDirectory.path}/avatar.png');
    await avatarFile.writeAsBytes([1, 2, 3]);
  });

  tearDown(() async {
    await tempDirectory.delete(recursive: true);
  });

  group('ProfileRemoteDataSourceImpl', () {
    group('getProfile', () {
      test('should return ProfileModel when the API call succeeds', () async {
        // Arrange
        when(() => mockApiService.get(ApiConstants.profileMe)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ApiConstants.profileMe),
            data: {'data': profileJson},
          ),
        );

        // Act
        final result = await dataSource.getProfile();

        // Assert
        expect(result, isA<ProfileModel>());
        expect(result.id, '123');
        expect(result.name, 'Wael');
        expect(result.email, 'wael@example.com');
        expect(result.videoCount, 10);
        expect(result.totalViews, 500);

        verify(() => mockApiService.get(ApiConstants.profileMe)).called(1);
      });

      test('should throw ServerException when the API call fails', () async {
        // Arrange
        final serverException = ServerException(
          'Test server error',
          statusCode: 500,
        );

        when(
          () => mockApiService.get(ApiConstants.profileMe),
        ).thenThrow(serverException);

        // Act & Assert
        expect(() => dataSource.getProfile(), throwsA(same(serverException)));
      });
    });

    group('deleteProfile', () {
      test('should call delete API with the correct endpoint', () async {
        // Arrange
        when(() => mockApiService.delete(ApiConstants.profileMe)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ApiConstants.profileMe),
          ),
        );

        // Act
        await dataSource.deleteProfile();

        // Assert
        verify(() => mockApiService.delete(ApiConstants.profileMe)).called(1);
      });

      test(
        'should throw ServerException when the delete API call fails',
        () async {
          // Arrange
          final serverException = ServerException(
            'Test server error',
            statusCode: 500,
          );

          when(
            () => mockApiService.delete(ApiConstants.profileMe),
          ).thenThrow(serverException);

          // Act & Assert
          expect(
            () => dataSource.deleteProfile(),
            throwsA(same(serverException)),
          );
        },
      );
    });
  });

  group('updateProfile', () {
    test('should update profile with name only', () async {
      const updatedName = 'New Name';

      final response = Response(
        requestOptions: RequestOptions(path: ApiConstants.profileMe),
        data: {
          'data': {...profileJson, 'name': updatedName},
        },
      );

      when(
        () => mockApiService.patch(
          ApiConstants.profileMe,
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dataSource.updateProfile(name: updatedName);

      expect(result.name, updatedName);

      final payload = verify(
        () => mockApiService.patch(
          ApiConstants.profileMe,
          data: captureAny(named: 'data'),
        ),
      ).captured.single;

      expect(payload, {'name': updatedName});
    });
    test('should update profile with avatar only', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ApiConstants.profileMe),
        data: {
          'data': {
            ...profileJson,
            'avatarUrl': 'https://example.com/new-avatar.png',
          },
        },
      );

      when(
        () => mockApiService.patch(
          ApiConstants.profileMe,
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dataSource.updateProfile(
        avatarPath: avatarFile.path,
      );

      expect(result.avatarUrl, 'https://example.com/new-avatar.png');

      final payload =
          verify(
                () => mockApiService.patch(
                  ApiConstants.profileMe,
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as FormData;

      expect(payload.fields, isEmpty);
      expect(payload.files, hasLength(1));
      expect(payload.files.single.key, 'avatar');
      expect(payload.files.single.value.filename, 'avatar.png');
    });
    test('should update profile with name and avatar', () async {
      const updatedName = 'New Name';

      final response = Response(
        requestOptions: RequestOptions(path: ApiConstants.profileMe),
        data: {
          'data': {
            ...profileJson,
            'name': updatedName,
            'avatarUrl': 'https://example.com/new-avatar.png',
          },
        },
      );

      when(
        () => mockApiService.patch(
          ApiConstants.profileMe,
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dataSource.updateProfile(
        name: updatedName,
        avatarPath: avatarFile.path,
      );

      expect(result.name, updatedName);
      expect(result.avatarUrl, 'https://example.com/new-avatar.png');

      final payload =
          verify(
                () => mockApiService.patch(
                  ApiConstants.profileMe,
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as FormData;

      // Check name field.
      expect(payload.fields, hasLength(1));
      expect(payload.fields.single.key, 'name');
      expect(payload.fields.single.value, updatedName);

      // Check avatar file.
      expect(payload.files, hasLength(1));
      expect(payload.files.single.key, 'avatar');
      expect(payload.files.single.value.filename, 'avatar.png');
    });
    test('should propagate exception when API call fails', () async {
      final serverException = ServerException(
        'Test server error',
        statusCode: 500,
      );
      when(
        () => mockApiService.patch(
          ApiConstants.profileMe,
          data: any(named: 'data'),
        ),
      ).thenThrow(serverException);

      expect(
        () => dataSource.updateProfile(name: 'New Name'),
        throwsA(same(serverException)),
      );
    });
  });
}
