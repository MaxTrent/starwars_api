import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(const StarWars());
}

class StarWars extends StatefulWidget {
  const StarWars({Key? key}) : super(key: key);

  @override
  State<StarWars> createState() => _StarWarsState();
}

class _StarWarsState extends State<StarWars> {
  final String url = "https://swapi.dev/api/starships";
  List? data;

  Future<String> getSWData() async {
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = jsonDecode(res.body);
      data = resBody["results"];
    });

    return "Success";
  }

  @override
  void initState() {
    this.getSWData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Starships'),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Container(
                        child: Text(
                          data![index]["name"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        child: Row(
                          children: [
                            Text('Name: '),
                            Text(
                              data![index]["model"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        child: Row(
                          children: [
                            Text('Model: '),
                            Text(
                              data![index]["model"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
