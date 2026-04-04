import 'dart:ui';
import '../utils/import.dart';
enum ToastType { success, error, warning, info }
class ToastService extends GetxService {
  void show({String message = '', ToastType type = ToastType.warning}) {
    if (message.trim().isEmpty) return;
    toastification.showCustom(
      alignment: Alignment.topCenter,
      autoCloseDuration: Duration(seconds: _getDuration(type)),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      builder: (context, holder) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(type),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getIcon(type),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CustomTextView(
                        text: message,
                        style: AppTextStyle.medium(
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(8),
                    CustomInkWell(
                      onTap: () => toastification.dismissById(holder.id),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white.withValues(alpha: 0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Color _getBackgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColor.kSuccess.withValues(alpha: 0.85);
      case ToastType.error:
        return AppColor.kError.withValues(alpha: 0.85);
      case ToastType.warning:
        return AppColor.kWarning.withValues(alpha: 0.85);
      case ToastType.info:
        return AppColor.kPrimary.withValues(alpha: 0.85);
    }
  }
  IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle_rounded;
      case ToastType.error:
        return Icons.error_rounded;
      case ToastType.warning:
        return Icons.warning_rounded;
      case ToastType.info:
        return Icons.info_rounded;
    }
  }
  int _getDuration(ToastType type) {
    switch (type) {
      case ToastType.success:
        return 3;
      case ToastType.error:
        return 5;
      case ToastType.warning:
        return 4;
      case ToastType.info:
        return 4;
    }
  }
}
