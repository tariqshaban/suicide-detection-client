import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../enums/snack_bar_type.dart';

class SnackBarHelper {
  static void showSnackBar(
    BuildContext context, {
    required String title,
    String? message,
    required SnackBarType snackBarType,
    Duration? duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      icon: Padding(
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Icon(
            _getIconBySnackBarType(snackBarType: snackBarType),
            color: _getContentColorBySnackBarType(snackBarType: snackBarType),
          ),
        ),
      ),
      messageText: Text(
        title,
        style: TextStyle(
          color: _getContentColorBySnackBarType(snackBarType: snackBarType),
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor:
          _getBackgroundColorBySnackBarType(snackBarType: snackBarType)!,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(16),
      duration: duration,
    ).show(context);
  }

  static IconData _getIconBySnackBarType({
    required SnackBarType snackBarType,
  }) {
    switch (snackBarType) {
      case SnackBarType.error:
        return Icons.cancel_outlined;
      case SnackBarType.warning:
        return Icons.error_outline;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle_outline;
    }
  }

  static Color? _getBackgroundColorBySnackBarType({
    required SnackBarType snackBarType,
  }) {
    switch (snackBarType) {
      case SnackBarType.error:
        return Colors.red[100];
      case SnackBarType.warning:
        return Colors.yellow[100];
      case SnackBarType.info:
        return Colors.blue[100];
      case SnackBarType.success:
        return Colors.green[100];
    }
  }

  static Color _getContentColorBySnackBarType({
    required SnackBarType snackBarType,
  }) {
    switch (snackBarType) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
      case SnackBarType.success:
        return Colors.green;
    }
  }
}
