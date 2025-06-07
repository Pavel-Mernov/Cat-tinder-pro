import 'package:cat_tinder_pro/presentation/blocs/connection_blocs/connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionSnackbar extends StatelessWidget {
  const ConnectionSnackbar({super.key});

  Widget _buildSnackbar(BuildContext context, bool state) {
    return SnackBar(
      content: SnackBar(
        content: Text(
          state ? 'Успешно' : 'Ошибка',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: state ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, bool>(builder: _buildSnackbar);
  }
}
