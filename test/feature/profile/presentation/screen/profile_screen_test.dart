import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_pro/core/app_config/app_config_cubit.dart';
import 'package:stream_pro/core/app_config/app_config_state.dart';
import 'package:stream_pro/core/services/file_picker/app_file_type.dart';
import 'package:stream_pro/core/services/file_picker/file_picker_service.dart';
import 'package:stream_pro/core/shared/widgets/app_buttons/app_button.dart';
import 'package:stream_pro/core/shared/widgets/network_image/app_circle_network_image.dart';
import 'package:stream_pro/core/theme/app_themes.dart';
import 'package:stream_pro/feature/profile/domain/entities/profile_entity.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_cubit.dart';
import 'package:stream_pro/feature/profile/presentation/controller/profile_cubit/profile_state.dart';
import 'package:stream_pro/feature/profile/presentation/screens/profile_screen.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_header_card.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_shimmer.dart';
import 'package:stream_pro/feature/sessions/presentation/controllers/sessions_cubit/sessions_cubit.dart';
import 'package:stream_pro/feature/sessions/presentation/controllers/sessions_cubit/sessions_state.dart';
import 'package:stream_pro/generated/l10n.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/feature/profile/presentation/widgets/profile_edit_sheet.dart';

// Mocks
class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockSessionsCubit extends MockCubit<SessionsState>
    implements SessionsCubit {}

class MockAppConfigCubit extends MockCubit<AppConfigState>
    implements AppConfigCubit {}

class MockFilePickerService extends Mock implements FilePickerService {}

void main() {
  late MockProfileCubit mockProfileCubit;
  late MockSessionsCubit mockSessionsCubit;
  late MockAppConfigCubit mockAppConfigCubit;
  late MockFilePickerService mockFilePickerService;

  final profile = ProfileEntity(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
    avatarUrl: null,
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 2, 1),
    videoCount: 12,
    totalViews: 85,
  );

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockSessionsCubit = MockSessionsCubit();
    mockAppConfigCubit = MockAppConfigCubit();
    mockFilePickerService = MockFilePickerService();

    // SettingsSection depends on AppConfigCubit.
    // We only need its initial state to build the UI.
    whenListen(
      mockAppConfigCubit,
      const Stream<AppConfigState>.empty(),
      initialState: const AppConfigState(
        locale: Locale('en'),
        currentTheme: AppThemeType.light,
      ),
    );
  });

  Future<void> pumpProfileScreen(
    WidgetTester tester, {
    required ProfileState profileState,
    Stream<ProfileState>? profileStateStream,
    SessionsState sessionsState = const SessionsLoaded(sessions: []),
    bool withPreviousRoute = false,
  }) async {
    whenListen(
      mockProfileCubit,
      profileStateStream ?? const Stream<ProfileState>.empty(),
      initialState: profileState,
    );

    whenListen(
      mockSessionsCubit,
      const Stream<SessionsState>.empty(),
      initialState: sessionsState,
    );

    final profileScreen = ProfileScreen(
      filePickerService: mockFilePickerService,
    );

    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
              BlocProvider<SessionsCubit>.value(value: mockSessionsCubit),
              BlocProvider<AppConfigCubit>.value(value: mockAppConfigCubit),
            ],
            child: MaterialApp(
              locale: const Locale('en'),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppThemes.getTheme(AppThemeType.light),
              onGenerateRoute: (settings) {
                if (settings.name == AppRoutes.login) {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (_) => const Scaffold(
                      body: Center(child: Text('Login Screen')),
                    ),
                  );
                }

                return null;
              },
              home: withPreviousRoute
                  ? Builder(
                      builder: (context) {
                        return Scaffold(
                          body: Center(
                            child: TextButton(
                              key: const Key('open_profile_route'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => profileScreen,
                                  ),
                                );
                              },
                              child: const Text('Open Profile'),
                            ),
                          ),
                        );
                      },
                    )
                  : profileScreen,
            ),
          );
        },
      ),
    );

    if (withPreviousRoute) {
      await tester.tap(find.byKey(const Key('open_profile_route')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
    }
  }

  group('ProfileScreen', () {
    // =========================================================
    // Loading
    // =========================================================

    testWidgets('should display ProfileShimmer when profile is loading', (
      tester,
    ) async {
      // Arrange & Act
      await pumpProfileScreen(tester, profileState: const ProfileLoading());

      // Assert
      expect(find.byType(ProfileShimmer), findsOneWidget);
    });

    // =========================================================
    // Loaded
    // =========================================================

    testWidgets('should display profile content when profile is loaded', (
      tester,
    ) async {
      // Arrange & Act
      await pumpProfileScreen(
        tester,
        profileState: ProfileLoaded(profile: profile),
      );

      // Scroll until account actions become visible.
      await tester.scrollUntilVisible(
        find.text(S.current.logout),
        300,
        scrollable: find
            .byWidgetPredicate(
              (widget) =>
                  widget is Scrollable &&
                  widget.axisDirection == AxisDirection.down,
            )
            .first,
      );

      // Assert
      expect(find.text(profile.name), findsOneWidget);
      expect(find.text(profile.email), findsOneWidget);

      expect(find.text(S.current.logout), findsOneWidget);
      expect(find.text(S.current.deleteAccount), findsOneWidget);
    });

    testWidgets('should refresh profile when pull down', (tester) async {
      // Arrange & Act
      when(() => mockProfileCubit.fetchProfile()).thenAnswer((_) async {});

      await pumpProfileScreen(
        tester,
        profileState: ProfileLoaded(profile: profile),
      );

      final profileScrollable = find
          .ancestor(
            of: find.byType(ProfileHeaderCard),
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is Scrollable &&
                  widget.axisDirection == AxisDirection.down,
            ),
          )
          .first;

      // Simulate pull-to-refresh.
      await tester.drag(profileScrollable, const Offset(0, 400));

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify refresh action.
      verify(() => mockProfileCubit.fetchProfile()).called(1);
    });

    // =========================================================
    // Error
    // =========================================================

    testWidgets(
      'should display error message and retry button when profile loading fails',
      (tester) async {
        // Arrange
        const errorMessage = 'Unable to load profile';

        when(() => mockProfileCubit.fetchProfile()).thenAnswer((_) async {});

        // Act
        await pumpProfileScreen(
          tester,
          profileState: const ProfileError(message: errorMessage),
        );

        // Assert
        expect(find.text(errorMessage), findsOneWidget);
        expect(find.text(S.current.retry), findsOneWidget);

        // Retry interaction
        await tester.tap(find.text(S.current.retry));
        await tester.pump();

        verify(() => mockProfileCubit.fetchProfile()).called(1);
      },
    );
  });

  Future<void> scrollToAccountAction(WidgetTester tester, Finder target) async {
    final profileScrollable = find
        .ancestor(
          of: find.byType(ProfileHeaderCard),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Scrollable &&
                widget.axisDirection == AxisDirection.down,
          ),
        )
        .first;

    await tester.scrollUntilVisible(target, 250, scrollable: profileScrollable);
  }

  group('Profile Account Actions', () {
    group('Logout Confirmation', () {
      testWidgets('should display logout confirmation dialog', (tester) async {
        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.logout));
        await tester.tap(find.text(S.current.logout));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(S.current.logoutConfirm), findsOneWidget);
      });

      testWidgets('should not logout when cancel is pressed', (tester) async {
        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.logout));
        await tester.tap(find.text(S.current.logout));
        await tester.pumpAndSettle();

        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(S.current.cancel),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);

        verifyNever(() => mockProfileCubit.logout());
      });

      testWidgets('should call logout when confirmation is pressed', (
        tester,
      ) async {
        when(() => mockProfileCubit.logout()).thenAnswer((_) async {});

        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.logout));
        await tester.tap(find.text(S.current.logout));
        await tester.pumpAndSettle();

        final confirmButton = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.widgetWithText(AppButton, S.current.logout),
        );

        await tester.tap(confirmButton);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
        verify(() => mockProfileCubit.logout()).called(1);
      });
    });

    group('Delete Account Confirmation', () {
      testWidgets('should display delete account confirmation dialog', (
        tester,
      ) async {
        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.deleteAccount));
        await tester.tap(find.text(S.current.deleteAccount));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text(S.current.deleteAccountMessage), findsOneWidget);
      });

      testWidgets('should not delete account when cancel is pressed', (
        tester,
      ) async {
        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.deleteAccount));
        await tester.tap(find.text(S.current.deleteAccount));
        await tester.pumpAndSettle();

        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text(S.current.cancel),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);

        verifyNever(() => mockProfileCubit.deleteAccount());
      });

      testWidgets('should call deleteAccount when confirmation is pressed', (
        tester,
      ) async {
        when(() => mockProfileCubit.deleteAccount()).thenAnswer((_) async {});

        await pumpProfileScreen(
          tester,
          profileState: ProfileLoaded(profile: profile),
        );

        await scrollToAccountAction(tester, find.text(S.current.deleteAccount));
        await tester.tap(find.text(S.current.deleteAccount));
        await tester.pumpAndSettle();

        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.widgetWithText(AppButton, S.current.delete),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
        verify(() => mockProfileCubit.deleteAccount()).called(1);
      });
    });
  });

  Future<void> verifyProfileInteractionsAreBlocked(WidgetTester tester) async {
    // Try opening Edit Profile.
    await tester.tap(
      find.byTooltip(S.current.editProfilePage),
      warnIfMissed: false,
    );

    await tester.pump();

    expect(find.byType(ProfileEditSheet), findsNothing);

    // Try switching to Sessions tab.
    await tester.tap(find.text(S.current.sessionsTab), warnIfMissed: false);

    await tester.pump(const Duration(milliseconds: 400));

    // Profile tab should remain active.
    expect(find.text(profile.name), findsOneWidget);
    expect(find.text(S.current.currentSessionsTitle), findsNothing);
  }

  group('Profile Operation Blocking', () {
    testWidgets('should block interactions while logging out', (tester) async {
      await pumpProfileScreen(
        tester,
        profileState: ProfileLoaded(profile: profile, isLoggingOut: true),
      );

      await verifyProfileInteractionsAreBlocked(tester);
    });

    testWidgets('should block interactions while deleting account', (
      tester,
    ) async {
      await pumpProfileScreen(
        tester,
        profileState: ProfileLoaded(profile: profile, isDeleting: true),
      );

      await verifyProfileInteractionsAreBlocked(tester);
    });
  });

  Future<void> verifyProfileBackNavigationIsBlocked(
    WidgetTester tester,
    ProfileState profileState,
  ) async {
    await pumpProfileScreen(
      tester,
      profileState: profileState,
      withPreviousRoute: true,
    );

    await tester.binding.handlePopRoute();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Open Profile'), findsNothing);
  }

  group('Profile Back Navigation Protection', () {
    testWidgets('should prevent back navigation while logging out', (
      tester,
    ) async {
      await verifyProfileBackNavigationIsBlocked(
        tester,
        ProfileLoaded(profile: profile, isLoggingOut: true),
      );
    });

    testWidgets('should prevent back navigation while deleting account', (
      tester,
    ) async {
      await verifyProfileBackNavigationIsBlocked(
        tester,
        ProfileLoaded(profile: profile, isDeleting: true),
      );
    });
  });

  Future<void> verifyNavigationStackCleared(
    WidgetTester tester, {
    required ProfileState operationState,
    required ProfileState completedState,
  }) async {
    final profileStateController = StreamController<ProfileState>();

    addTearDown(() async {
      await profileStateController.close();
    });

    await pumpProfileScreen(
      tester,
      profileState: operationState,
      profileStateStream: profileStateController.stream,
      withPreviousRoute: true,
    );

    // Initial navigation stack:
    // Previous Screen -> Profile Screen

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Open Profile'), findsNothing);

    // Complete the operation.
    profileStateController.add(completedState);

    // Process the stream event and navigation transition.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    // Login should replace the entire navigation stack.
    expect(find.text('Login Screen'), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(find.text('Open Profile'), findsNothing);

    // Try going back after reaching Login.
    await tester.binding.handlePopRoute();

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    // Previous routes should no longer exist in the stack.
    expect(find.text('Login Screen'), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(find.text('Open Profile'), findsNothing);
  }

  group('Profile Navigation After Successful Operations', () {
    testWidgets(
      'should navigate to Login and clear stack after successful logout',
      (tester) async {
        await verifyNavigationStackCleared(
          tester,
          operationState: ProfileLoaded(profile: profile, isLoggingOut: true),
          completedState: const ProfileLoggedOut(),
        );
      },
    );

    testWidgets(
      'should navigate to Login and clear stack after successful account deletion',
      (tester) async {
        await verifyNavigationStackCleared(
          tester,
          operationState: ProfileLoaded(profile: profile, isDeleting: true),
          completedState: const ProfileDeleted(),
        );
      },
    );
  });

  Future<void> pumpProfileEditSheet(
    WidgetTester tester, {
    required ProfileEntity profile,
    required ProfileState initialState,
    required ProfileCubit profileCubit,
    required FilePickerService filePickerService,
    Stream<ProfileState>? profileStateStream,
  }) async {
    whenListen(
      profileCubit,
      profileStateStream ?? const Stream<ProfileState>.empty(),
      initialState: initialState,
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [BlocProvider<ProfileCubit>.value(value: profileCubit)],
            child: MaterialApp(
              locale: const Locale('en'),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: AppThemes.getTheme(AppThemeType.light),
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return Center(
                      child: TextButton(
                        key: const Key('open-edit-sheet'),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => ProfileEditSheet(
                              profile: profile,
                              filePickerService: filePickerService,
                            ),
                          );
                        },
                        child: const Text('Open Edit Sheet'),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );

    await tester.tap(find.byKey(const Key('open-edit-sheet')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }

  String createTestImageFile() {
    final directory = Directory.systemTemp.createTempSync('profile_edit_test');

    addTearDown(() {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }
    });

    final imageFile = File('${directory.path}/avatar.png');

    final imageBytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+j1XcAAAAASUVORK5CYII=',
    );

    imageFile.writeAsBytesSync(imageBytes);

    return imageFile.path;
  }

  group('ProfileEditSheet Widget Tests', () {
    late MockProfileCubit mockEditProfileCubit;
    late MockFilePickerService mockEditFilePickerService;

    late ProfileEntity editProfile;

    setUp(() {
      mockEditProfileCubit = MockProfileCubit();
      mockEditFilePickerService = MockFilePickerService();

      editProfile = profile.copyWith(avatarUrl: null);

      when(
        () => mockEditProfileCubit.updateProfile(
          name: any(named: 'name'),
          avatarPath: any(named: 'avatarPath'),
        ),
      ).thenAnswer((_) async {});
    });

    testWidgets('should display the current profile data', (tester) async {
      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      expect(find.text(S.current.editProfilePage), findsOneWidget);
      expect(find.text(editProfile.name), findsOneWidget);
      expect(find.byType(AppCircleNetworkImage), findsOneWidget);
      expect(find.widgetWithText(AppButton, S.current.cancel), findsOneWidget);
      expect(
        find.widgetWithText(AppButton, S.current.saveChanges),
        findsOneWidget,
      );
    });

    testWidgets('should close the sheet when Cancel is pressed', (
      tester,
    ) async {
      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.tap(find.widgetWithText(AppButton, S.current.cancel));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(ProfileEditSheet), findsNothing);
      expect(find.text('Open Edit Sheet'), findsOneWidget);

      verifyNever(
        () => mockEditProfileCubit.updateProfile(
          name: any(named: 'name'),
          avatarPath: any(named: 'avatarPath'),
        ),
      );
    });

    testWidgets('should show validation error when name is empty', (
      tester,
    ) async {
      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.enterText(find.byType(TextFormField), '');

      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));
      await tester.pump();

      expect(find.text(S.current.fullNameReq), findsOneWidget);
      expect(find.byType(ProfileEditSheet), findsOneWidget);

      verifyNever(
        () => mockEditProfileCubit.updateProfile(
          name: any(named: 'name'),
          avatarPath: any(named: 'avatarPath'),
        ),
      );
    });

    testWidgets('should show validation error when name contains only spaces', (
      tester,
    ) async {
      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.enterText(find.byType(TextFormField), '   ');

      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));
      await tester.pump();

      expect(find.text(S.current.fullNameReq), findsOneWidget);

      verifyNever(
        () => mockEditProfileCubit.updateProfile(
          name: any(named: 'name'),
          avatarPath: any(named: 'avatarPath'),
        ),
      );
    });
    testWidgets('should request an image from FilePickerService', (
      tester,
    ) async {
      when(
        () => mockEditFilePickerService.pickFile(type: AppFileType.image),
      ).thenAnswer((_) async => null);

      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.tap(find.byType(AppCircleNetworkImage));
      await tester.pumpAndSettle();

      verify(
        () => mockEditFilePickerService.pickFile(type: AppFileType.image),
      ).called(1);
    });

    testWidgets(
      'should show loading and prevent another image pick while picking',
      (tester) async {
        final completer = Completer<String?>();

        when(
          () => mockEditFilePickerService.pickFile(type: AppFileType.image),
        ).thenAnswer((_) => completer.future);

        await pumpProfileEditSheet(
          tester,
          profile: editProfile,
          initialState: ProfileLoaded(profile: editProfile),
          profileCubit: mockEditProfileCubit,
          filePickerService: mockEditFilePickerService,
        );

        await tester.tap(find.byType(AppCircleNetworkImage));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // A second tap should not start another picker request.
        await tester.tap(find.byType(AppCircleNetworkImage));
        await tester.pump();

        verify(
          () => mockEditFilePickerService.pickFile(type: AppFileType.image),
        ).called(1);

        completer.complete(null);

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets('should update the name only', (tester) async {
      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.enterText(find.byType(TextFormField), 'Updated Name');

      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));

      verify(
        () => mockEditProfileCubit.updateProfile(
          name: 'Updated Name',
          avatarPath: null,
        ),
      ).called(1);
    });

    testWidgets('should update the avatar only', (tester) async {
      final avatarPath = createTestImageFile();

      when(
        () => mockEditFilePickerService.pickFile(type: AppFileType.image),
      ).thenAnswer((_) async => avatarPath);

      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.tap(find.byType(AppCircleNetworkImage));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));

      verify(
        () => mockEditProfileCubit.updateProfile(
          name: editProfile.name,
          avatarPath: avatarPath,
        ),
      ).called(1);
    });

    testWidgets('should update both name and avatar', (tester) async {
      final avatarPath = createTestImageFile();

      when(
        () => mockEditFilePickerService.pickFile(type: AppFileType.image),
      ).thenAnswer((_) async => avatarPath);

      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
      );

      await tester.enterText(find.byType(TextFormField), 'Updated Name');

      await tester.tap(find.byType(AppCircleNetworkImage));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));

      verify(
        () => mockEditProfileCubit.updateProfile(
          name: 'Updated Name',
          avatarPath: avatarPath,
        ),
      ).called(1);
    });

    testWidgets(
      'should keep the avatar unchanged when image picking is cancelled',
      (tester) async {
        when(
          () => mockEditFilePickerService.pickFile(type: AppFileType.image),
        ).thenAnswer((_) async => null);

        await pumpProfileEditSheet(
          tester,
          profile: editProfile,
          initialState: ProfileLoaded(profile: editProfile),
          profileCubit: mockEditProfileCubit,
          filePickerService: mockEditFilePickerService,
        );

        await tester.tap(find.byType(AppCircleNetworkImage));
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));

        verify(
          () => mockEditProfileCubit.updateProfile(
            name: editProfile.name,
            avatarPath: null,
          ),
        ).called(1);
      },
    );
    testWidgets('should close the sheet when profile update starts', (
      tester,
    ) async {
      final stateController = StreamController<ProfileState>();

      addTearDown(() => stateController.close());

      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
        profileStateStream: stateController.stream,
      );

      await tester.enterText(find.byType(TextFormField), 'Updated Name');

      await tester.tap(find.widgetWithText(AppButton, S.current.saveChanges));

      verify(
        () => mockEditProfileCubit.updateProfile(
          name: 'Updated Name',
          avatarPath: null,
        ),
      ).called(1);

      // Simulate the Cubit emitting isSaving = true.
      stateController.add(ProfileLoaded(profile: editProfile, isSaving: true));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(ProfileEditSheet), findsNothing);
      expect(find.text('Open Edit Sheet'), findsOneWidget);
    });
    testWidgets('should close the sheet when an ongoing update finishes', (
      tester,
    ) async {
      final stateController = StreamController<ProfileState>();

      addTearDown(() => stateController.close());

      await pumpProfileEditSheet(
        tester,
        profile: editProfile,
        initialState: ProfileLoaded(profile: editProfile, isSaving: true),
        profileCubit: mockEditProfileCubit,
        filePickerService: mockEditFilePickerService,
        profileStateStream: stateController.stream,
      );

      expect(find.byType(ProfileEditSheet), findsOneWidget);

      // Simulate the update finishing.
      stateController.add(ProfileLoaded(profile: editProfile));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(ProfileEditSheet), findsNothing);
    });
  });
}
