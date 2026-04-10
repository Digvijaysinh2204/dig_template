import 'package:flutter/cupertino.dart';
import '../utils/import.dart';

Future<void> showAdaptiveActionSheet({
  required BuildContext context,
  required String title,
  required List<AdaptiveAction> actions,
  bool titleCapitalize = false,
  String? message,
  VoidCallback? onCancel,
}) {
  if (GetPlatform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: CustomTextView(
          text: title,
          capitalize: titleCapitalize,
          textAlign: TextAlign.center,
          style: AppTextStyle.bold(
            size: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        message: message != null
            ? CustomTextView(
                text: message,
                style: AppTextStyle.regular(
                  size: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              )
            : null,
        actions: actions
            .map(
              (a) => CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  a.onPressed();
                },
                isDestructiveAction: a.isDestructive,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (a.iconWidget != null) ...[
                      a.iconWidget!,
                      const SizedBox(width: 8),
                    ] else if (a.icon != null) ...[
                      Icon(
                        a.icon,
                        size: 20,
                        color: a.isDestructive
                            ? AppColor.kError
                            : AppColor.kPrimary,
                      ),
                      const SizedBox(width: 8),
                    ],
                    CustomTextView(
                      text: a.label,
                      style: a.isDestructive
                          ? AppTextStyle.bold(size: 17, color: AppColor.kError)
                          : AppTextStyle.medium(
                              size: 17,
                              color: AppColor.kPrimary,
                            ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          child: CustomTextView(
            text: context.loc.cancel,
            style: AppTextStyle.bold(size: 17, color: AppColor.kPrimary),
          ),
          onPressed: () {
            Get.back();
            if (onCancel != null) onCancel();
          },
        ),
      ),
    );
  } else {
    return showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(24),
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextView(
                  text: title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold(
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            if (message != null) ...[
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextView(
                  text: message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular(
                    size: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
            const Gap(16),
            const Divider(height: 1),
            ...List.generate(actions.length, (index) {
              final a = actions[index];
              return Column(
                children: [
                  CustomInkWell(
                    clickName: a.clickName ?? '',
                    onTap: () {
                      Get.back();
                      a.onPressed();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          if (a.iconWidget != null) ...[
                            a.iconWidget!,
                            const Gap(16),
                          ] else if (a.icon != null) ...[
                            Icon(
                              a.icon,
                              size: 22,
                              color: a.isDestructive
                                  ? AppColor.kError
                                  : Theme.of(context).colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                            ),
                            const Gap(16),
                          ],
                          Expanded(
                            child: CustomTextView(
                              text: a.label,
                              style: AppTextStyle.medium(
                                size: 16,
                                color: a.isDestructive
                                    ? AppColor.kError
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != actions.length - 1) const Divider(height: 1),
                ],
              );
            }),
            const Gap(8),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: CustomButton(
                  width: double.infinity,
                  text: context.loc.cancel,
                  onTap: () {
                    Get.back();
                    if (onCancel != null) onCancel();
                  },
                  bgColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.05),
                  textColors: Theme.of(context).colorScheme.onSurface,
                  clickName: 'cancel_action_sheet',
                ),
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}

class AdaptiveAction {
  final String label;
  final String? clickName;
  final VoidCallback onPressed;
  final bool isDestructive;
  final IconData? icon;
  final Widget? iconWidget;
  AdaptiveAction({
    required this.label,
    required this.onPressed,
    this.clickName,
    this.isDestructive = false,
    this.icon,
    this.iconWidget,
  });
}
