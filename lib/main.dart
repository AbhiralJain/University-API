import 'package:flutter/material.dart';
import 'package:universities/pages/all.dart';
import 'package:universities/pages/favourites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const MaterialColor myColor = MaterialColor(
    _myColorPrimaryValue,
    <int, Color>{
      50: Color(0xFFeaebed),
      100: Color(0xFFbfc4c8),
      200: Color(0xFF949da3),
      300: Color(0xFF69767e),
      400: Color(0xFF54626b),
      500: Color(0xFF293b46),
      600: Color(0xFF212f38),
      700: Color(0xFF19232a),
      800: Color(0xFF10181c),
      900: Color(0xFF080c0e),
    },
  );
  static const int _myColorPrimaryValue = 0xFF293b46;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vita Linea',
      theme: ThemeData(
        primarySwatch: myColor,
        scaffoldBackgroundColor: myColor.shade50,
        cardColor: const Color(0xFFFFFFFF),
        canvasColor: myColor.shade100,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: myColor.shade700,
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: myColor.shade700,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: myColor.shade700,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          bodySmall: TextStyle(
            color: myColor.shade700,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          labelMedium: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          labelSmall: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: myColor,
        iconTheme: const IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: myColor.shade900,
        cardColor: myColor.shade700,
        canvasColor: myColor.shade700,
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          bodySmall: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          labelMedium: TextStyle(
            color: myColor.shade700,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          labelSmall: TextStyle(
            color: Colors.blue.shade200,
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _all = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Universities',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _all = true;
                      });
                    },
                    style: TextButton.styleFrom(
                        minimumSize: const Size(150, 0),
                        shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(48))),
                        backgroundColor: _all ? Theme.of(context).canvasColor : null),
                    child: Text(
                      'All',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _all = false;
                      });
                    },
                    style: TextButton.styleFrom(
                        minimumSize: const Size(150, 0),
                        shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(48))),
                        backgroundColor: !_all ? Theme.of(context).canvasColor : null),
                    child: Text(
                      'Favourites',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Expanded(flex: 20, child: _all ? AllUniversities() : FavouriteUniversitiies()),
            ],
          ),
        ),
      ),
    );
  }
}
