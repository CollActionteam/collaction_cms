import 'package:collaction_admin/domain/core/i_settings_repository.dart';
import 'package:collaction_admin/env/envied.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISettingsRepository)
class SettingRepository implements ISettingsRepository {
  SettingRepository();

  @override
  Future<String> get getEnv async {
    return Env.env;
  }

  @override
  Future<String> get baseApiEndpointUrl async {
    return Env.baseEndpoint;
  }
}
