import '../utils/import.dart';

class CustomNoDataFound extends StatelessWidget {
  const CustomNoDataFound({
    super.key,
    this.title,
    this.imagePath,
    this.onRetry,
    this.retryText,
  });
  final String? title;
  final String? imagePath;
  final VoidCallback? onRetry;
  final String? retryText;
  @override
  Widget build(BuildContext context) {
    final textColor = AppColor.text(context);
    final loc = context.loc;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null) ...[
              Image.asset(imagePath!, height: 150),
              const SizedBox(height: 20),
            ],
            CustomTextView(
              text: title ?? loc.noDataFound,
              style: AppTextStyle.medium(
                size: 16,
                color: textColor.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.kPrimary,
                  foregroundColor: AppColor.kWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: CustomTextView(text: retryText ?? 'Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
