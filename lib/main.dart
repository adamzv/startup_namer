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
      title: 'My first Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first Flutter app'),
        ),
        body: Center(
          // child:
          //     Text('Hello World', style: Theme.of(context).textTheme.headline4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RandomWords(),
              Text('⬆ randomly generated word pair ⬆'),
            ],
          ),
        ),
      ),
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
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase, style: Theme.of(context).textTheme.headline4);
  }
}

