import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();
  print(_data[0]["body"]);

  runApp(new MaterialApp(
    home: new Scaffold(
        appBar: AppBar(
          title: Text("json parsin"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: ListView.builder(itemCount: _data.length,
            padding: EdgeInsets.all(3.5),
            itemBuilder: (BuildContext context, int position){
            return Column(
              children: <Widget>[
                Divider(height: 13.4,),
                ListTile(
                  title: Text(_data[position]["title"],
                  style: TextStyle(
                    fontSize: 17.2,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold
                  ),),

                   subtitle: Text(_data[position]["body"]),

                  leading: CircleAvatar(
                    radius: 35.5,
                    backgroundColor: Colors.orangeAccent,
                    child: Text(_data[position]["title"][0]),
                  ),
                  onTap: ()=> showTapMessage(context, _data[position]["title"]),
                )
              ],
            );
            })
    ),
  ));
}

void showTapMessage(BuildContext context, String data){
  var alertDialog = new AlertDialog(
    title: Text("$data"),
    actions: <Widget>[
      FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("OK"),
      )
    ],
  );
  showDialog(context: context, builder: (context){
    return alertDialog;
  });
}

Future<List> getJSON() async {
  String apiURL = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiURL);

  return json.decode(response.body);
}