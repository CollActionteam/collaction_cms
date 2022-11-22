import 'package:envied/envied.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'envied.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: "ENV")
  static const env = _Env.env;
  @EnviedField(varName: "BASE_API_ENDPOINT_URL")
  static const baseEndpoint = _Env.baseEndpoint;
  @EnviedField(varName: "BASE_STATIC_ENDPOINT_URL")
  static const staticEndpoint = _Env.staticEndpoint;
}