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
        "biometricLoginText": MessageLookupByLibrary.simpleMessage(
            "Accedi utilizzando i dati biometrici"),
        "biometricsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Autenticazione Biometrica"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Conferma Password"),
        "decryptRSAFailure": MessageLookupByLibrary.simpleMessage(
            "Non è stato possibile decifrare il token biometrico...perfavore effettua il log-in usando username/password ed effettua nuovamente il processo di attivazione biometrico"),
        "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Errore"),
        "dialogOkButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "La mail è gia stata registrata"),
        "emailEmpty":
            MessageLookupByLibrary.simpleMessage("Il campo Email è vuoto"),
        "emailHint": MessageLookupByLibrary.simpleMessage("Email"),
        "enableBiometricAuthenticationEntry":
            MessageLookupByLibrary.simpleMessage(
                "Abilita autenticazione biometrica"),
        "getBiometricTokenFailure": MessageLookupByLibrary.simpleMessage(
            "Non è stato possibile generare il token biometrico...riprova più tardi"),
        "homeScreenSettingsEntry":
            MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "homeScreenTitle": MessageLookupByLibrary.simpleMessage("Utente"),
        "homeScreenUserInfoEntry":
            MessageLookupByLibrary.simpleMessage("Utente"),
        "homeScreenUserInfoTitle":
            MessageLookupByLibrary.simpleMessage("Informazioni Utente"),
        "invalidBiometricToken": MessageLookupByLibrary.simpleMessage(
            "Il token biometrico non è valido...perfavore effettua il log-in usando username/password ed effettua nuovamente il processo di attivazione biometrico"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("L\'email non è valida"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Accedi"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Username o Password errati"),
        "loginScreenTitle": MessageLookupByLibrary.simpleMessage("Accedi"),
        "logoutButtonTextEntry": MessageLookupByLibrary.simpleMessage("Esci"),
        "logoutFailure": MessageLookupByLibrary.simpleMessage(
            "Impossibile effettuare il logout...il token potrebbe essere stato inserito in blacklist"),
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
        "registerScreenTitle":
            MessageLookupByLibrary.simpleMessage("Registrati"),
        "registrationDialogContent": m0,
        "registrationDialogTitle":
            MessageLookupByLibrary.simpleMessage("Registrazione"),
        "serverFailure": MessageLookupByLibrary.simpleMessage(
            "Il server non è raggiungibile al momento...controlla la tua connessione o riprova più tardi"),
        "settingsScreenBiometricEntry": MessageLookupByLibrary.simpleMessage(
            "Usa l\'impronta digitale per effettuare il login"),
        "settingsScreenCommonEntry":
            MessageLookupByLibrary.simpleMessage("Generale"),
        "settingsScreenLanguageEntry":
            MessageLookupByLibrary.simpleMessage("Lingua"),
        "settingsScreenThemeDarkEntry":
            MessageLookupByLibrary.simpleMessage("Usa il tema scuro"),
        "settingsScreenThemeEntry":
            MessageLookupByLibrary.simpleMessage("Tema"),
        "settingsScreenThemeLightEntry":
            MessageLookupByLibrary.simpleMessage("Usa il tema chiaro"),
        "settingsScreenThemeSystemEntry":
            MessageLookupByLibrary.simpleMessage("Usa il tema di sistema"),
        "settingsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "unauthorizedError":
            MessageLookupByLibrary.simpleMessage("L\'utente non è autorizzato"),
        "unknownError": MessageLookupByLibrary.simpleMessage(
            "Errore sconosciuto...riprova più tardi o contatta il supporto"),
        "usernameEmpty": MessageLookupByLibrary.simpleMessage(
            "Il campo Nome Utente è vuoto"),
        "usernameHint": MessageLookupByLibrary.simpleMessage("Username"),
        "usernameNotUnique": MessageLookupByLibrary.simpleMessage(
            "L\'username è gia registrato...scegli un nuovo username")
      };
}
