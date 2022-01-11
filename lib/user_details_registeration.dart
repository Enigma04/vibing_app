import 'package:flutter/material.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'package:vibing_app/register_user.dart';


class UserDetails extends StatefulWidget {
  final UserProvider newUser;
  UserDetails({Key key, @required this.newUser,}): super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final formkeyDetails = GlobalKey<FormState>();
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    _firstNameController.text = widget.newUser.firstName;
    _lastNameController.text = widget.newUser.lastName;

    void _validateAndSave()
    {
      final form = formkeyDetails.currentState;
      if(form.validate())
      {
        form.save();
        widget.newUser.firstName = _firstNameController.text;
        widget.newUser.lastName = _lastNameController.text;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserReg(newUser: widget.newUser)));
      }
      return null;
    }


    final _firstName = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _firstNameController,
        autofocus: false,
        keyboardType: TextInputType.name,
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
        keyboardType: TextInputType.name,
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
