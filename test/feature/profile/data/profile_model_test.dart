import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/feature/profile/data/models/profile_model.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';

void main() {
  group('ProfileModel', () {
    test('should create a ProfileModel from valid JSON', () {
      // Arrange
      final json = {
        'id': '123',
        'name': 'Wael',
        'email': 'wael@example.com',
        'avatarUrl': 'https://example.com/avatar.jpg',
        'createdAt': '2025-01-01T10:00:00.000Z',
        'updatedAt': '2025-02-01T10:00:00.000Z',
        'videoCount': 10,
        'totalViews': 500,
      };

      final expectedModel = ProfileModel(
        id: '123',
        name: 'Wael',
        email: 'wael@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        createdAt: DateTime.parse('2025-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2025-02-01T10:00:00.000Z'),
        videoCount: 10,
        totalViews: 500,
      );

      // Act
      final result = ProfileModel.fromJson(json);

      // Assert
      expect(result.id, expectedModel.id);
      expect(result.name, expectedModel.name);
      expect(result.email, expectedModel.email);
      expect(result.avatarUrl, expectedModel.avatarUrl);
      expect(result.createdAt, expectedModel.createdAt);
      expect(result.updatedAt, expectedModel.updatedAt);
      expect(result.videoCount, expectedModel.videoCount);
      expect(result.totalViews, expectedModel.totalViews);
    });

    test('should convert ProfileModel to ProfileEntity', () {
      // Arrange
      final model = ProfileModel(
        id: '123',
        name: 'Wael',
        email: 'wael@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        createdAt: DateTime.parse('2025-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2025-02-01T10:00:00.000Z'),
        videoCount: 10,
        totalViews: 500,
      );

      final expectedEntity = ProfileEntity(
        id: '123',
        name: 'Wael',
        email: 'wael@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        createdAt: DateTime.parse('2025-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2025-02-01T10:00:00.000Z'),
        videoCount: 10,
        totalViews: 500,
      );

      // Act
      final result = model.toEntity();

      // Assert
      expect(result, expectedEntity);
    });
  });

  test('should use default values when optional JSON fields are null', () {
    // Arrange
    final json = {
      'id': '123',
      'name': null,
      'email': null,
      'avatarUrl': null,
      'createdAt': '2025-01-01T10:00:00.000Z',
      'updatedAt': '2025-02-01T10:00:00.000Z',
      'videoCount': null,
      'totalViews': null,
    };

    final expectedModel = ProfileModel(
      id: '123',
      name: '',
      email: '',
      avatarUrl: null,
      createdAt: DateTime.parse('2025-01-01T10:00:00.000Z'),
      updatedAt: DateTime.parse('2025-02-01T10:00:00.000Z'),
      videoCount: 0,
      totalViews: 0,
    );

    // Act
    final result = ProfileModel.fromJson(json);

    // Assert
    expect(result.id, expectedModel.id);
    expect(result.name, expectedModel.name);
    expect(result.email, expectedModel.email);
    expect(result.avatarUrl, expectedModel.avatarUrl);
    expect(result.createdAt, expectedModel.createdAt);
    expect(result.updatedAt, expectedModel.updatedAt);
    expect(result.videoCount, expectedModel.videoCount);
    expect(result.totalViews, expectedModel.totalViews);
  });

  test('should use current date when updatedAt is missing', () {
    // Arrange
    final json = {
      'id': '123',
      'name': 'Wael',
      'email': 'wael@example.com',
      'avatarUrl': null,
      'createdAt': '2025-01-01T10:00:00.000Z',
      'videoCount': 10,
      'totalViews': 500,
    };

    final beforeParsing = DateTime.now();

    // Act
    final result = ProfileModel.fromJson(json);

    final afterParsing = DateTime.now();

    // Assert
    expect(
      result.updatedAt.isBefore(beforeParsing) ||
          result.updatedAt.isAtSameMomentAs(beforeParsing),
      isFalse,
    );

    expect(
      result.updatedAt.isAfter(afterParsing) ||
          result.updatedAt.isAtSameMomentAs(afterParsing),
      isFalse,
    );
  });
}
