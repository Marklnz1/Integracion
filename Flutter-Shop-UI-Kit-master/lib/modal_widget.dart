import 'package:flutter/material.dart';

class ModalWidget {
  static Future<void> show(context, Widget widget) async {
    // double maxWidth = MediaQuery.of(context).size.width;
    // double maxHeight = MediaQuery.of(context).size.height;

    await showDialog(
      context: context,
      barrierDismissible: false,

      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      // barrierColor: Colors.black54,

      builder: (context) => Center(
        child: widget,
      ),
    );
  }
}
