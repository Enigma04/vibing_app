import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/viewCollabDetails.dart';

class Collaborate extends StatefulWidget {

  @override
  _CollaborateState createState() => _CollaborateState();
}

class _CollaborateState extends State<Collaborate>{
  @override
  void initState(){
    setState(() {
      FirebaseAuth.instance.currentUser.reload();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow ,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 60) ,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=> Navigator.pop(context),),
                SizedBox(width: MediaQuery.of(context).size.width* 0.15,),
                Text("Bulletin Board", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),)
              ],
            )
          ),
          Container(
              padding: EdgeInsets.only(top: 10) ,
              child: RefreshIndicator(
                onRefresh: (){
                  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=> Collaborate(), transitionDuration: Duration(seconds: 0)));
                  return Future.value(false);
                },
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection("collaborationPosts").get(),
                  builder: (context, snapshot){
                    if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                    {
                      return Column(
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index){
                                DocumentSnapshot collaborators = snapshot.data.docs[index];
                                //user = AppUser.fromDocument();
                                return GestureDetector(
                                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewCollabDetails(
                                    photoURL: collaborators.data()['photoURL'].toString(),
                                    postedBy: collaborators.data()['posted_by'],
                                    location: collaborators.data()['location'],
                                    lookingFor: collaborators.data()['looking_for'],
                                    description: collaborators.data()['description'],
                                  ))),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: collaborators.data()['photoURL']!= null ? Image.network(collaborators.data()['photoURL'].toString()).image :
                                          Image.network("https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg").image,
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height* 0.01,),
                                        Text('Posted by: ${collaborators.data()['posted_by']}'),
                                        Text('Location: ${collaborators.data()['location']}'),
                                        Text('Looking For: ${collaborators.data()['looking_for']}'),
                                        SizedBox(height: MediaQuery.of(context).size.height* 0.01,),
                                        Text("Tap to view details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
          ),
        ],
      )
      );
  }
}
