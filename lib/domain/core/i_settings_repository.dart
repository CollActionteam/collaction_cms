abstract class ISettingsRepository {
  Future<String> get getEnv;

  Future<String> get baseApiEndpointUrl;

  Future<String> get staticEndpointUrl;
}
