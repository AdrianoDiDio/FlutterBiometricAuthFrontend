// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it_IT locale. All the
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
  String get localeName => 'it_IT';

  static String m0(username, id, email) =>
      "La registrazione è avvenuta correttamente...Username: ${username} Id: ${id} Email:${email}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Conferma Password"),
        "dialogOkButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "La mail è gia stata registrata"),
        "emailEmpty":
            MessageLookupByLibrary.simpleMessage("Il campo Email è vuoto"),
        "emailHint": MessageLookupByLibrary.simpleMessage("Email"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("L\'email non è valida"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Accedi"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Username o Password errati"),
        "passwordDoesNotMatch": MessageLookupByLibrary.simpleMessage(
            "Le due password non coincidono"),
        "passwordEmpty":
            MessageLookupByLibrary.simpleMessage("Il campo password è vuoto"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
            "La password è troppo comune...perfavore scegli una nuova password"),
        "passwordTooShort": MessageLookupByLibrary.simpleMessage(
            "La password deve contenere almeno 8 caratteri"),
        "refreshAccessTokenFailure": MessageLookupByLibrary.simpleMessage(
            "Non è stato possibile aggiornare l\'access token...prova ad effettuare il login di nuovo"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Registrati"),
        "registrationDialogContent": m0,
        "registrationDialogTitle":
            MessageLookupByLibrary.simpleMessage("Registrazione"),
        "settingsScreenCommonEntry":
            MessageLookupByLibrary.simpleMessage("Comuni"),
        "settingsScreenLanguageEntry":
            MessageLookupByLibrary.simpleMessage("Lingua"),
        "settingsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "unauthorizedError":
            MessageLookupByLibrary.simpleMessage("L\'utente non è autorizzato"),
        "usernameEmpty": MessageLookupByLibrary.simpleMessage(
            "Il campo Nome Utente è vuoto"),
        "usernameHint": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameNotUnique": MessageLookupByLibrary.simpleMessage(
            "L\'username è gia registrato...scegli un nuovo username")
      };
}
