import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livepreview/theme.dart';
import 'models/tabs.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'homeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueGrey.shade900,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(MyApp());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text('An Unexpected Error occured! :(')));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print('DONE');
          return MyApp();
        }

        return Center(
            child: Container(
                height: 100, width: 100, child: CircularProgressIndicator()));
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TabViews>(create: (context) => TabViews()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}
