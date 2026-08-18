// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/network/firebase_module.dart' as _i236;
import '../../core/network/network_module.dart' as _i234;
import '../../core/network/safe_api_caller.dart' as _i563;
import '../../core/notifications/fcm_service.dart' as _i761;
import '../../core/notifications/firestore_notification_service.dart' as _i415;
import '../../core/notifications/local_notification_service.dart' as _i298;
import '../../core/notifications/notification_initializer.dart' as _i838;
import '../../core/service/crashlytics_service.dart' as _i776;
import '../../features/address/api/api_client/address_api_client.dart' as _i218;
import '../../features/address/api/datasources/address_remote_data_source_impl.dart'
    as _i505;
import '../../features/address/data/datasources/address_remote_data_source.dart'
    as _i139;
import '../../features/address/data/datasources/current_location_data_source.dart'
    as _i582;
import '../../features/address/data/datasources/egypt_location_local_data_source.dart'
    as _i935;
import '../../features/address/data/repositories/address_repo_impl.dart'
    as _i235;
import '../../features/address/data/repositories/current_location_repo_impl.dart'
    as _i339;
import '../../features/address/data/repositories/egypt_location_repo_impl.dart'
    as _i16;
import '../../features/address/domain/repositories/address_repo.dart' as _i767;
import '../../features/address/domain/repositories/current_location_repo.dart'
    as _i124;
import '../../features/address/domain/repositories/egypt_location_repo.dart'
    as _i603;
import '../../features/address/domain/use_cases/add_address_use_case.dart'
    as _i458;
import '../../features/address/domain/use_cases/get_addresses_use_case.dart'
    as _i594;
import '../../features/address/domain/use_cases/get_current_location_use_case.dart'
    as _i990;
import '../../features/address/domain/use_cases/load_location_lookups_use_case.dart'
    as _i114;
import '../../features/address/domain/use_cases/remove_address_use_case.dart'
    as _i465;
import '../../features/address/domain/use_cases/update_address_use_case.dart'
    as _i130;
import '../../features/address/presentation/add_address/cubit/add_address_cubit.dart'
    as _i644;
import '../../features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart'
    as _i1050;
import '../../features/app_sections/presentation/cubit/app_sections_cubit.dart'
    as _i936;
import '../../features/auth/api/api_client/auth_api_client.dart' as _i824;
import '../../features/auth/api/datasources/auth_remote_data_source_impl.dart'
    as _i723;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/change_password_usecase.dart'
    as _i771;
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
import '../../features/cart/api/api_clint/cart_api_clint.dart' as _i198;
import '../../features/cart/api/datasource/cart_remote_data_source_impl.dart'
    as _i87;
import '../../features/cart/data/datasource/cart_remote_data_source_contract.dart'
    as _i398;
import '../../features/cart/data/repository/cart_repo_impl.dart' as _i668;
import '../../features/cart/domain/repository/cart_repo_contract.dart' as _i425;
import '../../features/cart/domain/usecases/add_product_to_cart_use_case.dart'
    as _i802;
import '../../features/cart/domain/usecases/get_cart_use_case.dart' as _i488;
import '../../features/cart/domain/usecases/remove_cart_item_use_case.dart'
    as _i650;
import '../../features/cart/domain/usecases/update_cart_item_quantity_use_case.dart'
    as _i157;
import '../../features/cart/presentation/cubit/cart_cubit.dart' as _i499;
import '../../features/checkout/api/api_client/checkout_api_client.dart'
    as _i832;
import '../../features/checkout/api/datasources/checkout_remote_data_source_impl.dart'
    as _i551;
import '../../features/checkout/api/datasources/order_user_info_firestore_data_source_impl.dart'
    as _i621;
import '../../features/checkout/data/datasources/checkout_remote_data_source.dart'
    as _i336;
import '../../features/checkout/data/datasources/order_user_info_firestore_data_source.dart'
    as _i896;
import '../../features/checkout/data/repositories/checkout_repo_impl.dart'
    as _i32;
import '../../features/checkout/data/repositories/order_user_info_repo_impl.dart'
    as _i639;
import '../../features/checkout/domain/repositories/checkout_repo.dart'
    as _i755;
import '../../features/checkout/domain/repositories/order_user_info_repo.dart'
    as _i400;
import '../../features/checkout/domain/usecases/checkout_with_card_usecase.dart'
    as _i1017;
import '../../features/checkout/domain/usecases/checkout_with_cash_usecase.dart'
    as _i421;
import '../../features/checkout/domain/usecases/save_order_user_info_use_case.dart'
    as _i406;
import '../../features/checkout/presentation/checkout/cubit/checkout_cubit.dart'
    as _i217;
import '../../features/notifications/api/datasource/notifications_firestore_data_source_impl.dart'
    as _i711;
import '../../features/notifications/data/datasource/notifications_firestore_data_source_contract.dart'
    as _i588;
import '../../features/notifications/data/repository/notifications_repo_impl.dart'
    as _i220;
import '../../features/notifications/domain/repository/notifications_repo_contract.dart'
    as _i688;
import '../../features/notifications/domain/usecases/delete_notifications_use_case.dart'
    as _i516;
import '../../features/notifications/domain/usecases/get_un_read_notification_count_use_case.dart'
    as _i837;
import '../../features/notifications/domain/usecases/get_user_notifications_use_case.dart'
    as _i392;
import '../../features/notifications/domain/usecases/mark_as_reaed_notification_use_case.dart'
    as _i1043;
import '../../features/notifications/ui/cubit/notifications_cubit.dart'
    as _i532;
import '../../features/orders/api/api_client/orders_api_client.dart' as _i107;
import '../../features/orders/api/datasources/orders_remote_data_source_impl.dart'
    as _i335;
import '../../features/orders/data/datasources/orders_remote_data_source.dart'
    as _i858;
import '../../features/orders/data/repositories/orders_repo_impl.dart' as _i813;
import '../../features/orders/domain/repositories/orders_repo.dart' as _i509;
import '../../features/orders/domain/usecases/get_orders_usecase.dart' as _i755;
import '../../features/orders/presentation/orders/cubit/orders_cubit.dart'
    as _i727;
import '../../features/product_sections/api/api_client/products_sections_api_client.dart'
    as _i266;
import '../../features/product_sections/api/datasource/categories_data_source_impl.dart'
    as _i1014;
import '../../features/product_sections/api/datasource/products_sections_data_source_impl.dart'
    as _i370;
import '../../features/product_sections/data/datasource/categories_data_source_contract.dart'
    as _i1032;
import '../../features/product_sections/data/datasource/products_section_data_source_contract.dart'
    as _i303;
import '../../features/product_sections/data/repositories/categories_repo_impl.dart'
    as _i635;
import '../../features/product_sections/data/repositories/products_sections_repo_impl.dart'
    as _i34;
import '../../features/product_sections/domain/repositories/categories_repo.dart'
    as _i696;
import '../../features/product_sections/domain/repositories/products_section_repo.dart'
    as _i386;
import '../../features/product_sections/domain/use_cases/get_categories_use_case.dart'
    as _i406;
import '../../features/product_sections/domain/use_cases/get_occasions_use_case.dart'
    as _i529;
import '../../features/product_sections/domain/use_cases/get_product_by_id_use_case.dart'
    as _i1049;
import '../../features/product_sections/domain/use_cases/get_products_use_case.dart'
    as _i713;
import '../../features/product_sections/presentation/categories/cubit/category_products_cubit.dart'
    as _i783;
import '../../features/product_sections/presentation/occasions/cubit/occasions_products_cubit.dart'
    as _i309;
import '../../features/product_sections/presentation/product_details/cubit/product_details_cubit.dart'
    as _i301;
import '../../features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart'
    as _i691;
import '../../features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_cubit.dart'
    as _i129;
import '../../features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart'
    as _i538;
import '../../features/profile/api/api_client/profile_api_client.dart' as _i699;
import '../../features/profile/api/datasource/profile_remote_data_source_impl.dart'
    as _i911;
import '../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i847;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i525;
import '../../features/profile/domain/usecases/update_profile_use_case.dart'
    as _i540;
import '../../features/profile/domain/usecases/upload_photo_use_case.dart'
    as _i988;
import '../../features/profile/presentation/cubit/get_user_data/profile_cubit.dart'
    as _i1041;
import '../../features/track_order/api/datasource/track_order_firestore_data_source_impl.dart'
    as _i726;
import '../../features/track_order/data/datasources/track_order_firestore_data_source.dart'
    as _i574;
import '../../features/track_order/data/repositories/track_order_repo_impl.dart'
    as _i558;
import '../../features/track_order/domain/repositories/track_order_repo.dart'
    as _i528;
import '../../features/track_order/domain/usecases/confirm_delivery_use_case.dart'
    as _i585;
import '../../features/track_order/domain/usecases/get_current_order_use_case.dart'
    as _i1061;
import '../../features/track_order/domain/usecases/save_current_order_use_case.dart'
    as _i772;
import '../../features/track_order/domain/usecases/watch_order_state_use_case.dart'
    as _i293;
import '../../features/track_order/presentation/cubit/track_order_cubit.dart'
    as _i932;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i563.SafeApiCaller>(() => _i563.SafeApiCaller());
    gh.factory<_i936.AppSectionsCubit>(() => _i936.AppSectionsCubit());
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i415.FirestoreService>(() => _i415.FirestoreService());
    gh.lazySingleton<_i298.LocalNotificationService>(
      () => _i298.LocalNotificationService(),
    );
    gh.lazySingleton<_i776.CrashlyticsService>(
      () => _i776.CrashlyticsService(),
    );
    gh.lazySingleton<_i582.CurrentLocationDataSource>(
      () => _i582.CurrentLocationDataSourceImpl(),
    );
    gh.singleton<_i824.AuthApiClient>(
      () => networkModule.authApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i198.CartApiClient>(
      () => networkModule.cartApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i266.ProductsSectionsApiClient>(
      () => networkModule.productsApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i699.ProfileApiClient>(
      () => networkModule.profileApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i832.CheckoutApiClient>(
      () => networkModule.checkoutApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i107.OrdersApiClient>(
      () => networkModule.ordersApi(gh<_i361.Dio>()),
    );
    gh.singleton<_i218.AddressApiClient>(
      () => networkModule.addressApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i935.EgyptLocationLocalDataSource>(
      () => _i935.EgyptLocationLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i858.OrdersRemoteDataSourceContract>(
      () => _i335.OrdersRemoteDataSourceImpl(
        ordersApiClient: gh<_i107.OrdersApiClient>(),
      ),
    );
    gh.factory<_i1032.CategoriesDataSourceContract>(
      () => _i1014.CategoriesDataSourceImpl(
        apiClient: gh<_i266.ProductsSectionsApiClient>(),
        call: gh<_i563.SafeApiCaller>(),
      ),
    );
    gh.factory<_i696.CategoryRepoContract>(
      () => _i635.CategoriesRepoImpl(
        dataSource: gh<_i1032.CategoriesDataSourceContract>(),
      ),
    );
    gh.factory<_i139.AddressRemoteDataSourceContract>(
      () => _i505.AddressRemoteDataSourceImpl(
        addressApiClient: gh<_i218.AddressApiClient>(),
      ),
    );
    gh.lazySingleton<_i761.FcmService>(
      () => _i761.FcmService(
        gh<_i298.LocalNotificationService>(),
        gh<_i415.FirestoreService>(),
      ),
    );
    gh.lazySingleton<_i838.NotificationInitializer>(
      () => _i838.NotificationInitializer(
        gh<_i761.FcmService>(),
        gh<_i298.LocalNotificationService>(),
      ),
    );
    gh.lazySingleton<_i509.OrdersRepo>(
      () => _i813.OrdersRepoImpl(
        remoteDataSource: gh<_i858.OrdersRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i603.EgyptLocationRepo>(
      () =>
          _i16.EgyptLocationRepoImpl(gh<_i935.EgyptLocationLocalDataSource>()),
    );
    gh.factory<_i406.GetCategoriesUseCase>(
      () => _i406.GetCategoriesUseCase(repo: gh<_i696.CategoryRepoContract>()),
    );
    gh.factory<_i398.CartRemoteDataSourceContract>(
      () => _i87.CartRemoteDataSourceImpl(
        gh<_i198.CartApiClient>(),
        gh<_i563.SafeApiCaller>(),
      ),
    );
    gh.factory<_i574.TrackOrderDataSourceContract>(
      () => _i726.TrackOrderDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i896.OrderUserInfoFirestoreDataSourceContract>(
      () => _i621.OrderUserInfoFirestoreDataSourceImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.factory<_i588.NotificationsFirestoreDataSourceContract>(
      () => _i711.NotificationsFirestoreDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i124.CurrentLocationRepo>(
      () =>
          _i339.CurrentLocationRepoImpl(gh<_i582.CurrentLocationDataSource>()),
    );
    gh.factory<_i114.LoadLocationLookupsUseCase>(
      () => _i114.LoadLocationLookupsUseCase(gh<_i603.EgyptLocationRepo>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSourceContract>(
      () => _i723.AuthRemoteDataSourceImpl(
        authApiClient: gh<_i824.AuthApiClient>(),
      ),
    );
    gh.lazySingleton<_i847.ProfileRemoteDataSource>(
      () => _i911.ProfileRemoteDataSourceImpl(gh<_i699.ProfileApiClient>()),
    );
    gh.factory<_i303.ProductsSectionDataSourceContract>(
      () => _i370.ProductsSectionsDataSourceImpl(
        productsSectionsApiClient: gh<_i266.ProductsSectionsApiClient>(),
      ),
    );
    gh.lazySingleton<_i336.CheckoutRemoteDataSourceContract>(
      () => _i551.CheckoutRemoteDataSourceImpl(
        checkoutApiClient: gh<_i832.CheckoutApiClient>(),
      ),
    );
    gh.factory<_i425.CartRepoContract>(
      () => _i668.CartRepoImpl(gh<_i398.CartRemoteDataSourceContract>()),
    );
    gh.factory<_i688.NotificationsRepoContract>(
      () => _i220.NotificationsRepoImpl(
        gh<_i588.NotificationsFirestoreDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(gh<_i847.ProfileRemoteDataSource>()),
    );
    gh.factory<_i767.AddressRepo>(
      () => _i235.AddressRepoImpl(
        addressRemoteDataSourceContract:
            gh<_i139.AddressRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i400.OrderUserInfoRepo>(
      () => _i639.OrderUserInfoRepoImpl(
        gh<_i896.OrderUserInfoFirestoreDataSourceContract>(),
      ),
    );
    gh.factory<_i802.AddProductToCartUseCase>(
      () => _i802.AddProductToCartUseCase(gh<_i425.CartRepoContract>()),
    );
    gh.factory<_i488.GetCartUseCase>(
      () => _i488.GetCartUseCase(gh<_i425.CartRepoContract>()),
    );
    gh.factory<_i650.RemoveCartItemUseCase>(
      () => _i650.RemoveCartItemUseCase(gh<_i425.CartRepoContract>()),
    );
    gh.factory<_i157.UpdateCartItemQuantityUseCase>(
      () => _i157.UpdateCartItemQuantityUseCase(gh<_i425.CartRepoContract>()),
    );
    gh.factory<_i528.TrackOrderRepoContract>(
      () => _i558.TrackOrderRepoImpl(
        dataSource: gh<_i574.TrackOrderDataSourceContract>(),
      ),
    );
    gh.factory<_i386.ProductsSectionRepo>(
      () => _i34.ProductsSectionsRepoImpl(
        productsSectionDataSourceContract:
            gh<_i303.ProductsSectionDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i691.CategoriesCubit>(
      () => _i691.CategoriesCubit(
        getCategoriesUseCase: gh<_i406.GetCategoriesUseCase>(),
      ),
    );
    gh.factory<_i755.GetOrdersUseCase>(
      () => _i755.GetOrdersUseCase(gh<_i509.OrdersRepo>()),
    );
    gh.factory<_i990.GetCurrentLocationUseCase>(
      () => _i990.GetCurrentLocationUseCase(gh<_i124.CurrentLocationRepo>()),
    );
    gh.factory<_i525.GetProfileUseCase>(
      () => _i525.GetProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i540.UpdateProfileUseCase>(
      () => _i540.UpdateProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i988.UploadPhotoUseCase>(
      () => _i988.UploadPhotoUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i529.GetOccasionsUseCase>(
      () => _i529.GetOccasionsUseCase(
        productsSectionRepo: gh<_i386.ProductsSectionRepo>(),
      ),
    );
    gh.factory<_i1049.GetProductByIdUseCase>(
      () => _i1049.GetProductByIdUseCase(
        productsSectionRepo: gh<_i386.ProductsSectionRepo>(),
      ),
    );
    gh.factory<_i713.GetProductsUseCase>(
      () => _i713.GetProductsUseCase(
        productsSectionRepo: gh<_i386.ProductsSectionRepo>(),
      ),
    );
    gh.factory<_i1041.ProfileCubit>(
      () => _i1041.ProfileCubit(gh<_i525.GetProfileUseCase>()),
    );
    gh.factory<_i458.AddAddressUseCase>(
      () => _i458.AddAddressUseCase(gh<_i767.AddressRepo>()),
    );
    gh.factory<_i594.GetAddressesUseCase>(
      () => _i594.GetAddressesUseCase(gh<_i767.AddressRepo>()),
    );
    gh.factory<_i465.RemoveAddressUseCase>(
      () => _i465.RemoveAddressUseCase(gh<_i767.AddressRepo>()),
    );
    gh.factory<_i130.UpdateAddressUseCase>(
      () => _i130.UpdateAddressUseCase(gh<_i767.AddressRepo>()),
    );
    gh.factory<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(
        authRemoteDataSourceContract: gh<_i107.AuthRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i1050.SavedAddressesCubit>(
      () => _i1050.SavedAddressesCubit(
        gh<_i594.GetAddressesUseCase>(),
        gh<_i465.RemoveAddressUseCase>(),
      ),
    );
    gh.factory<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(authRepo: gh<_i723.AuthRepo>()),
    );
    gh.lazySingleton<_i499.CartCubit>(
      () => _i499.CartCubit(
        gh<_i802.AddProductToCartUseCase>(),
        gh<_i488.GetCartUseCase>(),
        gh<_i650.RemoveCartItemUseCase>(),
        gh<_i157.UpdateCartItemQuantityUseCase>(),
      ),
    );
    gh.factory<_i516.DeleteNotificationUseCase>(
      () => _i516.DeleteNotificationUseCase(
        gh<_i688.NotificationsRepoContract>(),
      ),
    );
    gh.factory<_i837.GetUnreadNotificationCountUseCase>(
      () => _i837.GetUnreadNotificationCountUseCase(
        gh<_i688.NotificationsRepoContract>(),
      ),
    );
    gh.factory<_i392.GetUserNotificationsUseCase>(
      () => _i392.GetUserNotificationsUseCase(
        gh<_i688.NotificationsRepoContract>(),
      ),
    );
    gh.factory<_i1043.MarkNotificationAsReadUseCase>(
      () => _i1043.MarkNotificationAsReadUseCase(
        gh<_i688.NotificationsRepoContract>(),
      ),
    );
    gh.factory<_i406.SaveOrderUserInfoUseCase>(
      () => _i406.SaveOrderUserInfoUseCase(gh<_i400.OrderUserInfoRepo>()),
    );
    gh.factory<_i538.ProductCubit>(
      () =>
          _i538.ProductCubit(getProductUseCase: gh<_i713.GetProductsUseCase>()),
    );
    gh.lazySingleton<_i755.CheckoutRepo>(
      () => _i32.CheckoutRepoImpl(
        remoteDataSource: gh<_i336.CheckoutRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i585.ConfirmDeliveryUseCase>(
      () => _i585.ConfirmDeliveryUseCase(gh<_i528.TrackOrderRepoContract>()),
    );
    gh.factory<_i1061.GetCurrentOrderUseCase>(
      () => _i1061.GetCurrentOrderUseCase(gh<_i528.TrackOrderRepoContract>()),
    );
    gh.factory<_i772.SaveCurrentOrderUseCase>(
      () => _i772.SaveCurrentOrderUseCase(gh<_i528.TrackOrderRepoContract>()),
    );
    gh.factory<_i293.WatchOrderStateUseCase>(
      () => _i293.WatchOrderStateUseCase(gh<_i528.TrackOrderRepoContract>()),
    );
    gh.lazySingleton<_i129.OccasionCubit>(
      () => _i129.OccasionCubit(
        getOccasionUseCase: gh<_i529.GetOccasionsUseCase>(),
      ),
    );
    gh.factory<_i771.ChangePasswordUseCase>(
      () => _i771.ChangePasswordUseCase(gh<_i723.AuthRepo>()),
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
    gh.factory<_i644.AddAddressCubit>(
      () => _i644.AddAddressCubit(
        gh<_i458.AddAddressUseCase>(),
        gh<_i130.UpdateAddressUseCase>(),
        gh<_i114.LoadLocationLookupsUseCase>(),
        gh<_i990.GetCurrentLocationUseCase>(),
      ),
    );
    gh.factory<_i995.ForgetPasswordCubit>(
      () => _i995.ForgetPasswordCubit(
        gh<_i27.ForgetPasswordUseCase>(),
        gh<_i887.VerifyResetCodeUseCase>(),
      ),
    );
    gh.factory<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(registerRepoContract: gh<_i723.AuthRepo>()),
    );
    gh.factory<_i301.ProductDetailsCubit>(
      () => _i301.ProductDetailsCubit(
        getProductByIdUseCase: gh<_i1049.GetProductByIdUseCase>(),
      ),
    );
    gh.factory<_i404.RegisterCubit>(
      () => _i404.RegisterCubit(gh<_i1010.RegisterUseCase>()),
    );
    gh.factory<_i783.CategoryProductsCubit>(
      () => _i783.CategoryProductsCubit(
        getCategoriesUseCase: gh<_i406.GetCategoriesUseCase>(),
        getProductUseCase: gh<_i713.GetProductsUseCase>(),
      ),
    );
    gh.factory<_i727.OrdersCubit>(
      () => _i727.OrdersCubit(gh<_i755.GetOrdersUseCase>()),
    );
    gh.factory<_i179.LoginCubit>(
      () => _i179.LoginCubit(gh<_i1038.LoginUseCase>()),
    );
    gh.factory<_i932.TrackOrderCubit>(
      () => _i932.TrackOrderCubit(
        gh<_i293.WatchOrderStateUseCase>(),
        gh<_i585.ConfirmDeliveryUseCase>(),
        gh<_i772.SaveCurrentOrderUseCase>(),
        gh<_i1061.GetCurrentOrderUseCase>(),
      ),
    );
    gh.factory<_i1017.CheckoutWithCardUseCase>(
      () => _i1017.CheckoutWithCardUseCase(gh<_i755.CheckoutRepo>()),
    );
    gh.factory<_i421.CheckoutWithCashUseCase>(
      () => _i421.CheckoutWithCashUseCase(gh<_i755.CheckoutRepo>()),
    );
    gh.factory<_i309.OccasionsProductsCubit>(
      () => _i309.OccasionsProductsCubit(
        getOccasionUseCase: gh<_i529.GetOccasionsUseCase>(),
        getProductUseCase: gh<_i713.GetProductsUseCase>(),
      ),
    );
    gh.factory<_i532.NotificationsCubit>(
      () => _i532.NotificationsCubit(
        getUserNotificationsUseCase: gh<_i392.GetUserNotificationsUseCase>(),
        getUnreadCountUseCase: gh<_i837.GetUnreadNotificationCountUseCase>(),
        markNotificationAsReadUseCase:
            gh<_i1043.MarkNotificationAsReadUseCase>(),
        deleteNotificationUseCase: gh<_i516.DeleteNotificationUseCase>(),
      ),
    );
    gh.factory<_i217.CheckoutCubit>(
      () => _i217.CheckoutCubit(
        gh<_i421.CheckoutWithCashUseCase>(),
        gh<_i1017.CheckoutWithCardUseCase>(),
        gh<_i406.SaveOrderUserInfoUseCase>(),
        gh<_i525.GetProfileUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i236.FirebaseModule {}

class _$NetworkModule extends _i234.NetworkModule {}
