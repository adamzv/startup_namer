// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: RandomWords(),
    );
  }
}

// Stateful widgets maintain state that might change during the lifetime of the widget.
// StatefulWidget class creates an instance of a State class.
// StatefulWidget is immutable and can be thrown away and regenerated,
// State class persists state over lifetime of the widget
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// By default, the name of the State class is prefixed with an underbar.
// Prefixing an identifier with an underscore enforces privacy
// in the Dart language and is a recommended best practice for State objects.
class _RandomWordsState extends State<RandomWords> {
  // Maintains state for the RandomWords widget

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided =
              ListTile.divideTiles(tiles: tiles, context: context).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved suggestions'),
            ),
            // TODO: How can I get the same padding as used on main page?
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRowWithAnimation(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // setState triggers a call to the build() method for the State object,
        // resulting in an update to the UI.
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  // Added custom animation for favorite icon,
  // in which one state will slowly transition into the other state
  Widget _buildRowWithAnimation(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: AnimatedCrossFade(
        crossFadeState:
            alreadySaved ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 800),
        firstChild: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        secondChild: Icon(
          Icons.favorite_border,
          color: null,
        ),
        firstCurve: Curves.bounceOut,
        secondCurve: Curves.bounceIn,
      ),
      onTap: () {
        // setState triggers a call to the build() method for the State object,
        // resulting in an update to the UI.
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
