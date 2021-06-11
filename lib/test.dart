import 'package:booking/domain/ads.dart';
import 'package:flutter/material.dart';

class AdsScreen extends StatelessWidget {
  final List<Ads> adses;

  AdsScreen({Key key, this.adses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads'),
      ),
      body: ListView.builder(
        itemCount: adses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(adses[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(ads: adses[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Ads ads;

  // In the constructor, require a Todo.
  DetailScreen({Key key, this.ads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(ads.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(ads.description),
      ),
    );
  }
}
