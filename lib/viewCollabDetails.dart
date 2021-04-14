import 'package:flutter/material.dart';

class ViewCollabDetails extends StatelessWidget {
  String location, postedBy, lookingFor, description, photoURL;
  ViewCollabDetails({this.location, this.postedBy,this.description, this.lookingFor, this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: Column(
          children: [
            CircleAvatar(
              radius: 90,
              backgroundImage: Image.network(photoURL).image != null? Image.network(photoURL).image: Image.network("https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg").image,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Posted By: ", style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),),
               Text(postedBy, style: TextStyle(fontSize: 20),),

             ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Location: ", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text(location, style: TextStyle(fontSize: 20),),

              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Looking for: ", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text(lookingFor, style: TextStyle(fontSize: 20),),

              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Description: ", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            Flexible(
                child: Text(description, style: TextStyle(fontSize: 15), overflow: TextOverflow.clip,maxLines:  5,),
            ),

          ],
        ),
        ],
        ),
      )
    );
  }
}
