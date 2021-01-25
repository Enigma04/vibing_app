import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/model/database.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'model/user.dart';


enum Gender{
  Male, Female, Others
}

class UserDetails extends StatelessWidget {
  final UserProvider newUser;
  UserDetails({Key key, @required this.newUser,}): super(key: key);
  final formkeyDetails = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _firstNameController = new TextEditingController();
    TextEditingController _lastNameController = new TextEditingController();
    TextEditingController _ageController = new TextEditingController();
    _firstNameController.text = newUser.firstName;
    _lastNameController.text = newUser.lastName;
    _ageController.text = newUser.age;

    void _validateAndSave()
    {
      final form = formkeyDetails.currentState;
      if(form.validate())
      {
        form.save();
        newUser.firstName = _firstNameController.text;
        newUser.lastName = _lastNameController.text;
        newUser.age = _ageController.text;
      }
      return null;
    }

    int group_value = -1;
    Gender _gender = Gender.Male;

    final _firstName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _firstNameController,
        autofocus: false,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter First Name',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    final _lastName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _lastNameController,
        autofocus: false,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter Last Name',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );


    final _userAge = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _ageController,
        keyboardType: TextInputType.number,
        autofocus: false,

        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter Age',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: Container(
        child: Form(
          key: formkeyDetails,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register",
                style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              _firstName,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              _lastName,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              _userAge,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center ,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: "prev_button",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed: ()=> Navigator.pop(context),
                      label: Text("Prev", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  FloatingActionButton.extended(
                      heroTag: "next_button",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed: () async{
                        //String userid = await Auth().getCurrentUser();
                        _validateAndSave();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserReg(newUser: newUser))).then((value) => formkeyDetails.currentState.reset());
                      },
                      label: Text("Next", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class UserDetails extends StatefulWidget {
  //String userFirstName;
  //String userLastName;
  //String user_age;

  final UserProvider user;
  UserDetails({Key key, @required this.user}): super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

enum Gender{
  Male, Female, Others
}
class _UserDetailsState extends State<UserDetails> {
  String userFirstName;
  String userLastName;
  String user_age;
  int group_value = -1;
  Gender _gender = Gender.Male;


   final formkeyDetails = GlobalKey<FormState>();

  bool _validateAndSave()
  {
    final form = formkeyDetails.currentState;
    if(form.validate())
    {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    final _firstName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        onChanged: (value){
         // _userProvider.changeFirstName(value);
        },

        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter First Name',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    final _lastName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },

        onSaved: (value)=> userLastName = value,
        decoration: InputDecoration(
          hintText: 'Enter Last Name',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );





    final _userAge = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: false,
        onChanged: (value){
         //_userProvider.changeAge(value);
          user_age = value;
        },

        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        onSaved: (value)=>  = value,
        decoration: InputDecoration(
          hintText: 'Enter Age',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );




    final _male = Radio(
      value: Gender.Male,
      activeColor: Colors.black,
      groupValue: _gender,
      onChanged: (Gender value){
        setState(() {
          print(value);
          _gender = value;
        });
      },
    );


    final _female = Radio(
      activeColor: Colors.black,
    value: Gender.Female,
    groupValue: _gender,
    onChanged: (Gender value){
      setState(() {
        print(value);
        _gender = value;
      });
    },
    );

    final _others = Radio(
      activeColor: Colors.black,
        value: Gender.Others,
        groupValue: _gender,
        onChanged: (Gender value){
          setState(() {
            print(value);
            _gender = value;
          });
        },
      );


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: Container(
        child: Form(
          key: formkeyDetails,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register",
                style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              _firstName,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              _lastName,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              _userAge,
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: <Widget>[
                  Text("      Gender: ", style: TextStyle(fontSize: 20.0),),
                  _male,
                  Text("Male"),
                  _female,
                  Text("Female"),
                  _others,
                  Text("Others"),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center ,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: "prev_button",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed: ()=> Navigator.pushNamed(context,'/user_login'),
                      label: Text("Prev", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  FloatingActionButton.extended(
                      heroTag: "next_button",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed: () async{
                        //String userid = await Auth().getCurrentUser();
                        _validateAndSave();
                        Navigator.pushNamed(context, '/user_register');
                        },
                      label: Text("Next", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      );

  }
}

 */
