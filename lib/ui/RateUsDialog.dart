import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUsDialog extends StatelessWidget {
  final String appPackageName; // Package name of your app on Google Play

  RateUsDialog({required this.appPackageName});

  // Launches the Google Play page for rating the app
  Future<void> _launchPlayStore() async {
    final url = 'https://play.google.com/store/apps/details?id=$appPackageName';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate Us'),
      content: Text('Enjoying the app? Please take a moment to rate us on Google Play.'),
      actions: [
        TextButton(
          child: Text('Later'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Rate Now'),
          onPressed: () {
            _launchPlayStore();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}