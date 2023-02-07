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

  /// `Settings`
  String get settingsScreenTitle {
    return Intl.message(
      'Settings',
      name: 'settingsScreenTitle',
      desc: 'Sets the app bar title for the settings screen',
      args: [],
    );
  }

  /// `Common`
  String get settingsScreenCommonEntry {
    return Intl.message(
      'Common',
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
