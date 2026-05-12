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
import '../../features/app_sections/presentation/cubit/app_sections_cubit.dart'
    as _i936;
import '../../features/auth/api/api_client/auth_api_client.dart' as _i824;
import '../../features/auth/api/datasources/auth_remote_data_source_impl.dart'
    as _i723;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/forget_password_usecase.dart'
    as _i27;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/domain/use_cases/reset_password_usecase.dart'
    as _i348;
import '../../features/auth/domain/use_cases/verify_reset_code_usecase.dart'
    as _i887;
import '../../features/auth/presentation/forget_password/cubit/forget_password_cubit.dart'
    as _i995;
import '../../features/auth/presentation/login/cubit/login_cubit.dart' as _i179;
import '../../features/auth/presentation/register/cubit/register_cubit.dart'
    as _i404;
import '../../features/auth/presentation/reset_password/cubit/reset_password_cubit.dart'
    as _i450;
import '../../features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart'
    as _i660;
import '../../features/product_sections/api/api_client/products_sections_api_client.dart'
    as _i266;
import '../../features/product_sections/api/datasource/products_sections_data_source_impl.dart'
    as _i370;
import '../../features/product_sections/data/datasource/products_section_data_source_contract.dart'
    as _i303;
import '../../features/product_sections/data/repositories/products_sections_repo_impl.dart'
    as _i34;
import '../../features/product_sections/domain/repositories/products_section_repo.dart'
    as _i386;
import '../../features/product_sections/domain/use_cases/get_occasions_use_case.dart'
    as _i529;
import '../../features/product_sections/domain/use_cases/get_products_use_case.dart'
    as _i713;
import '../../features/product_sections/presentation/shared_cubit/category_cubit/category_cubit.dart'
    as _i344;
import '../../features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_cubit.dart'
    as _i129;
import '../../features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart'
    as _i538;

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
    gh.singleton<_i824.AuthApiClient>(
      () => networkModule.authApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i266.ProductsSectionsApiClient>(
      () => networkModule.productsApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSourceContract>(
      () => _i723.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i824.AuthApiClient>(),
      ),
    );
    gh.factory<_i303.ProductsSectionDataSourceContract>(
      () => _i370.ProductsSectionsDataSourceImpl(
        productsSectionsApiClient: gh<_i266.ProductsSectionsApiClient>(),
      ),
    );
    gh.factory<_i386.ProductsSectionRepo>(
      () => _i34.ProductsSectionsRepoImpl(
        productsSectionDataSourceContract:
            gh<_i303.ProductsSectionDataSourceContract>(),
      ),
    );
    gh.factory<_i529.GetOccasionsUseCase>(
      () => _i529.GetOccasionsUseCase(
        productsSectionRepo: gh<_i386.ProductsSectionRepo>(),
      ),
    );
    gh.factory<_i713.GetProductsUseCase>(
      () => _i713.GetProductsUseCase(
        productsSectionRepo: gh<_i386.ProductsSectionRepo>(),
      ),
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(
        authRemoteDataSourceContract: gh<_i107.AuthRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(authRepo: gh<_i723.AuthRepo>()),
    );
    gh.factory<_i538.ProductCubit>(
      () =>
          _i538.ProductCubit(getProductUseCase: gh<_i713.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i129.OccasionCubit>(
      () => _i129.OccasionCubit(
        getOccasionUseCase: gh<_i529.GetOccasionsUseCase>(),
      ),
    );
    gh.factory<_i27.ForgetPasswordUseCase>(
      () => _i27.ForgetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i348.ResetPasswordUseCase>(
      () => _i348.ResetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i887.VerifyResetCodeUseCase>(
      () => _i887.VerifyResetCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(registerRepoContract: gh<_i723.AuthRepo>()),
    );
    gh.factory<_i404.RegisterCubit>(
      () => _i404.RegisterCubit(gh<_i1010.RegisterUseCase>()),
    );
    gh.factory<_i995.ForgetPasswordCubit>(
      () => _i995.ForgetPasswordCubit(gh<_i27.ForgetPasswordUseCase>()),
    );
    gh.factory<_i179.LoginCubit>(
      () => _i179.LoginCubit(gh<_i1038.LoginUseCase>()),
    );
    gh.factory<_i660.VerifyResetCodeCubit>(
      () => _i660.VerifyResetCodeCubit(
        gh<_i887.VerifyResetCodeUseCase>(),
        gh<_i27.ForgetPasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i344.CategoryCubit>(() => _i344.CategoryCubit());
    gh.factory<_i450.ResetPasswordCubit>(
      () => _i450.ResetPasswordCubit(gh<_i348.ResetPasswordUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i234.NetworkModule {}
