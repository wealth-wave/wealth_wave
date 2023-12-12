import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorPageWidget extends StatelessWidget {
  final dynamic error;
  final String? message;
  final VoidCallback? callback;

  const ErrorPageWidget(
      {super.key, required this.error, this.message, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (kDebugMode)
          Text(error?.toString() ?? "No error",
              style: Theme.of(context).textTheme.bodySmall),
        Text(message ?? "Something went wrong",
            style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
