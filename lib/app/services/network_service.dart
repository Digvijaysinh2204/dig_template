import '../utils/import.dart';
class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final _isConnected = true.obs;
  RxBool get isConnected => _isConnected;
  Future<NetworkService> init() async {
    final List<ConnectivityResult> results = await _connectivity
        .checkConnectivity();
    _updateStatus(results);
    _connectivity.onConnectivityChanged.listen(_updateStatus);
    return this;
  }
  void _updateStatus(List<ConnectivityResult> results) {
    _isConnected.value = !results.contains(ConnectivityResult.none);
    kLog(
      title: 'NETWORK_STATUS',
      content: _isConnected.value ? 'ONLINE' : 'OFFLINE',
    );
  }
}
