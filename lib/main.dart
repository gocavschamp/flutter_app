
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
    // TODO: implement build
    return new MaterialApp(
      title: "first flutter view",
      home: new RandomWords(),
      theme: new ThemeData(primaryColor: Colors.red),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; //对象数组
  final _savedWord = new Set<WordPair>();
  final _fontSize = new TextStyle(fontSize: 18.0, color: Colors.amberAccent);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("welcome to beijing"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(
              icon: new Icon(Icons.account_circle), onPressed: _toastMessage1)
        ],
      ),
      body: _buildTextList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _savedWord.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _fontSize,
          ),
        );
      });
      final divied =
          ListTile.divideTiles(tiles: titles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("saved words"),
        ),
        body: new ListView(
          children: divied,
        ),
      );
    }));
  }

  void _toastMessage(String msg) {
    print("toa--"+msg);
  }
  void _toastMessage1() {
    print("toa--");
  }

  Widget _buildTextList() {
    _suggestions.addAll(generateWordPairs().take(10));
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          _toastMessage(i.toString());
          if (i.isOdd) return new Divider(); //如果是奇数
          final index = i ~/ 2;
//          _toastMessage(index.toString());
//          if (index >= _suggestions.length) {
//          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair suggestion) {
    final _alreadySaved = _savedWord.contains(suggestion);
    return new ListTile(
      title: new Text(
        suggestion.asPascalCase,
        style: _fontSize,
      ),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.ac_unit,
        color: _alreadySaved ? Colors.red : Colors.black26,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _savedWord.remove(suggestion);
          } else {
            _savedWord.add(suggestion);
          }
        });
      },
    );
  }
}
