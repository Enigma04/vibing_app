import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/user_provider.dart';

class UserDetails extends StatefulWidget {
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
    //final _userProvider = Provider.of<UserProvider>(context);

    final _firstName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        /*onChanged: (value){
          _userProvider.changeFirstName(value);
        },

         */
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        onSaved: (value)=> userFirstName = value,
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
       /* onChanged: (value){
          _userProvider.changeLastName(value);
        }
        ,
        */
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
       /* onChanged: (value){
          _userProvider.changeAge(value);
        },

        */
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Field cannot be empty';
          }
          return null;
        },
        onSaved: (value)=> user_age = value,
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
      backgroundColor: Colors.yellow,
      body: Container(
        child: Form(
          key: formkeyDetails,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register",
                style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 50,),
              _firstName,
              SizedBox(height: 20,),
              _lastName,
              SizedBox(height: 20,),
              _userAge,
              SizedBox(height: 30,),
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
                      onPressed: () {
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
