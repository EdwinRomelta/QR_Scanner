import 'package:flutter/material.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String message;

  const ErrorBottomSheet._({String? message, Key? key})
      : message = message ?? 'Oops, something went wrong, please try again',
        super(key: key);

  static void show(BuildContext context, String? message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) => ErrorBottomSheet._(
        message: message,
      ),
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
