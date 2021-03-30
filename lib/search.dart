
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/feed.dart';
import 'package:vibing_app/model/user.dart';

import 'User_Profile.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  static AppUser user;
  final userRef = FirebaseFirestore.instance.collection('user search');
  TextEditingController searchController = new TextEditingController();
  Future<QuerySnapshot> searchResults;

  handleSearch(String query)
  {
    Future<QuerySnapshot> users = userRef.where("full_name".toLowerCase(), isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResults = users;
    });

  }

  clearSearch()
  {
    searchController.clear();
  }

  AppBar buildSearchField()
  {
    return AppBar(
      backgroundColor: Colors.yellow,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for a user",
          filled: true,
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
             onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container searchContainer(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text("Find users...",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults()
  {
    return FutureBuilder(
      future: searchResults,
      builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator() ,);
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          AppUser user = AppUser.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);

        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResults == null ? searchContainer(): buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final AppUser user;
  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: ()async {
              await showUserProfile(context, profileID: user.userId);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                backgroundImage: (user.photoURL!= null) ? Image.network(user.photoURL).image: null,
              ),
              title: Text(user.firstName + " " + user.lastName),

            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}

showUserProfile(BuildContext context, {String profileID})
{
   Navigator.push(context, MaterialPageRoute(builder: (context)=> PracticeProfile(profileId: profileID,)));
}