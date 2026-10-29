// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Videos you save for later will appear here.`
  String get watchLaterEmptyMessage {
    return Intl.message(
      'Videos you save for later will appear here.',
      name: 'watchLaterEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Watch History`
  String get watchHistory {
    return Intl.message(
      'Watch History',
      name: 'watchHistory',
      desc: '',
      args: [],
    );
  }

  /// `No watch history found \nStart watching videos to build your history`
  String get noWatchHistoryFoundMessage {
    return Intl.message(
      'No watch history found \nStart watching videos to build your history',
      name: 'noWatchHistoryFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Video`
  String get editVideo {
    return Intl.message('Edit Video', name: 'editVideo', desc: '', args: []);
  }

  /// `Delete video`
  String get deleteVideoTooltip {
    return Intl.message(
      'Delete video',
      name: 'deleteVideoTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Video deleted successfully`
  String get videoDeletedSuccessfully {
    return Intl.message(
      'Video deleted successfully',
      name: 'videoDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Video updated successfully`
  String get videoUpdatedSuccessfully {
    return Intl.message(
      'Video updated successfully',
      name: 'videoUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select a video file`
  String get pleaseSelectVideoFile {
    return Intl.message(
      'Please select a video file',
      name: 'pleaseSelectVideoFile',
      desc: '',
      args: [],
    );
  }

  /// `Please select a thumbnail image`
  String get pleaseSelectThumbnailImage {
    return Intl.message(
      'Please select a thumbnail image',
      name: 'pleaseSelectThumbnailImage',
      desc: '',
      args: [],
    );
  }

  /// `Video uploaded successfully!`
  String get videoUploadedSuccessfully {
    return Intl.message(
      'Video uploaded successfully!',
      name: 'videoUploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get uploadVideo {
    return Intl.message(
      'Upload Video',
      name: 'uploadVideo',
      desc: '',
      args: [],
    );
  }

  /// `Published`
  String get published {
    return Intl.message('Published', name: 'published', desc: '', args: []);
  }

  /// `Private`
  String get private {
    return Intl.message('Private', name: 'private', desc: '', args: []);
  }

  /// `Visible to everyone`
  String get visibleToEveryone {
    return Intl.message(
      'Visible to everyone',
      name: 'visibleToEveryone',
      desc: '',
      args: [],
    );
  }

  /// `Only you can see this video`
  String get onlyYouCanSeeThisVideo {
    return Intl.message(
      'Only you can see this video',
      name: 'onlyYouCanSeeThisVideo',
      desc: '',
      args: [],
    );
  }

  /// `Uploading...`
  String get uploading {
    return Intl.message('Uploading...', name: 'uploading', desc: '', args: []);
  }

  /// `Change thumbnail`
  String get changeThumbnail {
    return Intl.message(
      'Change thumbnail',
      name: 'changeThumbnail',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Video File *`
  String get videoFileRequired {
    return Intl.message(
      'Video File *',
      name: 'videoFileRequired',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select video`
  String get tapToSelectVideo {
    return Intl.message(
      'Tap to select video',
      name: 'tapToSelectVideo',
      desc: '',
      args: [],
    );
  }

  /// `MP4, MOV, MKV up to 500MB`
  String get videoFileFormats {
    return Intl.message(
      'MP4, MOV, MKV up to 500MB',
      name: 'videoFileFormats',
      desc: '',
      args: [],
    );
  }

  /// `Thumbnail Image *`
  String get thumbnailImageRequired {
    return Intl.message(
      'Thumbnail Image *',
      name: 'thumbnailImageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select thumbnail`
  String get tapToSelectThumbnail {
    return Intl.message(
      'Tap to select thumbnail',
      name: 'tapToSelectThumbnail',
      desc: '',
      args: [],
    );
  }

  /// `JPG, PNG (16:9 recommended)`
  String get thumbnailImageFormats {
    return Intl.message(
      'JPG, PNG (16:9 recommended)',
      name: 'thumbnailImageFormats',
      desc: '',
      args: [],
    );
  }

  /// `Start Upload`
  String get startUpload {
    return Intl.message(
      'Start Upload',
      name: 'startUpload',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message('Tags', name: 'tags', desc: '', args: []);
  }

  /// `Add a tag and press done`
  String get addTagAndPressDone {
    return Intl.message(
      'Add a tag and press done',
      name: 'addTagAndPressDone',
      desc: '',
      args: [],
    );
  }

  /// `Video Title *`
  String get videoTitleRequired {
    return Intl.message(
      'Video Title *',
      name: 'videoTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a catchy title`
  String get enterCatchyTitle {
    return Intl.message(
      'Enter a catchy title',
      name: 'enterCatchyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleIsRequired {
    return Intl.message(
      'Title is required',
      name: 'titleIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description *`
  String get descriptionRequired {
    return Intl.message(
      'Description *',
      name: 'descriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `What is this video about?`
  String get whatIsThisVideoAbout {
    return Intl.message(
      'What is this video about?',
      name: 'whatIsThisVideoAbout',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get descriptionIsRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Category *`
  String get categoryRequired {
    return Intl.message(
      'Category *',
      name: 'categoryRequired',
      desc: '',
      args: [],
    );
  }

  /// `Category is required`
  String get categoryIsRequired {
    return Intl.message(
      'Category is required',
      name: 'categoryIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Video saved to gallery!`
  String get videoSavedToGallery {
    return Intl.message(
      'Video saved to gallery!',
      name: 'videoSavedToGallery',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `Saved`
  String get saved {
    return Intl.message('Saved', name: 'saved', desc: '', args: []);
  }

  /// `Added`
  String get added {
    return Intl.message('Added', name: 'added', desc: '', args: []);
  }

  /// `Watch later`
  String get watchLater {
    return Intl.message('Watch later', name: 'watchLater', desc: '', args: []);
  }

  /// `Added to Watch later.`
  String get addedToWatchLater {
    return Intl.message(
      'Added to Watch later.',
      name: 'addedToWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `Removed from Watch later.`
  String get removedFromWatchLater {
    return Intl.message(
      'Removed from Watch later.',
      name: 'removedFromWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `No related videos found`
  String get noRelatedVideosFound {
    return Intl.message(
      'No related videos found',
      name: 'noRelatedVideosFound',
      desc: '',
      args: [],
    );
  }

  /// `subscribers`
  String get subscribers {
    return Intl.message('subscribers', name: 'subscribers', desc: '', args: []);
  }

  /// `views`
  String get views {
    return Intl.message('views', name: 'views', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Share link copied!`
  String get shareLinkCopied {
    return Intl.message(
      'Share link copied!',
      name: 'shareLinkCopied',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Related Videos`
  String get relatedVideos {
    return Intl.message(
      'Related Videos',
      name: 'relatedVideos',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `There are no subscriptions yet`
  String get noSubscriptionsYet {
    return Intl.message(
      'There are no subscriptions yet',
      name: 'noSubscriptionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Unknown device`
  String get unknownDevice {
    return Intl.message(
      'Unknown device',
      name: 'unknownDevice',
      desc: '',
      args: [],
    );
  }

  /// `Local`
  String get loginMethodLocal {
    return Intl.message('Local', name: 'loginMethodLocal', desc: '', args: []);
  }

  /// `Google`
  String get loginMethodGoogle {
    return Intl.message(
      'Google',
      name: 'loginMethodGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get loginMethodApple {
    return Intl.message('Apple', name: 'loginMethodApple', desc: '', args: []);
  }

  /// `Active now`
  String get activeNow {
    return Intl.message('Active now', name: 'activeNow', desc: '', args: []);
  }

  /// `Current Sessions`
  String get currentSessionsTitle {
    return Intl.message(
      'Current Sessions',
      name: 'currentSessionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unknown location`
  String get unknownLocation {
    return Intl.message(
      'Unknown location',
      name: 'unknownLocation',
      desc: '',
      args: [],
    );
  }

  /// `Last active`
  String get lastActive {
    return Intl.message('Last active', name: 'lastActive', desc: '', args: []);
  }

  /// `Signed in at`
  String get signedInAt {
    return Intl.message('Signed in at', name: 'signedInAt', desc: '', args: []);
  }

  /// `Expires at`
  String get expiresAtLabel {
    return Intl.message(
      'Expires at',
      name: 'expiresAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `IP address`
  String get ipAddressLabel {
    return Intl.message(
      'IP address',
      name: 'ipAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get appVersionLabel {
    return Intl.message(
      'App version',
      name: 'appVersionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutSession {
    return Intl.message('Logout', name: 'logoutSession', desc: '', args: []);
  }

  /// `Logout Session`
  String get logoutSessionConfirmTitle {
    return Intl.message(
      'Logout Session',
      name: 'logoutSessionConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout this session?`
  String get logoutSessionConfirmMessage {
    return Intl.message(
      'Are you sure you want to logout this session?',
      name: 'logoutSessionConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `These are the devices currently logged into your account.`
  String get currentSessionsSubtitle {
    return Intl.message(
      'These are the devices currently logged into your account.',
      name: 'currentSessionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No active sessions found.`
  String get noActiveSessionsMessage {
    return Intl.message(
      'No active sessions found.',
      name: 'noActiveSessionsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logout from all devices`
  String get logoutAllDevices {
    return Intl.message(
      'Logout from all devices',
      name: 'logoutAllDevices',
      desc: '',
      args: [],
    );
  }

  /// `Logout All Devices`
  String get logoutAllConfirmTitle {
    return Intl.message(
      'Logout All Devices',
      name: 'logoutAllConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout from all other devices? You will remain logged in on this device.`
  String get logoutAllConfirmMessage {
    return Intl.message(
      'Are you sure you want to logout from all other devices? You will remain logged in on this device.',
      name: 'logoutAllConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `No suggestions for "{query}"`
  String noSuggestionsFor(Object query) {
    return Intl.message(
      'No suggestions for "$query"',
      name: 'noSuggestionsFor',
      desc: '',
      args: [query],
    );
  }

  /// `Search videos...`
  String get searchVideosHint {
    return Intl.message(
      'Search videos...',
      name: 'searchVideosHint',
      desc: '',
      args: [],
    );
  }

  /// `Type to search videos...`
  String get typeToSearchVideos {
    return Intl.message(
      'Type to search videos...',
      name: 'typeToSearchVideos',
      desc: '',
      args: [],
    );
  }

  /// `No videos found for "{query}"`
  String noVideosFoundFor(Object query) {
    return Intl.message(
      'No videos found for "$query"',
      name: 'noVideosFoundFor',
      desc: '',
      args: [query],
    );
  }

  /// `Account Actions`
  String get accountActions {
    return Intl.message(
      'Account Actions',
      name: 'accountActions',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfilePage {
    return Intl.message(
      'Edit Profile',
      name: 'editProfilePage',
      desc: '',
      args: [],
    );
  }

  /// `Change Photo`
  String get changePhoto {
    return Intl.message(
      'Change Photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Full name is required`
  String get fullNameReq {
    return Intl.message(
      'Full name is required',
      name: 'fullNameReq',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Member since`
  String get memberSince {
    return Intl.message(
      'Member since',
      name: 'memberSince',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirm {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get deleteAccountMessage {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Videos`
  String get videosLabel {
    return Intl.message('Videos', name: 'videosLabel', desc: '', args: []);
  }

  /// `Total Views`
  String get totalViewsLabel {
    return Intl.message(
      'Total Views',
      name: 'totalViewsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Sessions`
  String get sessionsTab {
    return Intl.message('Sessions', name: 'sessionsTab', desc: '', args: []);
  }

  /// `Please enter a playlist name.`
  String get pleaseEnterPlaylistName {
    return Intl.message(
      'Please enter a playlist name.',
      name: 'pleaseEnterPlaylistName',
      desc: '',
      args: [],
    );
  }

  /// `Create new playlist`
  String get createNewPlaylist {
    return Intl.message(
      'Create new playlist',
      name: 'createNewPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `My playlist`
  String get myPlaylistHint {
    return Intl.message(
      'My playlist',
      name: 'myPlaylistHint',
      desc: '',
      args: [],
    );
  }

  /// `Description (optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `What is this playlist about?`
  String get whatIsThisPlaylistAbout {
    return Intl.message(
      'What is this playlist about?',
      name: 'whatIsThisPlaylistAbout',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Edit playlist`
  String get editPlaylist {
    return Intl.message(
      'Edit playlist',
      name: 'editPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load the playlist`
  String get failedToLoadPlaylist {
    return Intl.message(
      'Failed to load the playlist',
      name: 'failedToLoadPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `This playlist has no videos yet.`
  String get playlistHasNoVideosYet {
    return Intl.message(
      'This playlist has no videos yet.',
      name: 'playlistHasNoVideosYet',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get public {
    return Intl.message('Public', name: 'public', desc: '', args: []);
  }

  /// `videos`
  String get videos {
    return Intl.message('videos', name: 'videos', desc: '', args: []);
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `You have no playlists yet.`
  String get youHaveNoPlaylistsYet {
    return Intl.message(
      'You have no playlists yet.',
      name: 'youHaveNoPlaylistsYet',
      desc: '',
      args: [],
    );
  }

  /// `Save to playlist`
  String get saveToPlaylist {
    return Intl.message(
      'Save to playlist',
      name: 'saveToPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Anyone can watch this playlist`
  String get anyoneCanWatchThisPlaylist {
    return Intl.message(
      'Anyone can watch this playlist',
      name: 'anyoneCanWatchThisPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Only you can watch this playlist`
  String get onlyYouCanWatchThisPlaylist {
    return Intl.message(
      'Only you can watch this playlist',
      name: 'onlyYouCanWatchThisPlaylist',
      desc: '',
      args: [],
    );
  }

  /// `Delete playlist?`
  String get deletePlaylistTitle {
    return Intl.message(
      'Delete playlist?',
      name: 'deletePlaylistTitle',
      desc: '',
      args: [],
    );
  }

  /// `This playlist and its videos will be permanently removed. This can't be undone.`
  String get deletePlaylistMessage {
    return Intl.message(
      'This playlist and its videos will be permanently removed. This can\'t be undone.',
      name: 'deletePlaylistMessage',
      desc: '',
      args: [],
    );
  }

  /// `Playlist deleted.`
  String get playlistDeleted {
    return Intl.message(
      'Playlist deleted.',
      name: 'playlistDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Channel updated successfully`
  String get channelUpdatedSuccessfully {
    return Intl.message(
      'Channel updated successfully',
      name: 'channelUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Channel created successfully`
  String get channelCreatedSuccessfully {
    return Intl.message(
      'Channel created successfully',
      name: 'channelCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No Channel Found`
  String get noChannelFound {
    return Intl.message(
      'No Channel Found',
      name: 'noChannelFound',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a channel yet. Create one now to start sharing content with your audience.`
  String get noChannelFoundMessage {
    return Intl.message(
      'You don\'t have a channel yet. Create one now to start sharing content with your audience.',
      name: 'noChannelFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create Channel`
  String get createChannel {
    return Intl.message(
      'Create Channel',
      name: 'createChannel',
      desc: '',
      args: [],
    );
  }

  /// `Playlists`
  String get playlists {
    return Intl.message('Playlists', name: 'playlists', desc: '', args: []);
  }

  /// `Channel Title`
  String get channelTitle {
    return Intl.message(
      'Channel Title',
      name: 'channelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your channel name`
  String get enterYourChannelName {
    return Intl.message(
      'Enter your channel name',
      name: 'enterYourChannelName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Tell viewers about your channel`
  String get tellViewersAboutYourChannel {
    return Intl.message(
      'Tell viewers about your channel',
      name: 'tellViewersAboutYourChannel',
      desc: '',
      args: [],
    );
  }

  /// `Update Channel`
  String get updateChannel {
    return Intl.message(
      'Update Channel',
      name: 'updateChannel',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load your videos`
  String get failedToLoadYourVideos {
    return Intl.message(
      'Failed to load your videos',
      name: 'failedToLoadYourVideos',
      desc: '',
      args: [],
    );
  }

  /// `Draft`
  String get draft {
    return Intl.message('Draft', name: 'draft', desc: '', args: []);
  }

  /// `No videos yet`
  String get noVideosYet {
    return Intl.message(
      'No videos yet',
      name: 'noVideosYet',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load more videos`
  String get failedToLoadMoreVideos {
    return Intl.message(
      'Failed to load more videos',
      name: 'failedToLoadMoreVideos',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load subscribers`
  String get failedToLoadSubscribers {
    return Intl.message(
      'Failed to load subscribers',
      name: 'failedToLoadSubscribers',
      desc: '',
      args: [],
    );
  }

  /// `No subscribers yet`
  String get noSubscribersYet {
    return Intl.message(
      'No subscribers yet',
      name: 'noSubscribersYet',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load more subscribers`
  String get failedToLoadMoreSubscribers {
    return Intl.message(
      'Failed to load more subscribers',
      name: 'failedToLoadMoreSubscribers',
      desc: '',
      args: [],
    );
  }

  /// `No playlists yet`
  String get noPlaylistsYet {
    return Intl.message(
      'No playlists yet',
      name: 'noPlaylistsYet',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllAsRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllAsRead',
      desc: '',
      args: [],
    );
  }

  /// `Clear all notifications`
  String get clearAllNotifications {
    return Intl.message(
      'Clear all notifications',
      name: 'clearAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet`
  String get noNotificationsYet {
    return Intl.message(
      'No notifications yet',
      name: 'noNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Your Channel`
  String get yourChannel {
    return Intl.message(
      'Your Channel',
      name: 'yourChannel',
      desc: '',
      args: [],
    );
  }

  /// `StreamPro`
  String get streamPro {
    return Intl.message('StreamPro', name: 'streamPro', desc: '', args: []);
  }

  /// `Liked Videos`
  String get likedVideos {
    return Intl.message(
      'Liked Videos',
      name: 'likedVideos',
      desc: '',
      args: [],
    );
  }

  /// `You haven't liked any videos yet.`
  String get youHaventLikedAnyVideosYet {
    return Intl.message(
      'You haven\'t liked any videos yet.',
      name: 'youHaventLikedAnyVideosYet',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message('Library', name: 'library', desc: '', args: []);
  }

  /// `Everything you watched, saved and loved`
  String get librarySubtitle {
    return Intl.message(
      'Everything you watched, saved and loved',
      name: 'librarySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Videos you watch will show up here.`
  String get historyEmptyMessage {
    return Intl.message(
      'Videos you watch will show up here.',
      name: 'historyEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `No feeds available at the moment.`
  String get noFeedsAvailableAtTheMoment {
    return Intl.message(
      'No feeds available at the moment.',
      name: 'noFeedsAvailableAtTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `Profile is still loading.`
  String get profileIsStillLoading {
    return Intl.message(
      'Profile is still loading.',
      name: 'profileIsStillLoading',
      desc: '',
      args: [],
    );
  }

  /// `Edit comment`
  String get editComment {
    return Intl.message(
      'Edit comment',
      name: 'editComment',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get reply {
    return Intl.message('Reply', name: 'reply', desc: '', args: []);
  }

  /// `Add a public comment`
  String get addAPublicComment {
    return Intl.message(
      'Add a public comment',
      name: 'addAPublicComment',
      desc: '',
      args: [],
    );
  }

  /// `Edit your comment…`
  String get editYourComment {
    return Intl.message(
      'Edit your comment…',
      name: 'editYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Write a reply…`
  String get writeAReply {
    return Intl.message(
      'Write a reply…',
      name: 'writeAReply',
      desc: '',
      args: [],
    );
  }

  /// `What are your thoughts?`
  String get whatAreYourThoughts {
    return Intl.message(
      'What are your thoughts?',
      name: 'whatAreYourThoughts',
      desc: '',
      args: [],
    );
  }

  /// `Replying to @{userName}`
  String replyingTo(Object userName) {
    return Intl.message(
      'Replying to @$userName',
      name: 'replyingTo',
      desc: '',
      args: [userName],
    );
  }

  /// `You`
  String get you {
    return Intl.message('You', name: 'you', desc: '', args: []);
  }

  /// `Delete reply?`
  String get deleteReplyTitle {
    return Intl.message(
      'Delete reply?',
      name: 'deleteReplyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete comment?`
  String get deleteCommentTitle {
    return Intl.message(
      'Delete comment?',
      name: 'deleteCommentTitle',
      desc: '',
      args: [],
    );
  }

  /// `This reply will be permanently removed. This can't be undone.`
  String get deleteReplyMessage {
    return Intl.message(
      'This reply will be permanently removed. This can\'t be undone.',
      name: 'deleteReplyMessage',
      desc: '',
      args: [],
    );
  }

  /// `This comment will be permanently removed. This can't be undone.`
  String get deleteCommentMessage {
    return Intl.message(
      'This comment will be permanently removed. This can\'t be undone.',
      name: 'deleteCommentMessage',
      desc: '',
      args: [],
    );
  }

  /// `edited`
  String get edited {
    return Intl.message('edited', name: 'edited', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Posting reply…`
  String get postingReply {
    return Intl.message(
      'Posting reply…',
      name: 'postingReply',
      desc: '',
      args: [],
    );
  }

  /// `No replies yet.`
  String get noRepliesYet {
    return Intl.message(
      'No replies yet.',
      name: 'noRepliesYet',
      desc: '',
      args: [],
    );
  }

  /// `Hide replies`
  String get hideReplies {
    return Intl.message(
      'Hide replies',
      name: 'hideReplies',
      desc: '',
      args: [],
    );
  }

  /// `View {count} replies`
  String viewReplies(Object count) {
    return Intl.message(
      'View $count replies',
      name: 'viewReplies',
      desc: '',
      args: [count],
    );
  }

  /// `No comments yet. Be the first!`
  String get noCommentsYet {
    return Intl.message(
      'No comments yet. Be the first!',
      name: 'noCommentsYet',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load more comments`
  String get failedToLoadMoreComments {
    return Intl.message(
      'Failed to load more comments',
      name: 'failedToLoadMoreComments',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Failed to load channel playlists`
  String get failedToLoadChannelPlaylists {
    return Intl.message(
      'Failed to load channel playlists',
      name: 'failedToLoadChannelPlaylists',
      desc: '',
      args: [],
    );
  }

  /// `No playlists found`
  String get noPlaylistsFound {
    return Intl.message(
      'No playlists found',
      name: 'noPlaylistsFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load more playlists`
  String get failedToLoadMorePlaylists {
    return Intl.message(
      'Failed to load more playlists',
      name: 'failedToLoadMorePlaylists',
      desc: '',
      args: [],
    );
  }

  /// `No content available in this channel yet`
  String get noContentAvailableInThisChannelYet {
    return Intl.message(
      'No content available in this channel yet',
      name: 'noContentAvailableInThisChannelYet',
      desc: '',
      args: [],
    );
  }

  /// `Latest videos`
  String get latestVideos {
    return Intl.message(
      'Latest videos',
      name: 'latestVideos',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load channel videos`
  String get failedToLoadChannelVideos {
    return Intl.message(
      'Failed to load channel videos',
      name: 'failedToLoadChannelVideos',
      desc: '',
      args: [],
    );
  }

  /// `No videos found`
  String get noVideosFound {
    return Intl.message(
      'No videos found',
      name: 'noVideosFound',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message('Welcome to', name: 'welcomeTo', desc: '', args: []);
  }

  /// `StreamPro`
  String get appTitle {
    return Intl.message('StreamPro', name: 'appTitle', desc: '', args: []);
  }

  /// `Email is required`
  String get emailReq {
    return Intl.message(
      'Email is required',
      name: 'emailReq',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordReq {
    return Intl.message(
      'Password is required',
      name: 'passwordReq',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get invalidPassword {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPasswordReq {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordReq',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirmPasswordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'confirmPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully!`
  String get accountCreatedSuccessFully {
    return Intl.message(
      'Account created successfully!',
      name: 'accountCreatedSuccessFully',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully!`
  String get loginSuccessfully {
    return Intl.message(
      'Logged in successfully!',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Welcome back! Please enter your details.`
  String get loginSubtitle {
    return Intl.message(
      'Welcome back! Please enter your details.',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get registerNow {
    return Intl.message(
      'Register Now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Create an account to get started.`
  String get signupSubtitle {
    return Intl.message(
      'Create an account to get started.',
      name: 'signupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `No more items`
  String get noMoreItems {
    return Intl.message(
      'No more items',
      name: 'noMoreItems',
      desc: '',
      args: [],
    );
  }

  /// `No data available at the moment.`
  String get noDataAvailable {
    return Intl.message(
      'No data available at the moment.',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `LIVE`
  String get live {
    return Intl.message('LIVE', name: 'live', desc: '', args: []);
  }

  /// `Normal`
  String get normal {
    return Intl.message('Normal', name: 'normal', desc: '', args: []);
  }

  /// `Unable to play video`
  String get unableToPlayVideo {
    return Intl.message(
      'Unable to play video',
      name: 'unableToPlayVideo',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Watch later`
  String get removeFromWatchLater {
    return Intl.message(
      'Remove from Watch later',
      name: 'removeFromWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `Add to Watch later`
  String get addToWatchLater {
    return Intl.message(
      'Add to Watch later',
      name: 'addToWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `Share is coming soon.`
  String get shareComingSoon {
    return Intl.message(
      'Share is coming soon.',
      name: 'shareComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Already in Watch later.`
  String get alreadyInWatchLater {
    return Intl.message(
      'Already in Watch later.',
      name: 'alreadyInWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `Already removed from Watch later.`
  String get alreadyRemovedFromWatchLater {
    return Intl.message(
      'Already removed from Watch later.',
      name: 'alreadyRemovedFromWatchLater',
      desc: '',
      args: [],
    );
  }

  /// `This item will be permanently removed. This can't be undone.`
  String get deleteConfirmationMessage {
    return Intl.message(
      'This item will be permanently removed. This can\'t be undone.',
      name: 'deleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `watched`
  String get watched {
    return Intl.message('watched', name: 'watched', desc: '', args: []);
  }

  /// `Subscribed`
  String get subscribed {
    return Intl.message('Subscribed', name: 'subscribed', desc: '', args: []);
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message('Subscribe', name: 'subscribe', desc: '', args: []);
  }

  /// `M`
  String get million {
    return Intl.message('M', name: 'million', desc: '', args: []);
  }

  /// `K`
  String get thousand {
    return Intl.message('K', name: 'thousand', desc: '', args: []);
  }

  /// `y ago`
  String get yearsAgo {
    return Intl.message('y ago', name: 'yearsAgo', desc: '', args: []);
  }

  /// `mo ago`
  String get monthsAgo {
    return Intl.message('mo ago', name: 'monthsAgo', desc: '', args: []);
  }

  /// `d ago`
  String get daysAgo {
    return Intl.message('d ago', name: 'daysAgo', desc: '', args: []);
  }

  /// `h ago`
  String get hoursAgo {
    return Intl.message('h ago', name: 'hoursAgo', desc: '', args: []);
  }

  /// `m ago`
  String get minutesAgo {
    return Intl.message('m ago', name: 'minutesAgo', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Failed to save video to gallery`
  String get failedToSaveVideoToGallery {
    return Intl.message(
      'Failed to save video to gallery',
      name: 'failedToSaveVideoToGallery',
      desc: '',
      args: [],
    );
  }

  /// `Media storage permission denied`
  String get mediaStoragePermissionDenied {
    return Intl.message(
      'Media storage permission denied',
      name: 'mediaStoragePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout`
  String get connectionTimeout {
    return Intl.message(
      'Connection timeout',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout`
  String get sendTimeout {
    return Intl.message(
      'Send timeout',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout`
  String get receiveTimeout {
    return Intl.message(
      'Receive timeout',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Bad Certificate`
  String get badCertificate {
    return Intl.message(
      'Bad Certificate',
      name: 'badCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Request was canceled`
  String get requestCanceled {
    return Intl.message(
      'Request was canceled',
      name: 'requestCanceled',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error, Please try again!`
  String get unexpectedError {
    return Intl.message(
      'Unexpected Error, Please try again!',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server error, Please try later`
  String get internalServerError {
    return Intl.message(
      'Internal Server error, Please try later',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There was an Error, Please try again`
  String get oopsError {
    return Intl.message(
      'Oops! There was an Error, Please try again',
      name: 'oopsError',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in failed. Please try again.`
  String get googleSignInError {
    return Intl.message(
      'Google sign-in failed. Please try again.',
      name: 'googleSignInError',
      desc: '',
      args: [],
    );
  }

  /// `Google Sign-In is not configured correctly. Please check the app configuration.`
  String get googleSignInConfigError {
    return Intl.message(
      'Google Sign-In is not configured correctly. Please check the app configuration.',
      name: 'googleSignInConfigError',
      desc: '',
      args: [],
    );
  }

  /// `Path Not Found`
  String get pathNotFound {
    return Intl.message(
      'Path Not Found',
      name: 'pathNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Light`
  String get lightTheme {
    return Intl.message('Light', name: 'lightTheme', desc: '', args: []);
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message('Dark', name: 'darkTheme', desc: '', args: []);
  }

  /// `System`
  String get systemTheme {
    return Intl.message('System', name: 'systemTheme', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `english`
  String get english {
    return Intl.message('english', name: 'english', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
