import 'package:cat_tinder_pro/core/di/injection_container.dart';
import 'package:cat_tinder_pro/presentation/blocs/connection_blocs/connection_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/connection_blocs/connection_event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionListener {
  ConnectionBloc get _connectionBloc => getIt<ConnectionBloc>();

  late final Connectivity connectivity;

  ConnectionListener() {
    connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen(_getConnectivityResult);
  }

  void _getConnectivityResult(List<ConnectivityResult> result) {
    if (result.isNotEmpty &&
        !result.any((res) => res == ConnectivityResult.none)) {
      // has any connection

      _connectionBloc.add(ConnectionEvent(hasConnection: true));
    } else {
      _connectionBloc.add(ConnectionEvent(hasConnection: false));
    }
  }

  Future<bool> checkConnection() async {
    final result = await connectivity.checkConnectivity();

    if (result.isNotEmpty &&
        !result.any((res) => res == ConnectivityResult.none)) {
      return true;
    }

    return false;
  }
}
