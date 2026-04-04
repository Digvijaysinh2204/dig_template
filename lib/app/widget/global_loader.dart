import '../utils/import.dart';
class GlobalLoader extends GetView<AppLoadingService> {
  const GlobalLoader({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isLoading) {
        return const SizedBox.shrink();
      }
      return Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: const Center(
          child: Loader(size: 30),
        ),
      );
    });
  }
}
