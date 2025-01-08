import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareBottomshet extends StatelessWidget {
  void _shareContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Share via Messaging Apps'),
                onTap: () {
                  Navigator.pop(context);
                  Share.share('Check out this amazing content!');
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Share via Email'),
                onTap: () {
                  Navigator.pop(context);
                  Share.share(
                    'Check out this amazing content!',
                    subject: 'Amazing Content',
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Share Link'),
                onTap: () {
                  Navigator.pop(context);
                  Share.share('https://example.com');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _shareContent(context),
          child: Text('Share Something'),
        ),
      ),
    );
  }
}
