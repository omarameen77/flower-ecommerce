// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/network/network_module.dart' as _i234;
import '../../core/network/safe_api_caller.dart' as _i563;
import '../../core/storage/secure_storage_service.dart' as _i64;
import '../../features/app_sections/presentation/cubit/app_sections_cubit.dart'
    as _i936;
import '../../features/auth/api/api_client/auth_api_client.dart' as _i824;
import '../../features/auth/login/data/data_source/login_remote_datasource.dart'
    as _i853;
import '../../features/auth/login/data/data_source/login_remote_datasource_impl.dart'
    as _i660;
import '../../features/auth/login/data/repo/login_repo_impl.dart' as _i1001;
import '../../features/auth/login/domain/repo/login_repo_contract.dart'
    as _i844;
import '../../features/auth/login/domain/usecase/login_use_case.dart' as _i79;
import '../../features/auth/login/ui/cubit/login_view_model.dart' as _i785;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.factory<_i563.SafeApiCaller>(() => _i563.SafeApiCaller());
    gh.factory<_i936.AppSectionsCubit>(() => _i936.AppSectionsCubit());
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i64.SecureStorageService>(
      () => _i64.SecureStorageService(),
    );
    gh.singleton<_i824.AuthApiClient>(
      () => networkModule.authApi(gh<_i361.Dio>()),
    );
    gh.factory<_i853.LoginRemoteDataSourceContract>(
      () => _i660.LoginRemoteDatasourceImpl(
        gh<_i824.AuthApiClient>(),
        gh<_i563.SafeApiCaller>(),
      ),
    );
    gh.factory<_i844.LoginRepoContract>(
      () => _i1001.LoginRepoImpl(
        remoteDataSource: gh<_i853.LoginRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i79.LoginUseCase>(
      () => _i79.LoginUseCase(gh<_i844.LoginRepoContract>()),
    );
    gh.factory<_i785.LoginViewModel>(
      () => _i785.LoginViewModel(
        gh<_i79.LoginUseCase>(),
        gh<_i64.SecureStorageService>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i234.NetworkModule {}
