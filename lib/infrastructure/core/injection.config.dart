// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i18;
import '../../application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart'
    as _i19;
import '../../application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart'
    as _i10;
import '../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i20;
import '../../application/crowdaction/crowdaction_selected/crowdaction_selected_cubit.dart'
    as _i4;
import '../../application/crowdaction/pagination/pagination_cubit.dart' as _i11;
import '../../domain/auth/i_auth_api_repository.dart' as _i12;
import '../../domain/auth/i_auth_client_repository.dart' as _i6;
import '../../domain/core/i_settings_repository.dart' as _i8;
import '../../domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart'
    as _i14;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i16;
import '../auth/api/api_auth_repository.dart' as _i13;
import '../auth/firebase/firebase_auth_repository.dart' as _i7;
import '../crowdaction/create_crowdaction/create_crowdaction_repository.dart'
    as _i15;
import '../crowdaction/crowdaction_repository.dart' as _i17;
import 'firebase_injectable.dart' as _i22;
import 'http_singleton.dart' as _i21;
import 'settings_repository.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i4.CrowdActionSelectedCubit>(
      () => _i4.CrowdActionSelectedCubit());
  gh.lazySingleton<_i5.FirebaseAuth>(() => firebaseInjectable.firebaseAuth);
  gh.lazySingleton<_i6.IAuthClientRepository>(
      () => _i7.AuthRepository(get<_i5.FirebaseAuth>()));
  gh.lazySingleton<_i8.ISettingsRepository>(() => _i9.SettingRepository());
  gh.factory<_i10.MediatorBloc>(() => _i10.MediatorBloc());
  gh.lazySingleton<_i11.PaginationCubit>(() => _i11.PaginationCubit());
  gh.lazySingleton<_i12.IAuthApiRepository>(() => _i13.AuthApiRepository(
        get<_i3.Client>(),
        get<_i8.ISettingsRepository>(),
        get<_i6.IAuthClientRepository>(),
      ));
  gh.lazySingleton<_i14.ICreateCrowdActionRepository>(
      () => _i15.CreateCrowdActionRepository(
            get<_i3.Client>(),
            get<_i8.ISettingsRepository>(),
            get<_i6.IAuthClientRepository>(),
          ));
  gh.lazySingleton<_i16.ICrowdActionRepository>(
      () => _i17.CrowdActionRepository(
            get<_i3.Client>(),
            get<_i8.ISettingsRepository>(),
          ));
  gh.factory<_i18.AuthBloc>(() => _i18.AuthBloc(
        get<_i6.IAuthClientRepository>(),
        get<_i12.IAuthApiRepository>(),
      ));
  gh.factory<_i19.CrowdActionCreationBloc>(() => _i19.CrowdActionCreationBloc(
        get<_i10.MediatorBloc>(),
        get<_i14.ICreateCrowdActionRepository>(),
      ));
  gh.factory<_i20.CrowdActionGetterBloc>(() => _i20.CrowdActionGetterBloc(
        get<_i16.ICrowdActionRepository>(),
        get<_i11.PaginationCubit>(),
      ));
  return get;
}

class _$HttpSingleton extends _i21.HttpSingleton {}

class _$FirebaseInjectable extends _i22.FirebaseInjectable {}
