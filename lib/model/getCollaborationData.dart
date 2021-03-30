import 'package:cloud_firestore/cloud_firestore.dart';

class GetCollaborationData {
  String postedBy;
  String location;
  String lookingFor;
  String description;
  String time;

  GetCollaborationData({this.description, this.location, this.postedBy, this.lookingFor, this.time});

  factory GetCollaborationData.fromDocument(DocumentSnapshot doc){
    return GetCollaborationData(
      postedBy: doc.data()['posted_by'],
      description: doc.data()['description'],
      lookingFor: doc.data()['looking_for'],
      location: doc.data()['location'],
      time: doc.data()['time'],
    );
  }

}
