import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/feature/owner_channel/data/models/owner_playlist_model.dart';

void main() {
  group('OwnerPlaylistModel', () {
    test('parses the owner endpoint shape', () {
      final model = OwnerPlaylistModel.fromJson(const {
        'id': '42',
        'title': 'My Playlist',
        'description': 'desc',
        'isPublic': false,
        'createdAt': '2024-01-01T00:00:00.000Z',
        'updatedAt': '2024-01-02T00:00:00.000Z',
        'videoCount': 2,
        'videos': [
          {'id': 'v1', 'thumbnailUrl': 'https://img/1.jpg'},
          {'id': 'v2', 'thumbnailUrl': 'https://img/2.jpg'},
        ],
      });

      expect(model.id, '42');
      expect(model.title, 'My Playlist');
      expect(model.description, 'desc');
      expect(model.isPublic, isFalse);
      expect(model.videoCount, 2);
      expect(model.thumbnails, ['https://img/1.jpg', 'https://img/2.jpg']);
      expect(model.createdAt, isNotNull);
    });

    test('defaults the optional fields', () {
      final model = OwnerPlaylistModel.fromJson(const {
        'id': '42',
        'title': 'T',
        'videos': <Map<String, dynamic>>[],
      });

      expect(model.description, isNull);
      expect(model.isPublic, isFalse);
      expect(model.videoCount, 0);
      expect(model.thumbnails, isEmpty);
      expect(model.createdAt, isNotNull);
    });

    test('skips videos without a thumbnail', () {
      final model = OwnerPlaylistModel.fromJson(const {
        'id': '1',
        'title': 'T',
        'videos': [
          {'id': 'v1', 'thumbnailUrl': null},
          {'id': 'v2', 'thumbnailUrl': 'https://img/2.jpg'},
        ],
      });

      expect(model.thumbnails, ['https://img/2.jpg']);
    });

    test('maps the entity', () {
      final entity = OwnerPlaylistModel.fromJson(const {
        'id': '9',
        'title': 'T',
        'isPublic': true,
        'videoCount': 3,
        'videos': [
          {'id': 'v1', 'thumbnailUrl': 'https://img/1.jpg'},
        ],
      }).toEntity();

      expect(entity.id, '9');
      expect(entity.isPublic, isTrue);
      expect(entity.videoCount, 3);
      expect(entity.thumbnails, ['https://img/1.jpg']);
    });
  });
}
