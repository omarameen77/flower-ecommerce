import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_event.dart';
import 'package:flower/features/profile/presentation/widgets/profile_avatar_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditPhotoHeader extends StatelessWidget {
  const ProfileEditPhotoHeader({super.key, this.initialImageUrl});

  final String? initialImageUrl;

  static const double _size = 108;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && context.mounted) {
      context.read<ProfileEditCubit>().doEvent(
        ProfileEditPhotoChanged(File(pickedFile.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      buildWhen: (previous, current) =>
          previous.photo != current.photo ||
          previous.uploadPhotoState != current.uploadPhotoState,
      builder: (context, state) {
        final photoFile = state.photo;
        final uploading = state.uploadPhotoState.isLoading;

        return Center(
          child: Stack(
            children: [
              Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.35),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: ClipOval(
                    // fixed: original used `height: 10` on the picked
                    // image, which squashed it to a sliver — now fills
                    // the full circle like the placeholder does.
                    child: photoFile != null
                        ? Image.file(
                            photoFile,
                            fit: BoxFit.cover,
                            width: _size,
                            height: _size,
                          )
                        : ProfileAvatarPlaceholder(
                            imageUrl: initialImageUrl,
                            width: _size,
                            height: _size,
                          ),
                  ),
                ),
              ),
              if (uploading)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: uploading ? null : () => _pickImage(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
