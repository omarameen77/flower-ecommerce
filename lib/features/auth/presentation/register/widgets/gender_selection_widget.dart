import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionWidget extends StatelessWidget {
  const GenderSelectionWidget({super.key});
  
  // I DID NOT FORGET THIS PART !! I NEED IT !! THE STRING CLASS NOT WORK WITH RADIO !!
  static const String _femaleValue = 'female';
  static const String _maleValue = 'male';

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (context.read<RegisterCubit>().state.selectedGender.isEmpty) {
          return context.requiredField;
        }
        return null;
      },
      builder: (formFieldState) {
        return BlocBuilder<RegisterCubit, RegisterState>(
          buildWhen: (previous, current) =>
              previous.selectedGender != current.selectedGender,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      context.gender,
                      style: getMediumStyle(
                        context: context,
                        color: AppColors.textPrimary,
                        fontSize: FontSizeManager.s16,
                      ),
                    ),
                    const AppSizedBox(width: 40),
                    InkWell(
                      onTap: () {
                        context.read<RegisterCubit>().doEvent(
                          ChangeGender(_femaleValue),
                        );
                        formFieldState.didChange(_femaleValue);
                      },
                      child: Row(
                        children: [
                          Radio<String>(
                            value: _femaleValue,
                            groupValue: state.selectedGender,
                            activeColor: AppColors.primary,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              context.read<RegisterCubit>().doEvent(
                                ChangeGender(value!),
                              );
                              formFieldState.didChange(value);
                            },
                          ),
                          Text(
                            context.female,
                            style: getRegularStyle(
                              context: context,
                              color: AppColors.textPrimary,
                              fontSize: FontSizeManager.s14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const AppSizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        context.read<RegisterCubit>().doEvent(
                          ChangeGender(_maleValue),
                        );
                        formFieldState.didChange(_maleValue);
                      },
                      child: Row(
                        children: [
                          Radio<String>(
                            value: _maleValue,
                            groupValue: state.selectedGender,
                            activeColor: AppColors.primary,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              context.read<RegisterCubit>().doEvent(
                                ChangeGender(value!),
                              );
                              formFieldState.didChange(value);
                            },
                          ),
                          Text(
                            context.male,
                            style: getRegularStyle(
                              context: context,
                              color: AppColors.textPrimary,
                              fontSize: FontSizeManager.s14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (formFieldState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                    child: Text(
                      formFieldState.errorText!,
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.error,
                        fontSize: FontSizeManager.s12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
