import 'package:flutter/material.dart';

class DialogUtils {
  static void showAppDialog(
      {required BuildContext context,
        String? titleTxt,
        String? message,
        String actionBtnText = "Dismiss",
        VoidCallback? onAction,
        String? secondaryActionBtnTxt,
        VoidCallback? onSecondaryAction}) {
    AlertDialog alert = AlertDialog(
      title: titleTxt != null ? Text(titleTxt) : null,
      content: message != null ? Text(message) : null,
      actions: [
        secondaryActionBtnTxt != null
            ? TextButton(
          child: Text(secondaryActionBtnTxt),
          onPressed: () {
            Navigator.pop(context);
            if (onSecondaryAction != null) {
              onSecondaryAction();
            }
          },
        )
            : Container(),
        TextButton(
          child: Text(actionBtnText),
          onPressed: () {
            Navigator.pop(context);
            if (onAction != null) {
              onAction();
            }
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
