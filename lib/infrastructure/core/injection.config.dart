// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/authentication/authentication_bloc.dart' as _i7;
import '../../application/navigation/navigation_bloc.dart' as _i6;
import '../../domain/authentication/i_auth_repository.dart' as _i4;
import '../authentication/auth_repository.dart' as _i5;
import 'firebase_injectable.dart'
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
  final firebaseInjectable = _$FirebaseInjectable();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseInjectable.firebaseAuth);
  gh.lazySingleton<_i4.IAuthRepository>(
      () => _i5.AuthRepository(get<_i3.FirebaseAuth>()));
  gh.lazySingleton<_i6.NavigationBloc>(() => _i6.NavigationBloc());
  gh.factory<_i7.AuthenticationBloc>(
      () => _i7.AuthenticationBloc(get<_i4.IAuthRepository>()));
  return get;
}

class _$FirebaseInjectable extends _i8.FirebaseInjectable {}
