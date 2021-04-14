import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSoundRecordingList extends StatefulWidget {
  @override
  _UserSoundRecordingListState createState() => _UserSoundRecordingListState();
}

class _UserSoundRecordingListState extends State<UserSoundRecordingList> {
  String currentUser = FirebaseAuth.instance.currentUser.uid;
  bool isPlaying;
  int selectedIndex;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = -1;
    isPlaying = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Your Recordings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('user').doc(currentUser).collection('Audio Files').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myAudio = snapshot.data.docs[index];
                    return Card(
                      child: ListTile(
                        leading: myAudio.data()['file_name'],
                        trailing: myAudio.data()['audioFile'] != null
                            ? IconButton(
                          icon: (selectedIndex == index && !isPlaying) ? Icon(
                              Icons.pause) : Icon(Icons.music_note_sharp),
                          onPressed: () async {
                            if (!isPlaying) {
                              isPlaying = true;
                              setState(() {
                                selectedIndex = index;
                              });
                              audioPlayer.play(
                                  await myAudio.data()['audioFile'],
                                  isLocal: false);
                              audioPlayer.onPlayerCompletion.listen((event) {
                                setState(() {
                                  isPlaying = false;
                                  selectedIndex = -1;
                                });
                              });
                            }
                            else {
                              await audioPlayer.pause();
                              isPlaying = false;
                            }
                            setState(() {});
                          },
                        )
                            : null,
                      ),
                    );
                  }
              );
            }
            else {
              return Center(
                child: !snapshot.hasData ? Text("No data found"):CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
}
