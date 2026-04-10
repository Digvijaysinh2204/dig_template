import 'package:flutter/cupertino.dart';

import '../utils/import.dart';

Future<T?> showAppAdaptiveDialog<T>({
  required BuildContext context,
  required String title,
  String? message,
  required String primaryActionLabel,
  required VoidCallback onPrimaryAction,
  String? secondaryActionLabel,
  VoidCallback? onSecondaryAction,
  bool isDestructive = false,
  Widget? content,
}) {
  if (GetPlatform.isIOS) {
    return showCupertinoDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: CustomTextView(text: title, style: AppTextStyle.bold(size: 17)),
        content: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message != null && message.isNotEmpty) ...[
                CustomTextView(
                  text: message,
                  style: AppTextStyle.regular(size: 13),
                ),
                if (content != null) const Gap(12),
              ],
              ?content,
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
              if (onSecondaryAction != null) onSecondaryAction();
            },
            child: CustomTextView(
              text: secondaryActionLabel ?? context.loc.cancel,
              style: AppTextStyle.medium(size: 17, color: AppColor.kPrimary),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            onPressed: () {
              Get.back();
              onPrimaryAction();
            },
            child: CustomTextView(
              text: primaryActionLabel,
              style: AppTextStyle.bold(
                size: 17,
                color: isDestructive ? AppColor.kError : AppColor.kPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return showDialog<T>(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: CustomTextView(text: title, style: AppTextStyle.bold(size: 18)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != null && message.isNotEmpty) ...[
            CustomTextView(
              text: message,
              style: AppTextStyle.regular(size: 14),
            ),
            if (content != null) const Gap(16),
          ],
          ?content,
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            if (onSecondaryAction != null) onSecondaryAction();
          },
          child: CustomTextView(
            text: secondaryActionLabel ?? context.loc.cancel,
            style: AppTextStyle.medium(
              size: 14,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            onPrimaryAction();
          },
          child: CustomTextView(
            text: primaryActionLabel,
            style: AppTextStyle.bold(
              size: 14,
              color: isDestructive ? AppColor.kError : AppColor.kPrimary,
            ),
          ),
        ),
      ],
    ),
  );
}
