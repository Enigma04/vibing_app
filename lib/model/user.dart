class User {

  final String firstName;
  final String lastName;
  final String userId;
  final String email;
  final String password;
  final int age;
  //final int gender;

  User({this.userId, this.firstName, this.lastName,this.email,this.password, this.age});

  Map<String,dynamic> toMap()
  {
    return {
      'userId' : userId,
      'first_name' : firstName,
      'last_name' : lastName,
      'emailid' : email,
      'password': password,
      'age' : age,
      //'gender' : gender,
    };

  }
  /*
  User.fromFirestore(Map<String, dynamic> firestore)
     : firstName = firestore['first_name'],
      lastName = firestore['last_name'];

   */

}