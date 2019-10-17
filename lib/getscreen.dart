import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetScreen extends StatefulWidget {
  Future<dynamic> decodedData;
  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  @override
  void initState() {
    super.initState();
    print('initState called');
    getData();
  }

  Future<String> getData() async {
    http.Response response =
        await http.get('http://creationdevs.in/AirIndex/fetch.php');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      widget.decodedData = jsonDecode(data);
      return widget.decodedData;
    } else
      print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Check console'),
      ),
    );
  }
}

class Get {
  Get({this.getBody});
  final String getBody;
}
