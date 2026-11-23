import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';

void main() {
  group('ProfileEntity', () {
    test('copyWith should update name and keep other fields unchanged', () {
      // Arrange
      final now = DateTime.now();
      final user = ProfileEntity(
        id: '1',
        name: 'Ahmed',
        email: 'ahmed@gmail.com',
        avatarUrl: 'example.url.com',
        createdAt: now,
        updatedAt: now,
        videoCount: 5,
        totalViews: 200,
      );
      // Act
      final updatedUser = user.copyWith(name: 'Mohamed');

      // Assert
      expect(updatedUser.id, '1');
      expect(updatedUser.name, 'Mohamed');
      expect(updatedUser.email, 'ahmed@gmail.com');
      expect(updatedUser.avatarUrl, 'example.url.com');
      expect(updatedUser.createdAt, now);
      expect(updatedUser.updatedAt, now);
      expect(updatedUser.videoCount, 5);
      expect(updatedUser.totalViews, 200);
    });
    test(
      'copyWith should update avatarUrl and keep other fields unchanged',
      () {
        // Arrange
        final now = DateTime.now();
        final user = ProfileEntity(
          id: '1',
          name: 'Ahmed',
          email: 'ahmed@gmail.com',
          avatarUrl: 'example.url.com',
          createdAt: now,
          updatedAt: now,
          videoCount: 5,
          totalViews: 200,
        );
        // Act
        final updatedUser = user.copyWith(avatarUrl: 'updated.example.url.com');

        // Assert
        expect(updatedUser.id, '1');
        expect(updatedUser.name, 'Ahmed');
        expect(updatedUser.email, 'ahmed@gmail.com');
        expect(updatedUser.avatarUrl, 'updated.example.url.com');
        expect(updatedUser.createdAt, now);
        expect(updatedUser.updatedAt, now);
        expect(updatedUser.videoCount, 5);
        expect(updatedUser.totalViews, 200);
      },
    );
    test('copyWith should clear avatar and keep other fields unchanged', () {
      // Arrange
      final now = DateTime.now();
      final user = ProfileEntity(
        id: '1',
        name: 'Ahmed',
        email: 'ahmed@gmail.com',
        avatarUrl: 'example.url.com',
        createdAt: now,
        updatedAt: now,
        videoCount: 5,
        totalViews: 200,
      );
      // Act
      final updatedUser = user.copyWith(clearAvatar: true);

      // Assert
      expect(updatedUser.id, '1');
      expect(updatedUser.name, 'Ahmed');
      expect(updatedUser.email, 'ahmed@gmail.com');
      expect(updatedUser.avatarUrl, null);
      expect(updatedUser.createdAt, now);
      expect(updatedUser.updatedAt, now);
      expect(updatedUser.videoCount, 5);
      expect(updatedUser.totalViews, 200);
    });
    test('copyWith should keep entity unchanged', () {
      // Arrange
      final now = DateTime.now();
      final user = ProfileEntity(
        id: '1',
        name: 'Ahmed',
        email: 'ahmed@gmail.com',
        avatarUrl: 'example.url.com',
        createdAt: now,
        updatedAt: now,
        videoCount: 5,
        totalViews: 200,
      );
      // Act
      final updatedUser = user.copyWith();

      // Assert
      expect(updatedUser, user);
    });

    test('clearAvatar should take priority over new avatarUrl', () {
      // Arrange
      final user = ProfileEntity(
        id: '1',
        name: 'Ahmed',
        email: 'ahmed@gmail.com',
        avatarUrl: 'old.url.com',
        createdAt: DateTime(2026, 11, 4),
        updatedAt: DateTime(2026, 11, 4),
        videoCount: 5,
        totalViews: 200,
      );

      // Act
      final updatedUser = user.copyWith(
        avatarUrl: 'new.url.com',
        clearAvatar: true,
      );

      // Assert
      expect(updatedUser.avatarUrl, isNull);
    });
  });
}
