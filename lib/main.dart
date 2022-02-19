import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Lecture 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late Future<Todo> futureTodos;
  late Future<List<Todo>> futureTodos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: (snapshot.data as List<Todo>).length,
              itemBuilder: (BuildContext context, int index) {
                //return Text(Todo.todos[index].label);
                //return buildTodoCard(Todo.todos[index]);
                return buildNicerTodoCard((snapshot.data as List<Todo>)[index]);
              });
        },
        future: futureTodos,
      )),
    );
  }

  Widget buildTodoCard(Todo todo) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(todo.label),
        ],
      ),
    );
  }

  Widget buildNicerTodoCard(Todo todo) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              todo.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            ),
            Text(todo.description),
            Text(todo.complete.toString())
          ],
        ),
      ),
    );
  }

  Future<List<Todo>> getTodos() async {
    final response = await get(Uri.parse('https://csi5112lec6.farahtech.net/api/todo'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Todo.fromListJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load todo');
    }
  }

  @override
  void initState() {
    super.initState();
    futureTodos = getTodos();
  }
}
