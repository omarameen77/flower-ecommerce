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
                Text(
                  context.gender,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: FontSizeManager.s14,
                  ),
                ),

                const AppSizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: _GenderOption(
                        label: context.female,
                        value: _femaleValue,
                        selected: state.selectedGender == _femaleValue,
                        onTap: () {
                          context.read<RegisterCubit>().doEvent(
                            ChangeGender(_femaleValue),
                          );

                          formFieldState.didChange(_femaleValue);
                        },
                      ),
                    ),

                    const AppSizedBox(width: 12),

                    Expanded(
                      child: _GenderOption(
                        label: context.male,
                        value: _maleValue,
                        selected: state.selectedGender == _maleValue,
                        onTap: () {
                          context.read<RegisterCubit>().doEvent(
                            ChangeGender(_maleValue),
                          );

                          formFieldState.didChange(_maleValue);
                        },
                      ),
                    ),
                  ],
                ),

                if (formFieldState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
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

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isMale = value == 'male';

    final Color selectedColor = isMale ? Colors.lightBlue : AppColors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor.withOpacity(0.08)
              : AppColors.background.withOpacity(0.65),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? selectedColor.withOpacity(0.50)
                : AppColors.grey700.withOpacity(0.12),
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: selected ? value : null,
              onChanged: (_) => onTap(),
              activeColor: selectedColor,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            const AppSizedBox(width: 4),

            Expanded(
              child: Text(
                label,
                style: getRegularStyle(
                  context: context,
                  color: selected ? selectedColor : AppColors.textPrimary,
                  fontSize: FontSizeManager.s14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
