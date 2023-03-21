// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/auth_bloc.dart' as _i19;
import '../../application/crowdaction/crowdaction_creation/commitments/commitments_bloc.dart'
    as _i4;
import '../../application/crowdaction/crowdaction_creation/main/crowdaction_creation_bloc.dart'
    as _i20;
import '../../application/crowdaction/crowdaction_creation/mediator/mediator_bloc.dart'
    as _i11;
import '../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart'
    as _i21;
import '../../application/crowdaction/crowdaction_selected/crowdaction_selected_cubit.dart'
    as _i5;
import '../../application/crowdaction/pagination/pagination_cubit.dart' as _i12;
import '../../domain/auth/i_auth_api_repository.dart' as _i13;
import '../../domain/auth/i_auth_client_repository.dart' as _i7;
import '../../domain/core/i_settings_repository.dart' as _i9;
import '../../domain/crowdaction/crowdaction_creation/i_create_crowdation_repository.dart'
    as _i15;
import '../../domain/crowdaction/i_crowdaction_repository.dart' as _i17;
import '../auth/api/api_auth_repository.dart' as _i14;
import '../auth/firebase/firebase_auth_repository.dart' as _i8;
import '../crowdaction/create_crowdaction/create_crowdaction_repository.dart'
    as _i16;
import '../crowdaction/crowdaction_repository.dart' as _i18;
import 'firebase_injectable.dart' as _i23;
import 'http_singleton.dart' as _i22;
import 'settings_repository.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.CommitmentsBloc>(() => _i4.CommitmentsBloc());
  gh.lazySingleton<_i5.CrowdActionSelectedCubit>(
      () => _i5.CrowdActionSelectedCubit());
  gh.lazySingleton<_i6.FirebaseAuth>(() => firebaseInjectable.firebaseAuth);
  gh.lazySingleton<_i7.IAuthClientRepository>(
      () => _i8.AuthRepository(get<_i6.FirebaseAuth>()));
  gh.lazySingleton<_i9.ISettingsRepository>(() => _i10.SettingRepository());
  gh.factory<_i11.MediatorBloc>(() => _i11.MediatorBloc());
  gh.lazySingleton<_i12.PaginationCubit>(() => _i12.PaginationCubit());
  gh.lazySingleton<_i13.IAuthApiRepository>(() => _i14.AuthApiRepository(
        get<_i3.Client>(),
        get<_i9.ISettingsRepository>(),
        get<_i7.IAuthClientRepository>(),
      ));
  gh.lazySingleton<_i15.ICreateCrowdActionRepository>(
      () => _i16.CreateCrowdActionRepository(
            get<_i3.Client>(),
            get<_i9.ISettingsRepository>(),
            get<_i7.IAuthClientRepository>(),
          ));
  gh.lazySingleton<_i17.ICrowdActionRepository>(
      () => _i18.CrowdActionRepository(
            get<_i3.Client>(),
            get<_i9.ISettingsRepository>(),
          ));
  gh.factory<_i19.AuthBloc>(() => _i19.AuthBloc(
        get<_i7.IAuthClientRepository>(),
        get<_i13.IAuthApiRepository>(),
      ));
  gh.factory<_i20.CrowdActionCreationBloc>(() => _i20.CrowdActionCreationBloc(
        get<_i11.MediatorBloc>(),
        get<_i15.ICreateCrowdActionRepository>(),
      ));
  gh.factory<_i21.CrowdActionGetterBloc>(() => _i21.CrowdActionGetterBloc(
        get<_i17.ICrowdActionRepository>(),
        get<_i12.PaginationCubit>(),
      ));
  return get;
}

class _$HttpSingleton extends _i22.HttpSingleton {}

class _$FirebaseInjectable extends _i23.FirebaseInjectable {}
