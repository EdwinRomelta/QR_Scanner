import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  static void show(
    BuildContext context,
  ) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const LoadingDialog._(),
      );

  static void hide(
    BuildContext context,
  ) =>
      Navigator.of(context).pop();

  const LoadingDialog._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
