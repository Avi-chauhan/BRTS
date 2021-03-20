import 'package:brts/Adminscreen.dart/Adminhome.dart';
import 'package:brts/initial%20screen/forget_pasword.dart';
import 'package:brts/initial%20screen/home.dart';
import 'package:brts/initial%20screen/login.dart';
import 'package:brts/initial%20screen/register.dart';
import 'package:brts/initial%20screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'initial screen/home.dart';

Map<String, WidgetBuilder> routes = {
  '/': (c) => Screensplash(),
  '/adminhome': (c) => Admin(),
  'Login': (c) => Login(),
  '/forget_pass': (c) => ForgetPassword(),
  '/register': (c) => Register(),
  '/Home': (c) => Home(),
};
