import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:teacher_appraisal_portal/utils/authentication.dart';
import 'package:teacher_appraisal_portal/utils/theme_data.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

var preferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await StreamingSharedPreferences.instance;
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Appraisal Portal',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
    );
  }
}
//Latest Commit 11 May 2022
