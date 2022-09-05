import 'dart:convert';

import 'package:aymen_shop/shared/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider with ChangeNotifier {
  String? _token;
  String? userid;

  bool? get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(var username, var email, var password) async {
    Uri url = Uri.parse('https://aymenshop.herokuapp.com/auth/Singnup/users/');
    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'username': username,
            'email': email,
            'password': password,
          }));
      final resdata = json.decode(res.body);
      userid = resdata['id'];
      notifyListeners();
     if (resdata['username']!=null)
     {
      throw 'invalid username' ;
     }
    else if (resdata['email']!=null)
     {
      throw 'invalid email' ;
     }
     else if (resdata['password']!=null)
     {
      throw 'password is similair to the username or the email' ;
     }
     else if(resdata['username']==null && resdata['password']!=null &&resdata['password']!=null)
     {
      throw 'account ceated , please login now';
     }
    
    } catch (e) { 
      print(e);
     if ( e.toString() == 'invalid username' || e.toString()=='invalid email' || e.toString()=='password is similair to the username or the email'){
      throw e ;
     }
     else{
      throw 'account ceated , please login now' ;
     }   
  
    }

  }

  Future<void> login(username, password) async {
    Uri url = Uri.parse('https://aymenshop.herokuapp.com/auth/token/login');
    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      final resdata = json.decode(res.body);
      _token = resdata["token"] ?? null;
      userid = resdata['id'];
      notifyListeners();
      final pref = await SharedPreferences.getInstance();
      final String userdata = json.encode({'token': _token, 'userid': userid});
      pref.setString('userdata', userdata);
print(resdata.toString());
      notifyListeners();
      
    } catch (e) {
      showtoast(e);
    }
  }

  //this function for auto login
  Future<bool> trylogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userdata')) {
      return false;
    }
    final extractdata =
        json.decode(pref.getString('userdata')!) as Map<String, dynamic>;
    _token = extractdata['token'];
    userid = extractdata['id'];
    notifyListeners();
    return true;
  }
}