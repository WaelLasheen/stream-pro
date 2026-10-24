import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_pro/core/theme/app_themes.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_details_entity.dart';
import 'package:stream_pro/feature/playlist/domain/entities/playlist_video_entity.dart';
import 'package:stream_pro/feature/playlist/presentation/args/playlist_details_args.dart';
import 'package:stream_pro/feature/playlist/presentation/controllers/playlist_details_cubit/playlist_details_cubit.dart';
import 'package:stream_pro/feature/playlist/presentation/screens/playlist_details_screen.dart';
import 'package:stream_pro/feature/playlist/presentation/widgets/playlist_header_shimmer.dart';

import 'fake_playlist_repository.dart';

PlaylistDetailsEntity details({
  required List<PlaylistVideoEntity> videos,
  String title = 'My Playlist',
  String? description,
  bool isPublic = false,
}) {
  return PlaylistDetailsEntity(
    playlistId: 'p1',
    title: title,
    description: description,
    isPublic: isPublic,
    videoCount: videos.length,
    videos: videos,
  );
}

/// Enough videos for the list to be scrollable in the test viewport.
List<PlaylistVideoEntity> _videos(int count) =>
    List.generate(count, (index) => testVideo('v$index'));

Future<PlaylistDetailsCubit> _pumpScreen(
  WidgetTester tester, {
  required FakePlaylistRepository repo,
  bool isOwner = false,
  bool load = true,
}) async {
  final cubit = buildPlaylistDetailsCubit(repo);
  if (load) await cubit.fetch('p1');

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        theme: AppThemes().lightTheme,
        home: BlocProvider.value(
          value: cubit,
          child: PlaylistDetailsScreen(
            args: PlaylistDetailsArgs('p1', isOwner: isOwner),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  return cubit;
}

Future<void> _collapseHeader(WidgetTester tester) async {
  await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
  await tester.pumpAndSettle();
}

/// Pushes the screen as a route so its pop result can be observed.
Future<({PlaylistDetailsCubit cubit, Future<bool?> result})> _pushScreen(
  WidgetTester tester, {
  required FakePlaylistRepository repo,
}) async {
  final cubit = buildPlaylistDetailsCubit(repo);
  await cubit.fetch('p1');

  late Future<bool?> result;

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        theme: AppThemes().lightTheme,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  result = Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: PlaylistDetailsScreen(
                          args: PlaylistDetailsArgs('p1', isOwner: true),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();

  return (cubit: cubit, result: result);
}

void main() {
  testWidgets('renders the header and the videos of the playlist', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(
        title: 'My Playlist',
        description: 'A description',
        isPublic: true,
        videos: [
          testVideo('v1', title: 'First video'),
          testVideo('v2', title: 'Second video'),
        ],
      );

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    expect(find.text('My Playlist'), findsOneWidget);
    expect(find.text('A description'), findsOneWidget);
    expect(find.text('Public'), findsOneWidget);
    expect(find.text('• 2 videos'), findsOneWidget);

    expect(find.text('First video'), findsOneWidget);
    expect(find.text('Second video'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('the owner sees the edit and delete buttons', (tester) async {
    final repo = FakePlaylistRepository()..playlist = details(videos: []);

    final cubit = await _pumpScreen(tester, repo: repo, isOwner: true);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);

    await cubit.close();
  });

  testWidgets('a viewer does not see the owner actions', (tester) async {
    final repo = FakePlaylistRepository()..playlist = details(videos: []);

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit_outlined), findsNothing);
    expect(find.byIcon(Icons.delete_outline), findsNothing);

    await cubit.close();
  });

  testWidgets('shows the drag handle only for the owner', (tester) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: [testVideo('v1', title: 'First video')]);

    final ownerCubit = await _pumpScreen(tester, repo: repo, isOwner: true);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.drag_handle), findsOneWidget);
    await ownerCubit.close();

    final viewerCubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.drag_handle), findsNothing);
    await viewerCubit.close();
  });

  testWidgets('dragging the handle reorders and persists the videos', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(
        videos: [
          testVideo('v1', title: 'First video'),
          testVideo('v2', title: 'Second video'),
        ],
      );

    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    final cubit = await _pumpScreen(tester, repo: repo, isOwner: true);
    await tester.pumpAndSettle();

    final handle = find.byIcon(Icons.drag_handle).first;
    final gesture = await tester.startGesture(tester.getCenter(handle));
    await tester.pump(const Duration(milliseconds: 100));
    for (var i = 0; i < 12; i++) {
      await gesture.moveBy(const Offset(0, 40));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();

    expect(
      cubit.state.playlist!.videos.map((video) => video.videoId).toList(),
      ['v2', 'v1'],
    );
    expect(repo.reorderCalls.last, ['v2', 'v1']);

    await cubit.close();
  });

  testWidgets('shows an empty state when the playlist has no videos', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()..playlist = details(videos: []);

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    expect(find.text('This playlist has no videos yet.'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('shows the playlist title in the app bar once collapsed', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: _videos(6));

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    final titleKey = const Key('playlistAppBarTitle');
    expect(find.byKey(titleKey), findsNothing);

    await _collapseHeader(tester);

    expect(find.byKey(titleKey), findsOneWidget);
    final opacity = tester.widget<Opacity>(
      find
          .ancestor(of: find.byKey(titleKey), matching: find.byType(Opacity))
          .first,
    );
    expect(opacity.opacity, closeTo(1.0, 0.01));

    await cubit.close();
  });

  testWidgets('the collapsed app bar shows the back arrow', (tester) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: _videos(6));

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('playlistAppBarBack')), findsNothing);

    await _collapseHeader(tester);

    expect(find.byKey(const Key('playlistAppBarBack')), findsOneWidget);

    await cubit.close();
  });

  testWidgets('the owner gets edit and delete in the collapsed app bar', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: _videos(6));

    final cubit = await _pumpScreen(tester, repo: repo, isOwner: true);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('playlistAppBarEdit')), findsNothing);
    expect(find.byKey(const Key('playlistAppBarDelete')), findsNothing);

    await _collapseHeader(tester);

    expect(find.byKey(const Key('playlistAppBarEdit')), findsOneWidget);
    expect(find.byKey(const Key('playlistAppBarDelete')), findsOneWidget);

    await cubit.close();
  });

  testWidgets('a viewer gets no actions in the collapsed app bar', (
    tester,
  ) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: _videos(6));

    final cubit = await _pumpScreen(tester, repo: repo);
    await tester.pumpAndSettle();

    await _collapseHeader(tester);

    expect(find.byKey(const Key('playlistAppBarBack')), findsOneWidget);
    expect(find.byKey(const Key('playlistAppBarEdit')), findsNothing);
    expect(find.byKey(const Key('playlistAppBarDelete')), findsNothing);

    await cubit.close();
  });

  testWidgets('shows the header shimmer while loading', (tester) async {
    final repo = FakePlaylistRepository();

    final cubit = await _pumpScreen(tester, repo: repo, load: false);
    await tester.pump();

    expect(find.byType(PlaylistHeaderShimmer), findsOneWidget);

    await cubit.close();
  });

  testWidgets('pops with true and confirms the deletion', (tester) async {
    final repo = FakePlaylistRepository()
      ..playlist = details(videos: [testVideo('v1')]);

    final pushed = await _pushScreen(tester, repo: repo);

    await pushed.cubit.deletePlaylist();
    await tester.pumpAndSettle();

    expect(await pushed.result, isTrue);
    expect(find.text('Playlist deleted.'), findsOneWidget);

    await pushed.cubit.close();
  });
}
