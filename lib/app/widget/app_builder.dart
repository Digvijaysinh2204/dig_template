import '../utils/import.dart';
class AppBuilder extends StatelessWidget {
  final Widget child;
  const AppBuilder({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: Obx(() {
        final isConnected = Get.find<NetworkService>().isConnected.value;
        return PopScope(
          canPop: isConnected,
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: !isConnected,
                child: child,
              ),
              const NetworkBanner(),
              const GlobalLoader(),
              if (!isConnected)
                const Positioned.fill(
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.transparent,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
