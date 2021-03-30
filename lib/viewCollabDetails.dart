import 'package:flutter/material.dart';

class ViewCollabDetails extends StatelessWidget {
  String location, postedBy, description, lookingFor, photoURL;
  ViewCollabDetails({this.location, this.postedBy, this.lookingFor, this.description, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 90,
              backgroundImage: Image.network(photoURL).image,
            ),
            Text(postedBy),
            Text(location),
            Text(lookingFor),
            Text(description),
          ],
        ),
      ),
    );
  }
}
