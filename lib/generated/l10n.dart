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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: 'Sets the title for the login button',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: 'Sets the title for the register button',
      args: [],
    );
  }

  /// `Wrong Username or Password`
  String get loginFailed {
    return Intl.message(
      'Wrong Username or Password',
      name: 'loginFailed',
      desc: 'Sets the text for the error when login fails.',
      args: [],
    );
  }

  /// `Email is already registered`
  String get emailAlreadyInUse {
    return Intl.message(
      'Email is already registered',
      name: 'emailAlreadyInUse',
      desc:
          'Sets the error text when trying to use an email already registered.',
      args: [],
    );
  }

  /// `Username is empty`
  String get usernameEmpty {
    return Intl.message(
      'Username is empty',
      name: 'usernameEmpty',
      desc:
          'Sets the error text when the user forget to set an username during registration.',
      args: [],
    );
  }

  /// `Email is empty`
  String get emailEmpty {
    return Intl.message(
      'Email is empty',
      name: 'emailEmpty',
      desc:
          'Sets the error text when the user forget to set an email during registration.',
      args: [],
    );
  }

  /// `Email is not valid`
  String get invalidEmail {
    return Intl.message(
      'Email is not valid',
      name: 'invalidEmail',
      desc:
          'Sets the error text when the user writes an invalid email during registration.',
      args: [],
    );
  }

  /// `Password is empty`
  String get passwordEmpty {
    return Intl.message(
      'Password is empty',
      name: 'passwordEmpty',
      desc:
          'Sets the error text when the user forget to set a password during registration.',
      args: [],
    );
  }

  /// `Password must have at least 8 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must have at least 8 characters',
      name: 'passwordTooShort',
      desc: 'Sets the error text when the user choose a short password.',
      args: [],
    );
  }

  /// `The two password doesn't match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'The two password doesn\'t match',
      name: 'passwordDoesNotMatch',
      desc: 'Sets the error text when the two password doesn\'t match.',
      args: [],
    );
  }

  /// `Password is too common...please choose another one`
  String get passwordTooCommon {
    return Intl.message(
      'Password is too common...please choose another one',
      name: 'passwordTooCommon',
      desc:
          'Sets the error text when trying to use a password that is too common.',
      args: [],
    );
  }

  /// `Username is already taken...please choose another one`
  String get usernameNotUnique {
    return Intl.message(
      'Username is already taken...please choose another one',
      name: 'usernameNotUnique',
      desc:
          'Sets the error text when trying to use a password that is too common.',
      args: [],
    );
  }

  /// `Ok`
  String get dialogOkButton {
    return Intl.message(
      'Ok',
      name: 'dialogOkButton',
      desc: 'Sets the button text when an alert dialog is launched.',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message(
      'Error',
      name: 'dialogErrorTitle',
      desc: 'Sets the alert dialog title in case of error.',
      args: [],
    );
  }

  /// `Registration`
  String get registrationDialogTitle {
    return Intl.message(
      'Registration',
      name: 'registrationDialogTitle',
      desc: 'Sets the alert dialog title after successfully registering.',
      args: [],
    );
  }

  /// `Username`
  String get usernameHint {
    return Intl.message(
      'Username',
      name: 'usernameHint',
      desc: 'Sets the hint for the username field.',
      args: [],
    );
  }

  /// `Email`
  String get emailHint {
    return Intl.message(
      'Email',
      name: 'emailHint',
      desc: 'Sets the hint for the email field.',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: 'Sets the hint for the password field.',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHint',
      desc: 'Sets the hint for the confirm password field.',
      args: [],
    );
  }

  /// `Registration was successfull...Username: {username} Id: {id} Email:{email}`
  String registrationDialogContent(String username, int id, String email) {
    final NumberFormat idNumberFormat =
        NumberFormat.decimalPattern(Intl.getCurrentLocale());
    final String idString = idNumberFormat.format(id);

    return Intl.message(
      'Registration was successfull...Username: $username Id: $idString Email:$email',
      name: 'registrationDialogContent',
      desc: 'Sets the alert dialog content after successfully registering.',
      args: [username, idString, email],
    );
  }

  /// `User is not authorized`
  String get unauthorizedError {
    return Intl.message(
      'User is not authorized',
      name: 'unauthorizedError',
      desc: 'Sets the error message when the user is not authorized',
      args: [],
    );
  }

  /// `Couldn't refresh access token...try to log-in again`
  String get refreshAccessTokenFailure {
    return Intl.message(
      'Couldn\'t refresh access token...try to log-in again',
      name: 'refreshAccessTokenFailure',
      desc:
          'Sets the error message when the application fails to refresh the access token',
      args: [],
    );
  }

  /// `User Info`
  String get homeScreenTitle {
    return Intl.message(
      'User Info',
      name: 'homeScreenTitle',
      desc: 'Sets the app bar title for the home screen',
      args: [],
    );
  }

  /// `Settings`
  String get settingsScreenTitle {
    return Intl.message(
      'Settings',
      name: 'settingsScreenTitle',
      desc: 'Sets the app bar title for the settings screen',
      args: [],
    );
  }

  /// `User`
  String get homeScreenUserInfoEntry {
    return Intl.message(
      'User',
      name: 'homeScreenUserInfoEntry',
      desc: 'Sets the navigation bar entry for the home screen user screen',
      args: [],
    );
  }

  /// `Settings`
  String get homeScreenSettingsEntry {
    return Intl.message(
      'Settings',
      name: 'homeScreenSettingsEntry',
      desc: 'Sets the navigation bar entry for the home screen settings screen',
      args: [],
    );
  }

  /// `General`
  String get settingsScreenCommonEntry {
    return Intl.message(
      'General',
      name: 'settingsScreenCommonEntry',
      desc: 'Sets the group title for the common settings screen',
      args: [],
    );
  }

  /// `Language`
  String get settingsScreenLanguageEntry {
    return Intl.message(
      'Language',
      name: 'settingsScreenLanguageEntry',
      desc: 'Sets the app bar title for the language entry',
      args: [],
    );
  }

  /// `Theme`
  String get settingsScreenThemeEntry {
    return Intl.message(
      'Theme',
      name: 'settingsScreenThemeEntry',
      desc: 'Sets the settings title for the theme entry',
      args: [],
    );
  }

  /// `Use system theme`
  String get settingsScreenThemeSystemEntry {
    return Intl.message(
      'Use system theme',
      name: 'settingsScreenThemeSystemEntry',
      desc: 'Describes the system theme entry',
      args: [],
    );
  }

  /// `Use light theme`
  String get settingsScreenThemeLightEntry {
    return Intl.message(
      'Use light theme',
      name: 'settingsScreenThemeLightEntry',
      desc: 'Describes the light theme entry',
      args: [],
    );
  }

  /// `Use dark theme`
  String get settingsScreenThemeDarkEntry {
    return Intl.message(
      'Use dark theme',
      name: 'settingsScreenThemeDarkEntry',
      desc: 'Describes the dark theme entry',
      args: [],
    );
  }

  /// `User Info`
  String get homeScreenUserInfoTitle {
    return Intl.message(
      'User Info',
      name: 'homeScreenUserInfoTitle',
      desc: 'Sets the title for the user info page',
      args: [],
    );
  }

  /// `Failed to perform logout...token may have been revoked`
  String get logoutFailure {
    return Intl.message(
      'Failed to perform logout...token may have been revoked',
      name: 'logoutFailure',
      desc: 'Sets the error message when logging out fails',
      args: [],
    );
  }

  /// `Logout`
  String get logoutButtonTextEntry {
    return Intl.message(
      'Logout',
      name: 'logoutButtonTextEntry',
      desc: 'Sets the text for the logout button',
      args: [],
    );
  }

  /// `Login`
  String get loginScreenTitle {
    return Intl.message(
      'Login',
      name: 'loginScreenTitle',
      desc: 'Sets the title for the login screen',
      args: [],
    );
  }

  /// `Register`
  String get registerScreenTitle {
    return Intl.message(
      'Register',
      name: 'registerScreenTitle',
      desc: 'Sets the title for the register screen',
      args: [],
    );
  }

  /// `Use Fingerprint to login`
  String get settingsScreenBiometricEntry {
    return Intl.message(
      'Use Fingerprint to login',
      name: 'settingsScreenBiometricEntry',
      desc: 'Sets the settings title for the biometric entry',
      args: [],
    );
  }

  /// `Biometric Authentication`
  String get biometricsScreenTitle {
    return Intl.message(
      'Biometric Authentication',
      name: 'biometricsScreenTitle',
      desc: 'Sets the title for the biometric screen',
      args: [],
    );
  }

  /// `Server isn't reachable at the moment...check your connection or try later`
  String get serverFailure {
    return Intl.message(
      'Server isn\'t reachable at the moment...check your connection or try later',
      name: 'serverFailure',
      desc: 'Sets the error message when the server could not be reached',
      args: [],
    );
  }

  /// `An unknown error has occurred...try later or contact support`
  String get unknownError {
    return Intl.message(
      'An unknown error has occurred...try later or contact support',
      name: 'unknownError',
      desc: 'Unknown error...try later or contact support',
      args: [],
    );
  }

  /// `Couldn't generate a biometric token...try later...`
  String get getBiometricTokenFailure {
    return Intl.message(
      'Couldn\'t generate a biometric token...try later...',
      name: 'getBiometricTokenFailure',
      desc:
          'Sets the error message when the server is unable to generate a biometric token.',
      args: [],
    );
  }

  /// `Failed to decrypt biometric token...please log-in using username/password and try to enroll again`
  String get decryptRSAFailure {
    return Intl.message(
      'Failed to decrypt biometric token...please log-in using username/password and try to enroll again',
      name: 'decryptRSAFailure',
      desc: 'Sets the error message when the RSA decryption fails',
      args: [],
    );
  }

  /// `Biometric token is not valid...please log-in using username/password and try to enroll again`
  String get invalidBiometricToken {
    return Intl.message(
      'Biometric token is not valid...please log-in using username/password and try to enroll again',
      name: 'invalidBiometricToken',
      desc: 'Sets the error message when the biometric token is not valid',
      args: [],
    );
  }

  /// `Enable biometric authentication`
  String get enableBiometricAuthenticationEntry {
    return Intl.message(
      'Enable biometric authentication',
      name: 'enableBiometricAuthenticationEntry',
      desc: 'Sets the text for the biometric\'s settings entry',
      args: [],
    );
  }

  /// `Login using biometrics`
  String get biometricLoginText {
    return Intl.message(
      'Login using biometrics',
      name: 'biometricLoginText',
      desc: 'Sets the text for the biometric\'s login button',
      args: [],
    );
  }

  /// `Touch sensor to login`
  String get biometricHint {
    return Intl.message(
      'Touch sensor to login',
      name: 'biometricHint',
      desc: 'Sets the text for the biometric\'s prompt hint',
      args: [],
    );
  }

  /// `Fingerprint not recognized...try again`
  String get biometricNotRecognized {
    return Intl.message(
      'Fingerprint not recognized...try again',
      name: 'biometricNotRecognized',
      desc:
          'Sets the text for the biometric\'s prompt when it is not recognized',
      args: [],
    );
  }

  /// `Authentication successful`
  String get biometricSuccess {
    return Intl.message(
      'Authentication successful',
      name: 'biometricSuccess',
      desc: 'Sets the text for the biometric\'s prompt success text',
      args: [],
    );
  }

  /// `Biometric Authentication`
  String get biometricTitle {
    return Intl.message(
      'Biometric Authentication',
      name: 'biometricTitle',
      desc: 'Sets the text for the biometric\'s prompt title',
      args: [],
    );
  }

  /// `Go to settings`
  String get biometricSettingsRedirect {
    return Intl.message(
      'Go to settings',
      name: 'biometricSettingsRedirect',
      desc:
          'Sets the text for the biometric\'s prompt when it needs to redirect user to settings',
      args: [],
    );
  }

  /// `Biometric authentication is not set up on your device`
  String get biometricSettingsRedirectReason {
    return Intl.message(
      'Biometric authentication is not set up on your device',
      name: 'biometricSettingsRedirectReason',
      desc:
          'Sets the text for the biometric\'s prompt on why the user has to go to settings',
      args: [],
    );
  }

  /// `Biometric authentication is disabled...try locking and unlocking the screen to enable it`
  String get biometricLockOut {
    return Intl.message(
      'Biometric authentication is disabled...try locking and unlocking the screen to enable it',
      name: 'biometricLockOut',
      desc:
          'Sets the text for the biometric\'s prompt when user is locked out of the device',
      args: [],
    );
  }

  /// `Login using username and password`
  String get biometricLoginCancel {
    return Intl.message(
      'Login using username and password',
      name: 'biometricLoginCancel',
      desc:
          'Sets the text for the biometric\'s prompt when user wish to cancel the login',
      args: [],
    );
  }

  /// `Cancel biometric authentication`
  String get biometricSignCancel {
    return Intl.message(
      'Cancel biometric authentication',
      name: 'biometricSignCancel',
      desc:
          'Sets the text for the biometric\'s prompt when user wish to cancel the enroll process',
      args: [],
    );
  }

  /// `Error generating keypair`
  String get biometricGenerateKeysFailure {
    return Intl.message(
      'Error generating keypair',
      name: 'biometricGenerateKeysFailure',
      desc: 'Sets the error message when generating a new keypair fails',
      args: [],
    );
  }

  /// `Error signing payload`
  String get biometricSignPayloadFailure {
    return Intl.message(
      'Error signing payload',
      name: 'biometricSignPayloadFailure',
      desc: 'Sets the error message when signing a payload fails',
      args: [],
    );
  }

  /// `Touch sensor to sign the payload`
  String get biometricSignReason {
    return Intl.message(
      'Touch sensor to sign the payload',
      name: 'biometricSignReason',
      desc:
          'Sets the text for the biometric\'s prompt hint when signin a payload',
      args: [],
    );
  }

  /// `Error decrypting ciphertext`
  String get biometricDecryptCiphertextFailure {
    return Intl.message(
      'Error decrypting ciphertext',
      name: 'biometricDecryptCiphertextFailure',
      desc: 'Sets the error message when ciphertext decryption fails.',
      args: [],
    );
  }

  /// `Error decrypting ciphertext...user cancelled it`
  String get biometricDecryptCiphertextCancelled {
    return Intl.message(
      'Error decrypting ciphertext...user cancelled it',
      name: 'biometricDecryptCiphertextCancelled',
      desc:
          'Sets the error message when ciphertext decryption is cancelled by user.',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it', countryCode: 'IT'),
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
