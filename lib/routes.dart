import 'package:brts/initial%20screen/forget_pasword.dart';
import 'package:brts/initial%20screen/login.dart';
import 'package:brts/initial%20screen/register.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/': (c) => Login(),
  'forget_pass': (c) => ForgetPassword(),
  'register': (c) => Register(),
};
