import 'package:brts/Adminscreen.dart/Adminhome.dart';
import 'package:brts/Adminscreen.dart/mo_station.dart';
import 'package:brts/drawerscreen/contactus.dart';
import 'package:brts/drawerscreen/feedback.dart';
import 'package:brts/drawerscreen/mytransaction.dart';
import 'package:brts/drawerscreen/mytrips.dart';
import 'package:brts/initial%20screen/forget_pasword.dart';
import 'package:brts/initial%20screen/home.dart';
import 'package:brts/initial%20screen/login.dart';
import 'package:brts/initial%20screen/register.dart';
import 'package:brts/initial%20screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'initial screen/home.dart';
import 'homescreen/bookticket.dart';
import 'homescreen/myroutes.dart';
import 'homescreen/mytickets.dart';
import 'homescreen/schedule.dart';
import 'homescreen/stops.dart';
import 'homescreen/suratmap.dart';

Map<String, WidgetBuilder> routes = {
  '/': (c) => Screensplash(),
  '/adminhome': (c) => Admin(),
  'Login': (c) => Login(),
  '/forget_pass': (c) => ForgetPassword(),
  '/register': (c) => Register(),
  '/Home': (c) => Home(),
  '/bookticket': (c) => bookticket(),
  '/myroutes': (c) => myroutes(),
  '/mytickets': (c) => mytickets(),
  '/schedule': (c) => schedule(),
  '/suratmap': (c) => suratmap(),
  '/stops': (c) => stops(),
  '/mo_station': (c) => mo_station(),
  '/mytrips': (c) => mytrips(),
  '/mytransaction': (c) => mytransaction(),
  '/contactus': (c) => contactus(),
  '/feedback': (c) => feedback(),
};
