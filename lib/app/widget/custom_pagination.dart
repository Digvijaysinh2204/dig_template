import '../utils/import.dart';
class CustomPagination extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final Widget child;
  final RxBool isLoading;
  final RxBool hasMore;
  const CustomPagination({
    super.key,
    this.onRefresh,
    this.onLoadMore,
    required this.child,
    required this.isLoading,
    required this.hasMore,
  });
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      notificationPredicate: (notification) => onRefresh != null,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 100) {
            if (!isLoading.value && hasMore.value && onLoadMore != null) {
              onLoadMore!();
            }
          }
          return false;
        },
        child: child,
      ),
    );
  }
}
