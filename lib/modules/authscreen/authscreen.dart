import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../controller/authcontroller/authprovider.dart';
import '../../shared/components/default_button/defaultbutton.dart';
import '../../shared/components/toast/toast.dart';
import '../../shared/styles/styles.dart';


enum AuthMode { SignUp, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
  };

  bool _isLoading = false;

  final _passwordController = TextEditingController();

//this funvcion for show error

  Future _submit() async{
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try{
      if (_authMode == AuthMode.Login) {
      // Log user in
     await Provider.of<AuthProvider>(context, listen: false)
          .login(_authData['username'], _authData['password']);
     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TaskScreen()));

    } else { 
      // Sign user up
     await Provider.of<AuthProvider>(context, listen: false).signup(
          _authData['username'], _authData['email'], _authData['password']);
     
    }
    }catch(error){
      showtoast(error);
    }
    setState(() {
      _isLoading = false;
    });
    setState(() {
        _authMode = AuthMode.Login;
      });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: height * 0.45,
                  child: Image.asset(
                      'assets/images/In no time-amico.png')),
              Container(
                height: height * 0.55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: whitecolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  height: _authMode == AuthMode.SignUp ? 320 : 260,
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.SignUp ? 320 : 260),
                  width: width * 0.75,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'UserName'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid name!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['username'] = value!;
                            },
                          ),
                          if (_authMode == AuthMode.SignUp)
                            TextFormField(
                              decoration: InputDecoration(labelText: 'E-Mail'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value!;
                            },
                          ),
                          SizedBox(
                            height: height*0.09,
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                          Defaultbutton(functon:_submit , text: _authMode == AuthMode.Login
                                  ? 'LOGIN'
                                  : 'SIGN UP',
                                   height: height*0.06,
                                    width: width*0.8,
                                    color: buttoncolor
                                    ),
                          FlatButton(
                            child: Text(
                                '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                            onPressed: _switchAuthMode,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 4),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            textColor: buttoncolor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
