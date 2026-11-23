import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:stream_pro/core/error/exceptions/server_exception.dart';
import 'package:stream_pro/core/error/failures/server_failure.dart';

import 'package:stream_pro/feature/profile/data/datasources/profile_remote_datasource.dart';
import 'package:stream_pro/feature/profile/data/models/profile_model.dart';
import 'package:stream_pro/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';

// Mock
class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

void main() {
  late MockProfileRemoteDataSource mockRemoteDataSource;
  late ProfileRepositoryImpl repository;

  // Test data
  final createdAt = DateTime(2025, 1, 1);
  final updatedAt = DateTime(2025, 2, 1);

  final profileModel = ProfileModel(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
    avatarUrl: 'https://example.com/avatar.png',
    createdAt: createdAt,
    updatedAt: updatedAt,
    videoCount: 10,
    totalViews: 500,
  );

  final expectedProfile = ProfileEntity(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
    avatarUrl: 'https://example.com/avatar.png',
    createdAt: createdAt,
    updatedAt: updatedAt,
    videoCount: 10,
    totalViews: 500,
  );

  const serverException = ServerException('Server error', statusCode: 500);

  const expectedFailure = ServerFailure('Server error', statusCode: 500);

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getProfile', () {
    test(
      'should return ProfileEntity when remote data source succeeds',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getProfile(),
        ).thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.getProfile();

        // Assert
        expect(result.isRight(), isTrue);

        final entity = result.fold((_) => null, (profile) => profile);

        expect(entity, isNotNull);
        expect(entity, expectedProfile);

        verify(() => mockRemoteDataSource.getProfile()).called(1);
      },
    );

    test('should return ServerFailure when remote data source fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.getProfile()).thenThrow(serverException);

      // Act
      final result = await repository.getProfile();

      // Assert
      expect(result.isLeft(), isTrue);

      final failure = result.fold((failure) => failure, (_) => null);

      expect(failure, isNotNull);
      expect(failure, expectedFailure);

      verify(() => mockRemoteDataSource.getProfile()).called(1);
    });
  });

  group('updateProfile', () {
    const updatedName = 'Updated Name';
    const avatarPath = '/tmp/avatar.png';

    test(
      'should return ProfileEntity when remote data source succeeds',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.updateProfile(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).thenAnswer((_) async => profileModel);

        // Act
        final result = await repository.updateProfile(
          name: updatedName,
          avatarPath: avatarPath,
        );

        // Assert
        expect(result.isRight(), isTrue);

        final entity = result.fold((_) => null, (profile) => profile);

        expect(entity, isNotNull);
        expect(entity, expectedProfile);

        verify(
          () => mockRemoteDataSource.updateProfile(
            name: updatedName,
            avatarPath: avatarPath,
          ),
        ).called(1);
      },
    );

    test('should return ServerFailure when remote data source fails', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.updateProfile(
          name: updatedName,
          avatarPath: avatarPath,
        ),
      ).thenThrow(serverException);

      // Act
      final result = await repository.updateProfile(
        name: updatedName,
        avatarPath: avatarPath,
      );

      // Assert
      expect(result.isLeft(), isTrue);

      final failure = result.fold((failure) => failure, (_) => null);

      expect(failure, isNotNull);
      expect(failure, expectedFailure);

      verify(
        () => mockRemoteDataSource.updateProfile(
          name: updatedName,
          avatarPath: avatarPath,
        ),
      ).called(1);
    });
  });

  group('deleteProfile', () {
    test('should return Right when remote data source succeeds', () async {
      // Arrange
      when(() => mockRemoteDataSource.deleteProfile()).thenAnswer((_) async {});

      // Act
      final result = await repository.deleteProfile();

      // Assert
      expect(result.isRight(), isTrue);

      verify(() => mockRemoteDataSource.deleteProfile()).called(1);
    });

    test('should return ServerFailure when remote data source fails', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.deleteProfile(),
      ).thenThrow(serverException);

      // Act
      final result = await repository.deleteProfile();

      // Assert
      expect(result.isLeft(), isTrue);

      final failure = result.fold((failure) => failure, (_) => null);

      expect(failure, isNotNull);
      expect(failure, expectedFailure);

      verify(() => mockRemoteDataSource.deleteProfile()).called(1);
    });
  });
}
