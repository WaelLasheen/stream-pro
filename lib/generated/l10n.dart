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

  /// `Day I`
  String get appTitle {
    return Intl.message('Day I', name: 'appTitle', desc: '', args: []);
  }

  /// `Hello World!`
  String get hello {
    return Intl.message('Hello World!', name: 'hello', desc: '', args: []);
  }

  /// `Welcome to Day I`
  String get welcomeMessage {
    return Intl.message(
      'Welcome to Day I',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
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

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login to manage book fairs and cultural events`
  String get loginSubtitle {
    return Intl.message(
      'Login to manage book fairs and cultural events',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get signup {
    return Intl.message(
      'Create New Account',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Create your account to manage your marketing campaigns smartly within minutes`
  String get signupSubtitle {
    return Intl.message(
      'Create your account to manage your marketing campaigns smartly within minutes',
      name: 'signupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
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

  /// `I agree to the terms and conditions and privacy policy`
  String get termsAndConditions {
    return Intl.message(
      'I agree to the terms and conditions and privacy policy',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
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

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
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

  /// `Forgot Password?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to reset your password.`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your email address to reset your password.',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get sendCode {
    return Intl.message(
      'Send Verification Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter Verification Code`
  String get otpTitle {
    return Intl.message(
      'Enter Verification Code',
      name: 'otpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code we sent to your email.`
  String get otpSubtitle {
    return Intl.message(
      'Enter the verification code we sent to your email.',
      name: 'otpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `We sent a 6-digit code to the email`
  String get otpEntryInstruction {
    return Intl.message(
      'We sent a 6-digit code to the email',
      name: 'otpEntryInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCode {
    return Intl.message('Verify Code', name: 'verifyCode', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Invalid verification code. Please try again.`
  String get otpInvalidError {
    return Intl.message(
      'Invalid verification code. Please try again.',
      name: 'otpInvalidError',
      desc: '',
      args: [],
    );
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

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
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

  /// `Full Name is required`
  String get fullNameReq {
    return Intl.message(
      'Full Name is required',
      name: 'fullNameReq',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneReq {
    return Intl.message(
      'Phone number is required',
      name: 'phoneReq',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirmPasswordReq {
    return Intl.message(
      'Confirm password is required',
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

  /// `Looking for a service...`
  String get searchHint {
    return Intl.message(
      'Looking for a service...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Prices`
  String get prices {
    return Intl.message('Prices', name: 'prices', desc: '', args: []);
  }

  /// `Choose package for your marketing campaign`
  String get choosePackage {
    return Intl.message(
      'Choose package for your marketing campaign',
      name: 'choosePackage',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a strong password to protect your account.`
  String get resetPasswordInstruction {
    return Intl.message(
      'Enter a strong password to protect your account.',
      name: 'resetPasswordInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Flexible packages to suit your business size and marketing goals`
  String get flexiblePackages {
    return Intl.message(
      'Flexible packages to suit your business size and marketing goals',
      name: 'flexiblePackages',
      desc: '',
      args: [],
    );
  }

  /// `Show details`
  String get showDetails {
    return Intl.message(
      'Show details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get startNow {
    return Intl.message('Start Now', name: 'startNow', desc: '', args: []);
  }

  /// `Create Your Company`
  String get createCompany {
    return Intl.message(
      'Create Your Company',
      name: 'createCompany',
      desc: '',
      args: [],
    );
  }

  /// `Start building your company's presence on the platform by entering its data.`
  String get createCompanySubtitle {
    return Intl.message(
      'Start building your company\'s presence on the platform by entering its data.',
      name: 'createCompanySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Company Name is required`
  String get companyNameReq {
    return Intl.message(
      'Company Name is required',
      name: 'companyNameReq',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Industry`
  String get industry {
    return Intl.message('Industry', name: 'industry', desc: '', args: []);
  }

  /// `Selected Plan`
  String get selectedPlan {
    return Intl.message(
      'Selected Plan',
      name: 'selectedPlan',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get actionButton {
    return Intl.message(
      'Create Account',
      name: 'actionButton',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information`
  String get contactInfo {
    return Intl.message(
      'Contact Information',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `FAQs`
  String get faqs {
    return Intl.message('FAQs', name: 'faqs', desc: '', args: []);
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// `Choose contact subject`
  String get chooseSubject {
    return Intl.message(
      'Choose contact subject',
      name: 'chooseSubject',
      desc: '',
      args: [],
    );
  }

  /// `User Message`
  String get userMessage {
    return Intl.message(
      'User Message',
      name: 'userMessage',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here`
  String get writeMessageHere {
    return Intl.message(
      'Write your message here',
      name: 'writeMessageHere',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get sendMessage {
    return Intl.message(
      'Send Message',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Markiva Contact Information`
  String get markivaContactInfo {
    return Intl.message(
      'Markiva Contact Information',
      name: 'markivaContactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Login Successfully`
  String get loginSuccessfully {
    return Intl.message(
      'Login Successfully',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account Created Successfully`
  String get accountCreatedSuccessFully {
    return Intl.message(
      'Account Created Successfully',
      name: 'accountCreatedSuccessFully',
      desc: '',
      args: [],
    );
  }

  /// `Search Location...`
  String get searchLocation {
    return Intl.message(
      'Search Location...',
      name: 'searchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure of logout?`
  String get logoutConfirm {
    return Intl.message(
      'Are you sure of logout?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `No services available`
  String get noServicesAvailable {
    return Intl.message(
      'No services available',
      name: 'noServicesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Confirm password does not match the new password`
  String get passwordDoesntMatch {
    return Intl.message(
      'Confirm password does not match the new password',
      name: 'passwordDoesntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Strong Password`
  String get passwordStrength {
    return Intl.message(
      'Strong Password',
      name: 'passwordStrength',
      desc: '',
      args: [],
    );
  }

  /// `Weak`
  String get weekPassword {
    return Intl.message('Weak', name: 'weekPassword', desc: '', args: []);
  }

  /// `Medium`
  String get mediumPassword {
    return Intl.message('Medium', name: 'mediumPassword', desc: '', args: []);
  }

  /// `Strong`
  String get strongPassword {
    return Intl.message('Strong', name: 'strongPassword', desc: '', args: []);
  }

  /// `Edit Contact Information`
  String get editProfileContacts {
    return Intl.message(
      'Edit Contact Information',
      name: 'editProfileContacts',
      desc: '',
      args: [],
    );
  }

  /// `Password Security`
  String get passwordSecurity {
    return Intl.message(
      'Password Security',
      name: 'passwordSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get editProfileChangePassword {
    return Intl.message(
      'Change Password',
      name: 'editProfileChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password for your account.`
  String get changePasswordInstruction {
    return Intl.message(
      'Enter a new password for your account.',
      name: 'changePasswordInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters.`
  String get passwordLength {
    return Intl.message(
      'Password must be at least 8 characters.',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Please do not use personal information or common words.`
  String get passwordNotPersonal {
    return Intl.message(
      'Please do not use personal information or common words.',
      name: 'passwordNotPersonal',
      desc: '',
      args: [],
    );
  }

  /// `It is recommended to use uppercase and lowercase letters and numbers.`
  String get passwordCaseAndNumbers {
    return Intl.message(
      'It is recommended to use uppercase and lowercase letters and numbers.',
      name: 'passwordCaseAndNumbers',
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

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Email Verified`
  String get emailVerified {
    return Intl.message(
      'Email Verified',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `Enter a strong password to protect your account`
  String get enterStrongPasswordToProtectYourAccount {
    return Intl.message(
      'Enter a strong password to protect your account',
      name: 'enterStrongPasswordToProtectYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message('Privacy', name: 'privacy', desc: '', args: []);
  }

  /// `Data Usage`
  String get dataUsage {
    return Intl.message('Data Usage', name: 'dataUsage', desc: '', args: []);
  }

  /// `Share order data with assigned service team only`
  String get shareDataTeamOnly {
    return Intl.message(
      'Share order data with assigned service team only',
      name: 'shareDataTeamOnly',
      desc: '',
      args: [],
    );
  }

  /// `Allow using data to improve service`
  String get allowDataImproveService {
    return Intl.message(
      'Allow using data to improve service',
      name: 'allowDataImproveService',
      desc: '',
      args: [],
    );
  }

  /// `Visibility Control`
  String get visibilityControl {
    return Intl.message(
      'Visibility Control',
      name: 'visibilityControl',
      desc: '',
      args: [],
    );
  }

  /// `Manager only`
  String get managerOnly {
    return Intl.message(
      'Manager only',
      name: 'managerOnly',
      desc: '',
      args: [],
    );
  }

  /// `Assigned service team`
  String get assignedTeam {
    return Intl.message(
      'Assigned service team',
      name: 'assignedTeam',
      desc: '',
      args: [],
    );
  }

  /// `Your parameters will not be visible to unauthorized employees.`
  String get unauthorizedNotVisible {
    return Intl.message(
      'Your parameters will not be visible to unauthorized employees.',
      name: 'unauthorizedNotVisible',
      desc: '',
      args: [],
    );
  }

  /// `Security Alerts`
  String get securityAlerts {
    return Intl.message(
      'Security Alerts',
      name: 'securityAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Alert on new login`
  String get alertNewLogin {
    return Intl.message(
      'Alert on new login',
      name: 'alertNewLogin',
      desc: '',
      args: [],
    );
  }

  /// `Alert on order status change`
  String get alertStatusChange {
    return Intl.message(
      'Alert on order status change',
      name: 'alertStatusChange',
      desc: '',
      args: [],
    );
  }

  /// `Account Control`
  String get accountControl {
    return Intl.message(
      'Account Control',
      name: 'accountControl',
      desc: '',
      args: [],
    );
  }

  /// `Download Data`
  String get downloadData {
    return Intl.message(
      'Download Data',
      name: 'downloadData',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate Account`
  String get deactivateAccount {
    return Intl.message(
      'Deactivate Account',
      name: 'deactivateAccount',
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

  /// `Account deletion requests are reviewed by the admin and processed within 14 days. This action is final and will delete all service records`
  String get deleteAccountWarning {
    return Intl.message(
      'Account deletion requests are reviewed by the admin and processed within 14 days. This action is final and will delete all service records',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `No FAQs currently available.`
  String get noFaqsAvailable {
    return Intl.message(
      'No FAQs currently available.',
      name: 'noFaqsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Service Register`
  String get serviceRegister {
    return Intl.message(
      'Service Register',
      name: 'serviceRegister',
      desc: '',
      args: [],
    );
  }

  /// `Search by service name or request number...`
  String get searchOrderHint {
    return Intl.message(
      'Search by service name or request number...',
      name: 'searchOrderHint',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Late`
  String get late {
    return Intl.message('Late', name: 'late', desc: '', args: []);
  }

  /// `Budget: {amount}`
  String budgetLabel(Object amount) {
    return Intl.message(
      'Budget: $amount',
      name: 'budgetLabel',
      desc: '',
      args: [amount],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `No orders found`
  String get noOrders {
    return Intl.message(
      'No orders found',
      name: 'noOrders',
      desc: '',
      args: [],
    );
  }

  /// `Employee: {name}`
  String employeeLabel(Object name) {
    return Intl.message(
      'Employee: $name',
      name: 'employeeLabel',
      desc: '',
      args: [name],
    );
  }

  /// `Budget`
  String get budget {
    return Intl.message('Budget', name: 'budget', desc: '', args: []);
  }

  /// `A smart platform for managing marketing`
  String get splashTagLine {
    return Intl.message(
      'A smart platform for managing marketing',
      name: 'splashTagLine',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message('next', name: 'next', desc: '', args: []);
  }

  /// `skip`
  String get skip {
    return Intl.message('skip', name: 'skip', desc: '', args: []);
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

  /// `No notifications currently`
  String get noNotificationsCurrently {
    return Intl.message(
      'No notifications currently',
      name: 'noNotificationsCurrently',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethod {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Cardholder Name`
  String get cardHolderName {
    return Intl.message(
      'Cardholder Name',
      name: 'cardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message('Card Number', name: 'cardNumber', desc: '', args: []);
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message('Expiry Date', name: 'expiryDate', desc: '', args: []);
  }

  /// `Security Code`
  String get securityCode {
    return Intl.message(
      'Security Code',
      name: 'securityCode',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postalCode {
    return Intl.message('Postal Code', name: 'postalCode', desc: '', args: []);
  }

  /// `Set as default payment card`
  String get setDefaultPayment {
    return Intl.message(
      'Set as default payment card',
      name: 'setDefaultPayment',
      desc: '',
      args: [],
    );
  }

  /// `Save payment method for later use`
  String get savePaymentForLater {
    return Intl.message(
      'Save payment method for later use',
      name: 'savePaymentForLater',
      desc: '',
      args: [],
    );
  }

  /// `Save Payment Method`
  String get savePaymentMethod {
    return Intl.message(
      'Save Payment Method',
      name: 'savePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Other payment methods`
  String get otherPaymentMethods {
    return Intl.message(
      'Other payment methods',
      name: 'otherPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get addCard {
    return Intl.message('Add card', name: 'addCard', desc: '', args: []);
  }

  /// `Continue Payment`
  String get continuePayment {
    return Intl.message(
      'Continue Payment',
      name: 'continuePayment',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder`
  String get cardHolder {
    return Intl.message('Card Holder', name: 'cardHolder', desc: '', args: []);
  }

  /// `Expires in`
  String get expiresIn {
    return Intl.message('Expires in', name: 'expiresIn', desc: '', args: []);
  }

  /// `Welcome to`
  String get welcomeTo {
    return Intl.message('Welcome to', name: 'welcomeTo', desc: '', args: []);
  }

  /// `A marketing management platform that combines team collaboration, task tracking, and performance analytics into a single interface.`
  String get markevaDescription {
    return Intl.message(
      'A marketing management platform that combines team collaboration, task tracking, and performance analytics into a single interface.',
      name: 'markevaDescription',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `Add a comment...`
  String get addComment {
    return Intl.message(
      'Add a comment...',
      name: 'addComment',
      desc: '',
      args: [],
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

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Edit Comment`
  String get editComment {
    return Intl.message(
      'Edit Comment',
      name: 'editComment',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Failed to load video. Please check your internet connection.`
  String get videoLoadError {
    return Intl.message(
      'Failed to load video. Please check your internet connection.',
      name: 'videoLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Link copied to clipboard!`
  String get shareCopied {
    return Intl.message(
      'Link copied to clipboard!',
      name: 'shareCopied',
      desc: '',
      args: [],
    );
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
