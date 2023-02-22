import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/retrofit/rest_client.dart';

class BaseRepository {
  RestClient restClient;
  BaseRepository({restClient})
      : restClient = (restClient ?? serviceLocator.get<RestClient>());
}
