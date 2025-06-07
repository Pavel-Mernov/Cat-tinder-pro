import 'package:cat_tinder_pro/presentation/blocs/connection_blocs/connection_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, bool> {
  final bool initialConnection;

  void _onConnectionEvent(ConnectionEvent event, Emitter<bool> emit) {
    emit(event.hasConnection);
  }

  ConnectionBloc(this.initialConnection) : super(initialConnection) {
    on<ConnectionEvent>(_onConnectionEvent);
  }
}
