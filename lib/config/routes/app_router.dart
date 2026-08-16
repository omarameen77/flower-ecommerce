import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/exit_wrapper.dart';
import 'package:flower/config/routes/page_transitions.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/widgets/not_found_screen.dart';
import 'package:flower/features/app_sections/presentation/pages/app_sections_page.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/presentation/add_address/pages/add_address_screen.dart';
import 'package:flower/features/address/presentation/saved_addresses/pages/saved_addresses_screen.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_cubit.dart';
import 'package:flower/features/auth/presentation/change_password/pages/change_password_screen.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:flower/features/auth/presentation/login/pages/login_screen.dart';
import 'package:flower/features/auth/presentation/register/pages/register_page.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/pages/reset_password_screen.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/pages/verify_reset_code_screen.dart';
import 'package:flower/features/checkout/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:flower/features/checkout/presentation/checkout/pages/checkout_page.dart';
import 'package:flower/features/checkout/presentation/checkout/pages/payment_web_view_page.dart';
import 'package:flower/features/checkout/presentation/checkout/pages/thank_you_page.dart';
import 'package:flower/features/orders/presentation/orders/cubit/orders_cubit.dart';
import 'package:flower/features/orders/presentation/orders/pages/orders_page.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/search_cubit/search_cubit.dart';
import 'package:flower/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:flower/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flower/features/profile/presentation/pages/profile_edit_page.dart';
import 'package:flower/features/notifications/ui/pages/notifications_page.dart';
import 'package:flower/features/product_sections/presentation/best_sellers/pages/best_sellers_page.dart';
import 'package:flower/features/product_sections/presentation/occasions/pages/occasions_page.dart';
import 'package:flower/features/product_sections/presentation/product_details/pages/product_details_page.dart';
import 'package:flower/features/product_sections/presentation/search/search_screen.dart';
import 'package:flower/features/profile/presentation/pages/about_us_page.dart';
import 'package:flower/features/profile/presentation/pages/terms_conditions_page.dart';
import 'package:flower/features/splash/presentation/pages/splash_screen.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower/features/track_order/presentation/pages/track_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.login:
          return PageTransitions.fade(const LoginScreen());
        case Routes.splash:
          return PageTransitions.fade(const SplashScreen());

        case Routes.signup:
          return PageTransitions.slide(const RegisterPage());

        case Routes.bestSellers:
          return PageTransitions.slide(const BestSellersPage());

        case Routes.productDetails:
          final id = settings.arguments as String? ?? '';
          return PageTransitions.slide(ProductDetailsPage(productId: id));

        case Routes.appSections:
          return PageTransitions.slide(
            ExitWrapper(child: const AppSectionsPage()),
          );

        case Routes.occasions:
          final id = settings.arguments as String?;
          return PageTransitions.slide(OccasionsPage(initialOccasionId: id));

        case Routes.forgetPassword:
          return PageTransitions.fade(
            BlocProvider(
              create: (_) => getIt<ForgetPasswordCubit>(),
              child: const ForgetPasswordScreen(),
            ),
          );

        case Routes.verificationCode:
          final email = settings.arguments as String? ?? '';
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<VerifyResetCodeCubit>(),
              child: VerifyResetCodeScreen(email: email),
            ),
          );

        case Routes.resetPassword:
          final email = settings.arguments as String? ?? '';
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordScreen(email: email),
            ),
          );

        case Routes.changePassword:
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<ChangePasswordCubit>(),
              child: const ChangePasswordScreen(),
            ),
          );

        case Routes.addAddress:
          final edit = settings.arguments as AddressEntity?;
          return PageTransitions.slide(AddAddressScreen(editAddress: edit));

        case Routes.savedAddresses:
          return PageTransitions.slide(const SavedAddressesScreen());
        case Routes.searchScreen:
          final args = settings.arguments as Map<String, dynamic>? ?? {};

          final productCubit = args['productCubit'] as ProductCubit?;

          final type =
              args['transitionType'] as SearchTransitionType? ??
              SearchTransitionType.category;

          return PageTransitions.search(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => SearchCubit(getIt())),
                if (productCubit != null)
                  BlocProvider.value(value: productCubit),
              ],
              child: const SearchScreen(),
            ),
            type: type,
          );

        case Routes.editProfile:
          final user = settings.arguments as UserEntity?;
          if (user == null) {
            return PageTransitions.fade(
              NotFoundScreen(route: Routes.editProfile),
            );
          }
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => ProfileEditCubit(
                getIt<UpdateProfileUseCase>(),
                getIt<UploadPhotoUseCase>(),
                user,
              ),
              child: const ProfileEditPage(),
            ),
          );

        case Routes.aboutUs:
          return PageTransitions.slide(const AboutUsPage());
        case Routes.termsConditions:
          return PageTransitions.slide(const TermsConditionsPage());
        case Routes.notifications:
          return PageTransitions.slide(const NotificationsPage());
        case Routes.checkout:
          final subtotal = settings.arguments as int? ?? 0;
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<CheckoutCubit>(),
              child: CheckoutPage(subtotal: subtotal),
            ),
          );

        case Routes.thankYou:
          return PageTransitions.slide(const ThankYouPage());

        case Routes.paymentWebView:
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final url = args['url'] as String? ?? '';
          final successUrl = args['successUrl'] as String?;
          final cancelUrl = args['cancelUrl'] as String?;
          return PageTransitions.slide(
            PaymentWebViewPage(
              url: url,
              successUrl: successUrl,
              cancelUrl: cancelUrl,
            ),
          );

        case Routes.orders:
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<OrdersCubit>(),
              child: const OrdersPage(),
            ),
          );

        case Routes.trackOrder:
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          final orderId = args['orderId'] as String? ?? '';
          final orderData = args['orderData'] != null
              ? TrackOrderEntity.fromMap(
                  args['orderData'] as Map<String, dynamic>,
                )
              : null;
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<TrackOrderCubit>(),
              child: TrackOrderPage(orderId: orderId, orderData: orderData),
            ),
          );

        default:
          return PageTransitions.fade(
            NotFoundScreen(route: settings.name ?? ''),
          );
      }
    } catch (_) {
      return PageTransitions.fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }
}
