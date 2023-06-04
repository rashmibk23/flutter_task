import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

String stringResponse = '';
Map mapResonse = {};

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future apicall() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://api.github.com/users/rameshbgm"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResonse = jsonDecode(stringResponse);
      });
    }
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // apicall();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Call'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    apicall();
                  },
                  child: Text('Call API'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text('Login -'),
              title: Text(mapResonse['login'].toString()),
            ),
            ListTile(
              leading: Text('Id -'),
              title: Text(mapResonse['id'].toString()),
            ),
            ListTile(
              leading: Text('Name -'),
              title: Text(mapResonse['name'].toString()),
            ),
            ListTile(
              leading: Text('Location -'),
              title: Text(mapResonse['location'].toString()),
            )
            // Text(mapResonse['login'].toString()),
            // Text(mapResonse['id'].toString()),
            // Text(mapResonse['name'].toString()),
            // Text(mapResonse['location'].toString()),
          ],
        ),
      ),
    );
  }
}
