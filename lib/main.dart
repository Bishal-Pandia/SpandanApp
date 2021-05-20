import 'package:flutter/material.dart';
import 'package:trial/screens/home.dart';
import 'package:trial/screens/signin.dart';
import 'package:trial/screens/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MaterialApp(home: MyApp(),));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SoccerApp(),
//     );
//   }
// }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPref();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/background.jpg",
            fit: BoxFit.fill,
          ),
        ),
        (_loginStatus==0)?SoccerApp():SignIn()
      ],),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new SignIn(),
        '/signup': (BuildContext context) => new SignUp(),
        '/home': (BuildContext context) => new SoccerApp(),
      },
    );
  }
  var _loginStatus=0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
       //For logging in automatically, stores the log in status
      // _loginStatus = preferences.getInt("value")!;
      //testing ....
      _loginStatus = 0;

    });
  }
}



//So as we can see w got our matches data,
// the data size depend on the date and the time so
// you can get as many data as many matches are curetly playing
//Now let's try to get data by seasons and leagues