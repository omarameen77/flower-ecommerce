import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flower/features/profile/presentation/widgets/profile_avatar_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePhotoHeader extends StatelessWidget {
  const EditProfilePhotoHeader({super.key, this.initialImageUrl});

  final String? initialImageUrl;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && context.mounted) {
      context.read<EditProfileCubit>().doEvent(
        EditProfilePhotoChanged(File(pickedFile.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: ClipOval(
                  child: photoFile != null
                      ? Image.file(photoFile, fit: BoxFit.cover)
                      : ProfileAvatarPlaceholder(
                          imageUrl: initialImageUrl,
                          width: 100,
                          height: 100,
                        ),
                ),
              ),
              if (uploading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: uploading ? null : () => _pickImage(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
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
