import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flower/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flower/features/profile/presentation/widgets/profile_scrollable_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: const _ProfilePageBootstrap(),
    );
  }
}

class _ProfilePageBootstrap extends StatefulWidget {
  const _ProfilePageBootstrap();

  @override
  State<_ProfilePageBootstrap> createState() => _ProfilePageBootstrapState();
}

class _ProfilePageBootstrapState extends State<_ProfilePageBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      _dispatchOpened();
    });
  }

  void _dispatchOpened() {
    if (!mounted) return;
    context.read<ProfileCubit>().doEvent(
      ProfileOpened(languageCode: context.locale.languageCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _ProfilePageView();
  }
}

class _ProfilePageView extends StatelessWidget {
  const _ProfilePageView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.languageCode != current.languageCode,
      listener: (context, state) {
        if (state.languageCode != context.locale.languageCode) {
          context.setLocale(Locale(state.languageCode));
        }
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            previous.logoutState != current.logoutState,
        listener: (context, state) {
          if (state.logoutState.data == true) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
          } else if (state.logoutState.errorMessage != null) {
            CustomSnackBar.error(context, state.logoutState.errorMessage!);
          }
        },
        child: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.profileState.errorMessage !=
                  current.profileState.errorMessage &&
              current.profileState.errorMessage != null,
          listener: (context, state) {
            CustomSnackBar.error(context, state.profileState.errorMessage!);
          },
          child: const Scaffold(
            appBar: ProfileAppBar(),
            body: ProfileScrollableBody(),
          ),
        ),
      ),
    );
  }
}
