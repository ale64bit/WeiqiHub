import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/settings/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.about),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 192, maxWidth: 192),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset('assets/images/icons/app.png'),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final pInfo = snapshot.data;
                  return Text('WeiqiHub ${pInfo?.version}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
