
import 'package:collaction_cms/env/envied.dart';

abstract class ISettingsRepository {

  Future<String> get getEnv;

  Future<String> get baseApiEndpointUrl;

}


