

import 'package:aymen_shop/shared/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

showtoast(var error){
Fluttertoast.showToast(
        msg: '$error',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: textColor,
        textColor: whitecolor,
        fontSize: 16.0,

    );
}