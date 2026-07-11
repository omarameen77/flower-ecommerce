import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfoWidget extends StatelessWidget {
  final UserData? user;

  const DriverInfoWidget({super.key, this.user});

  Future<void> _makePhoneCall(BuildContext context) async {
    final phone = user?.phone;
    if (phone == null || phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    try {
      await launchUrl(uri);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Call $phone')));
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final phone = user?.phone;
    if (phone == null || phone.isEmpty) return;
    final clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.isEmpty) return;
    final uri = Uri.parse('https://wa.me/$clean');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('WhatsApp $phone')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = user != null
        ? '${user!.firstName ?? ''} ${user!.lastName ?? ''}'.trim()
        : TrackOrderConstants.driverInfo;
    final initial = name.isNotEmpty ? name[0] : 'D';
    final phone = user?.phone;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey700, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (user?.photo != null && user!.photo!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImageWidget(
                urlToImage: user!.photo!,
                width: 56,
                height: 56,
              ),
            )
          else
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: getBoldStyle(
                    context: context,
                    fontSize: 22,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: getSemiBoldStyle(
                    context: context,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (phone != null && phone.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: getRegularStyle(
                      context: context,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _makePhoneCall(context),
                icon: const Icon(Icons.phone, color: AppColors.primary),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                splashRadius: 20,
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () => _openWhatsApp(context),
                icon: const Icon(Icons.chat_bubble, color: AppColors.primary),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                splashRadius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
