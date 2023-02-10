// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(username, id, email) =>
      "Registration was successfull...Username: ${username} Id: ${id} Email:${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "biometricsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Biometrics"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "dialogOkButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "emailAlreadyInUse":
            MessageLookupByLibrary.simpleMessage("Email is already registered"),
        "emailEmpty": MessageLookupByLibrary.simpleMessage("Email is empty"),
        "emailHint": MessageLookupByLibrary.simpleMessage("Email"),
        "homeScreenSettingsEntry":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "homeScreenTitle": MessageLookupByLibrary.simpleMessage("User Info"),
        "homeScreenUserInfoEntry": MessageLookupByLibrary.simpleMessage("User"),
        "homeScreenUserInfoTitle":
            MessageLookupByLibrary.simpleMessage("User Info"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Email is not valid"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Wrong Username or Password"),
        "loginScreenTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "logoutButtonTextEntry": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutFailure": MessageLookupByLibrary.simpleMessage(
            "Failed to perform logout...token may have been revoked"),
        "passwordDoesNotMatch": MessageLookupByLibrary.simpleMessage(
            "The two password doesn\'t match"),
        "passwordEmpty":
            MessageLookupByLibrary.simpleMessage("Password is empty"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
            "Password is too common...please choose another one"),
        "passwordTooShort": MessageLookupByLibrary.simpleMessage(
            "Password must have at least 8 characters"),
        "refreshAccessTokenFailure": MessageLookupByLibrary.simpleMessage(
            "Couldn\'t refresh access token...try to log-in again"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
        "registerScreenTitle": MessageLookupByLibrary.simpleMessage("Register"),
        "registrationDialogContent": m0,
        "registrationDialogTitle":
            MessageLookupByLibrary.simpleMessage("Registration"),
        "serverFailure": MessageLookupByLibrary.simpleMessage(
            "Server isn\'t reachable at the moment...check your connection or try later"),
        "settingsScreenBiometricEntry":
            MessageLookupByLibrary.simpleMessage("Use Fingerprint to login"),
        "settingsScreenCommonEntry":
            MessageLookupByLibrary.simpleMessage("General"),
        "settingsScreenLanguageEntry":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingsScreenThemeDarkEntry":
            MessageLookupByLibrary.simpleMessage("Use dark theme"),
        "settingsScreenThemeEntry":
            MessageLookupByLibrary.simpleMessage("Theme"),
        "settingsScreenThemeLightEntry":
            MessageLookupByLibrary.simpleMessage("Use light theme"),
        "settingsScreenThemeSystemEntry":
            MessageLookupByLibrary.simpleMessage("Use system theme"),
        "settingsScreenTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "unauthorizedError":
            MessageLookupByLibrary.simpleMessage("User is not authorized"),
        "unknownError": MessageLookupByLibrary.simpleMessage(
            "An unknown error has occurred...try later or contact support"),
        "usernameEmpty":
            MessageLookupByLibrary.simpleMessage("Username is empty"),
        "usernameHint": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameNotUnique": MessageLookupByLibrary.simpleMessage(
            "Username is already taken...please choose another one")
      };
}
