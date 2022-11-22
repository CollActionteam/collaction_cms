
import 'package:collaction_admin/env/envied.dart';

abstract class ISettingsRepository {

  Future<String> get getEnv;

  Future<String> get baseApiEndpointUrl;

}


