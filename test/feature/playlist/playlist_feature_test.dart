import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/feature/playlist/data/models/playlist_details_model.dart';
import 'package:stream_pro/feature/playlist/data/models/video_playlist_model.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/video_playlist_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/create_playlist_cubit/create_playlist_state.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_state.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/video_playlists_cubit/video_playlists_state.dart';

import 'fake_playlist_repository.dart';

PlaylistDetailsEntity details({
  required List<PlaylistVideoEntity> videos,
  String title = 'My Playlist',
  bool isPublic = false,
}) {
  return PlaylistDetailsEntity(
    playlistId: 'p1',
    title: title,
    isPublic: isPublic,
    videoCount: videos.length,
    videos: videos,
  );
}

void main() {
  group('PlaylistDetailsModel', () {
    // Payload of `GET /api/v1/playlists/{playlistId}`
    final payload = <String, dynamic>{
      'playlistId': '23ddf71e-ddbf-45b1-a348-1947afe9049f',
      'title': 'fun',
      'description': null,
      'isPublic': true,
      'videoCount': 2,
      'items': [
        {
          'videoId': '406689c4-069e-4548-8b01-1436b74aaa0c',
          'title': 'Sleep 😴 💤',
          'thumbnailUrl': 'https://img/1.jpg',
          'durationSeconds': 8,
          'views': 7,
          'createdAt': '2026-09-18T15:17:50.317Z',
          'channelId': '454223b9-334d-4fce-81fd-ddedb706cad9',
          'channelTitle': 'Code With Me',
          'channelImageUrl': 'https://img/avatar.jpg',
        },
        {
          'videoId': '5568b81c-2eaa-4ff8-8a57-44b8dc756e30',
          'title': 'The Boys',
          'thumbnailUrl': 'https://img/2.jpg',
          'durationSeconds': 17,
          'views': 11,
          'createdAt': '2026-09-07T04:28:43.113Z',
          'channelId': '454223b9-334d-4fce-81fd-ddedb706cad9',
          'channelTitle': 'Code With Me',
          'channelImageUrl': 'https://img/avatar.jpg',
        },
      ],
    };

    test('parses the playlist information', () {
      final model = PlaylistDetailsModel.fromJson(payload);

      expect(model.playlistId, '23ddf71e-ddbf-45b1-a348-1947afe9049f');
      expect(model.title, 'fun');
      expect(model.description, isNull);
      expect(model.isPublic, isTrue);
      expect(model.videoCount, 2);
    });

    test('parses the videos with their channel information', () {
      final model = PlaylistDetailsModel.fromJson(payload);

      expect(model.items.length, 2);
      final first = model.items.first;
      expect(first.videoId, '406689c4-069e-4548-8b01-1436b74aaa0c');
      expect(first.title, 'Sleep 😴 💤');
      expect(first.durationSeconds, 8);
      expect(first.views, 7);
      expect(first.channelId, '454223b9-334d-4fce-81fd-ddedb706cad9');
      expect(first.channelTitle, 'Code With Me');
      expect(first.channelImageUrl, 'https://img/avatar.jpg');
    });

    test('maps the entity keeping the order of the videos', () {
      final entity = PlaylistDetailsModel.fromJson(payload).toEntity();

      expect(entity.playlistId, '23ddf71e-ddbf-45b1-a348-1947afe9049f');
      expect(entity.title, 'fun');
      expect(entity.isPublic, isTrue);
      expect(entity.videoCount, 2);
      expect(entity.videos.length, 2);
      expect(
        entity.videos.first.videoId,
        '406689c4-069e-4548-8b01-1436b74aaa0c',
      );
      expect(entity.videos.last.views, 11);
    });

    test('tolerates an empty playlist', () {
      final entity = PlaylistDetailsModel.fromJson(const {
        'playlistId': '1',
        'title': 'Empty',
        'isPublic': false,
        'videoCount': 0,
        'items': <dynamic>[],
      }).toEntity();

      expect(entity.title, 'Empty');
      expect(entity.videos, isEmpty);
    });
  });

  group('VideoPlaylistModel', () {
    test('reads the playlist id, visibility and hasVideo flag', () {
      final model = VideoPlaylistModel.fromJson(const {
        'playlistId': '1',
        'title': 'Watch later',
        'isPublic': true,
        'hasVideo': true,
      });

      expect(model.playlistId, '1');
      expect(model.isPublic, isTrue);
      expect(model.hasVideo, isTrue);

      final entity = model.toEntity();
      expect(entity.playlistId, '1');
      expect(entity.isPublic, isTrue);
      expect(entity.hasVideo, isTrue);
    });
  });

  group('VideoPlaylistsCubit', () {
    test('loads the playlists of a video', () async {
      final repo = FakePlaylistRepository()
        ..playlistsForVideo = const [
          VideoPlaylistEntity(
            playlistId: '1',
            title: 'A',
            isPublic: false,
            hasVideo: true,
          ),
          VideoPlaylistEntity(
            playlistId: '2',
            title: 'B',
            isPublic: true,
            hasVideo: false,
          ),
        ];
      final cubit = buildVideoPlaylistsCubit(repo);

      await cubit.loadPlaylists('v1');

      final state = cubit.state;
      expect(state, isA<VideoPlaylistsLoaded>());
      expect(state.playlists.length, 2);
      expect(state.playlists.first.hasVideo, isTrue);
      expect(state.playlists.last.hasVideo, isFalse);

      await cubit.close();
    });

    test('adds the video optimistically and keeps it on success', () async {
      final repo = FakePlaylistRepository()
        ..playlistsForVideo = const [
          VideoPlaylistEntity(
            playlistId: '1',
            title: 'A',
            isPublic: false,
            hasVideo: false,
          ),
        ];
      final cubit = buildVideoPlaylistsCubit(repo);
      await cubit.loadPlaylists('v1');

      final future = cubit.togglePlaylist(
        repo.playlistsForVideo.first,
        videoId: 'v1',
      );
      // Optimistic update is visible before the request resolves.
      expect(cubit.state.playlists.first.hasVideo, isTrue);
      expect(cubit.state.pendingPlaylistIds, {'1'});

      await future;

      expect(cubit.state.playlists.first.hasVideo, isTrue);
      expect(repo.addedVideos, ['1/v1']);

      await cubit.close();
    });

    test('removes the video optimistically', () async {
      final repo = FakePlaylistRepository()
        ..playlistsForVideo = const [
          VideoPlaylistEntity(
            playlistId: '1',
            title: 'A',
            isPublic: false,
            hasVideo: true,
          ),
        ];
      final cubit = buildVideoPlaylistsCubit(repo);
      await cubit.loadPlaylists('v1');

      await cubit.togglePlaylist(repo.playlistsForVideo.first, videoId: 'v1');

      expect(cubit.state.playlists.first.hasVideo, isFalse);
      expect(repo.removedVideos, ['1/v1']);

      await cubit.close();
    });

    test('rolls the flag back when the request fails', () async {
      final repo = FakePlaylistRepository()
        ..failAdd = true
        ..playlistsForVideo = const [
          VideoPlaylistEntity(
            playlistId: '1',
            title: 'A',
            isPublic: false,
            hasVideo: false,
          ),
        ];
      final cubit = buildVideoPlaylistsCubit(repo);
      await cubit.loadPlaylists('v1');

      await cubit.togglePlaylist(repo.playlistsForVideo.first, videoId: 'v1');

      final state = cubit.state;
      expect(state, isA<VideoPlaylistsFailure>());
      expect(state.playlists.first.hasVideo, isFalse);
      expect((state as VideoPlaylistsFailure).errorMessage, 'request failed');
      expect(state.pendingPlaylistIds, isEmpty);

      await cubit.close();
    });

    test('registers a freshly created playlist as holding the video', () async {
      final repo = FakePlaylistRepository();
      final cubit = buildVideoPlaylistsCubit(repo);
      await cubit.loadPlaylists('v1');

      cubit.addCreatedPlaylist(
        const VideoPlaylistEntity(
          playlistId: '9',
          title: 'New',
          isPublic: false,
          hasVideo: true,
        ),
      );

      expect(cubit.state.playlists.length, 1);
      expect(cubit.state.playlists.first.hasVideo, isTrue);

      await cubit.close();
    });
  });

  group('PlaylistDetailsCubit', () {
    test('fetches the playlist and its videos', () async {
      final repo = FakePlaylistRepository()
        ..playlist = details(
          title: 'My Playlist',
          videos: [testVideo('v1'), testVideo('v2')],
        );
      final cubit = buildPlaylistDetailsCubit(repo);

      await cubit.fetch('p1');

      final state = cubit.state;
      expect(state, isA<PlaylistDetailsLoaded>());
      expect(state.playlist!.videos.length, 2);
      expect(state.playlist!.title, 'My Playlist');

      await cubit.close();
    });

    test('reorders the videos and persists the new order', () async {
      final repo = FakePlaylistRepository()
        ..playlist = details(
          videos: [testVideo('v1'), testVideo('v2'), testVideo('v3')],
        );
      final cubit = buildPlaylistDetailsCubit(repo);
      await cubit.fetch('p1');

      await cubit.reorderVideos(0, 3);

      expect(
        cubit.state.playlist!.videos.map((video) => video.videoId).toList(),
        ['v2', 'v3', 'v1'],
      );
      expect(repo.reorderCalls.last, ['v2', 'v3', 'v1']);

      await cubit.close();
    });

    test('restores the previous order when persisting fails', () async {
      final repo = FakePlaylistRepository()
        ..failReorder = true
        ..playlist = details(videos: [testVideo('v1'), testVideo('v2')]);
      final cubit = buildPlaylistDetailsCubit(repo);
      await cubit.fetch('p1');

      await cubit.reorderVideos(0, 2);

      final state = cubit.state;
      expect(state.playlist!.videos.map((video) => video.videoId).toList(), [
        'v1',
        'v2',
      ]);
      expect((state as PlaylistDetailsFailure).errorMessage, 'request failed');

      await cubit.close();
    });

    test('removes a video optimistically and restores it on failure', () async {
      final repo = FakePlaylistRepository()
        ..failRemove = true
        ..playlist = details(videos: [testVideo('v1'), testVideo('v2')]);
      final cubit = buildPlaylistDetailsCubit(repo);
      await cubit.fetch('p1');

      await cubit.removeVideo('v1');

      final state = cubit.state;
      expect(state.playlist!.videos.length, 2);
      expect(state.playlist!.videos.first.videoId, 'v1');
      expect((state as PlaylistDetailsFailure).errorMessage, 'request failed');

      await cubit.close();
    });

    test(
      'removes a video optimistically before the request resolves',
      () async {
        final repo = FakePlaylistRepository()
          ..playlist = details(videos: [testVideo('v1'), testVideo('v2')]);
        final cubit = buildPlaylistDetailsCubit(repo);
        await cubit.fetch('p1');

        final future = cubit.removeVideo('v1');
        expect(cubit.state.playlist!.videos.length, 1);

        await future;

        expect(cubit.state.playlist!.videos.single.videoId, 'v2');
        expect(repo.removedVideos, ['p1/v1']);

        await cubit.close();
      },
    );

    test(
      'updates the playlist optimistically and rolls back on failure',
      () async {
        final repo = FakePlaylistRepository()
          ..failUpdate = true
          ..playlist = details(title: 'Old', videos: [testVideo('v1')]);
        final cubit = buildPlaylistDetailsCubit(repo);
        await cubit.fetch('p1');

        await cubit.updatePlaylist(title: 'New');

        final state = cubit.state;
        expect(state, isA<PlaylistDetailsFailure>());
        expect(state.playlist!.title, 'Old');
        expect(
          (state as PlaylistDetailsFailure).errorMessage,
          'request failed',
        );

        await cubit.close();
      },
    );

    test('deletes the playlist', () async {
      final repo = FakePlaylistRepository()..playlist = details(videos: []);
      final cubit = buildPlaylistDetailsCubit(repo);
      await cubit.fetch('p1');

      await cubit.deletePlaylist();

      expect(cubit.state, isA<PlaylistDetailsDeleted>());

      await cubit.close();
    });
  });

  group('CreatePlaylistCubit', () {
    test('creates the playlist and saves the video into it', () async {
      final repo = FakePlaylistRepository();
      final cubit = buildCreatePlaylistCubit(repo);

      await cubit.create(
        title: 'New',
        videoId: 'v1',
        description: 'A description',
        isPublic: true,
      );

      final state = cubit.state;
      expect(state, isA<CreatePlaylistSuccess>());
      state as CreatePlaylistSuccess;
      expect(state.playlistId, 'new');
      expect(state.title, 'New');
      expect(state.isPublic, isTrue);
      expect(repo.createdTitles, ['New']);
      expect(repo.addedVideos, ['new/v1']);

      await cubit.close();
    });

    test('fails when the playlist itself cannot be created', () async {
      final repo = FakePlaylistRepository()..failCreate = true;
      final cubit = buildCreatePlaylistCubit(repo);

      await cubit.create(title: 'New', videoId: 'v1');

      expect(cubit.state, isA<CreatePlaylistFailure>());
      expect(
        (cubit.state as CreatePlaylistFailure).errorMessage,
        'request failed',
      );
      expect(repo.addedVideos, isEmpty);

      await cubit.close();
    });

    test('fails when the video cannot be added to the new playlist', () async {
      final repo = FakePlaylistRepository()..failAdd = true;
      final cubit = buildCreatePlaylistCubit(repo);

      await cubit.create(title: 'New', videoId: 'v1');

      expect(cubit.state, isA<CreatePlaylistFailure>());
      expect(
        (cubit.state as CreatePlaylistFailure).errorMessage,
        'request failed',
      );
      expect(repo.createdTitles, ['New']);
      expect(repo.addedVideos, isEmpty);

      await cubit.close();
    });
  });
}
