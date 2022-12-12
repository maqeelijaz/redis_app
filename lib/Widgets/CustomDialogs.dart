import 'package:flutter/material.dart';
import 'package:redis/Config/ColorConfig.dart';

class CustomDialogs {
  Future errorDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            actions: [
              TextButton(
                  style:
                      TextButton.styleFrom(padding: const EdgeInsets.all(5.0)),
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context, true)),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: errorWidget(title, content, context));
      },
    );
  }

  Future successDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(5.0)),
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
          content: successWidget(title, content, context),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }

  Widget errorWidget(title, content, _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Icon(
          Icons.error,
          color: CUSTOMPRIMARYCOLOR,
          size: 50,
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Text(
          content,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget successWidget(title, content, _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Icon(
          Icons.check_circle_rounded,
          color: CUSTOMPRIMARYCOLOR,
          size: 50,
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Text(
          content,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
