import 'package:flutter/material.dart';
import 'package:movie_search_app/about/about_page.dart';
import 'package:movie_search_app/search_result/search_result_page.dart';
import 'package:movie_search_app/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies App'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => AboutPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.info,
                  size: 26.0,
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.settings,
          size: 26.0,
        ),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool shouldIncludeReview = prefs.getBool('shouldIncludeReview');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => SettingsPage(),
              settings: RouteSettings(
                name: "result-page",
                arguments: {
                  'shouldIncludeReview': shouldIncludeReview,
                },
              ),
            ),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                // cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  labelText: "Найти фильм, в котором",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: TextInputType.text,
                minLines: null,
                maxLines: null,
                onSubmitted: (text) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SearchResultPage(),
                      settings: RouteSettings(
                        name: "result-page",
                        arguments: {"query": text},
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
