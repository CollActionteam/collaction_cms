// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i13;
import '../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i14;
import '../../domain/auth/i_auth_api_repository.dart' as _i9;
import '../../domain/auth/i_auth_client_repository.dart' as _i5;
import '../../domain/core/i_settings_repository.dart' as _i7;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i11;
import '../auth/api/api_auth_repository.dart' as _i10;
import '../auth/firebase/firebase_auth_repository.dart' as _i6;
import '../crowdaction/crowdaction_repository.dart' as _i12;
import 'firebase_injectable.dart' as _i16;
import 'http_singleton.dart' as _i15;
import 'settings_repository.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final httpSingleton = _$HttpSingleton();
  final firebaseInjectable = _$FirebaseInjectable();
  gh.lazySingleton<_i3.Client>(() => httpSingleton.client);
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseInjectable.firebaseAuth);
  gh.lazySingleton<_i5.IAuthClientRepository>(
      () => _i6.AuthRepository(get<_i4.FirebaseAuth>()));
  gh.lazySingleton<_i7.ISettingsRepository>(() => _i8.SettingRepository());
  gh.lazySingleton<_i9.IAuthApiRepository>(() => _i10.AuthApiRepository(
        get<_i3.Client>(),
        get<_i7.ISettingsRepository>(),
        get<_i5.IAuthClientRepository>(),
      ));
  gh.lazySingleton<_i11.ICrowdActionRepository>(
      () => _i12.CrowdActionRepository(
            get<_i3.Client>(),
            get<_i7.ISettingsRepository>(),
          ));
  gh.factory<_i13.AuthBloc>(() => _i13.AuthBloc(
        get<_i5.IAuthClientRepository>(),
        get<_i9.IAuthApiRepository>(),
      ));
  gh.factory<_i14.CrowdActionGetterBloc>(
      () => _i14.CrowdActionGetterBloc(get<_i11.ICrowdActionRepository>()));
  return get;
}

class _$HttpSingleton extends _i15.HttpSingleton {}

class _$FirebaseInjectable extends _i16.FirebaseInjectable {}
