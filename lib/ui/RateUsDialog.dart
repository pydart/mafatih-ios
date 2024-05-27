import 'package:flutter/material.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mafatih/library/Globals.dart' as globals;

class RateUsDialog extends StatefulWidget {
  final String appPackageName; // Package name of your app on Google Play

  RateUsDialog({required this.appPackageName});

  @override
  _RateUsDialogState createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  double _rating = 0.0;

  // Launches the Google Play page for rating the app with the provided rating
  Future<void> _launchPlayStoreWithRating(double rating) async {
    final url = 'https://play.google.com/store/apps/details?id=pydart.mafatih&reviewId=$rating';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  setOneTimeRateUs() async {
    prefs = await SharedPreferences.getInstance();

    bool level = false;
    globals.oneTimeRateUs = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.OneTimeRateUs, level);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate Us'),
      content: Column(
        children: [
          Text('Enjoying the app? Please take a moment to rate us on Google Play.'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () => setState(() => _rating = i.toDouble()),
                  child: Icon(
                    Icons.star,
                    color: i <= _rating ? Colors.orange : Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Later'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Rate Now'),
          onPressed: _rating > 0 ? () => _launchPlayStoreWithRating(_rating) : null,
        ),
      ],
    );
  }
}


