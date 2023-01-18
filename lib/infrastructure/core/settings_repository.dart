import 'package:collaction_cms/domain/core/i_settings_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISettingsRepository)
class SettingRepository implements ISettingsRepository {
  SettingRepository();

  @override
  Future<String> get getEnv async {
    return dotenv.env['ENV']!;
  }

  @override
  Future<String> get baseApiEndpointUrl async {
    return dotenv.env['BASE_API_ENDPOINT_URL']!;
  }
}
