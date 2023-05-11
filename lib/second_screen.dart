import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'secret.dart';

class APITest extends StatefulWidget {
  const APITest({Key? key}) : super(key: key);

  @override
  State<APITest> createState() => _APITestState();
}

class _APITestState extends State<APITest> {
  String getData = "wait..";
  List<dynamic> dynamicValuesList = [];

  Future fetchdata() async {
    http.Response response;
    response = await http.get(
        Uri.parse(
          "https://quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com/quote",
        ),
        headers: {
          'X-RapidAPI-Key': secret,
          'X-RapidAPI-Host':
              'quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com'
        });
    if (response.statusCode == 200) {
      setState(() {
        getData = response.body;
        dynamicValuesList = json.decode(getData).values.toList();
      });
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daily Motivational Thoughts"),
          backgroundColor: Colors.red,
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.fill,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (dynamicValuesList.isNotEmpty ? dynamicValuesList[1] : ""),
                  style: const TextStyle(
                      fontSize: 40, color: Color.fromARGB(255, 200, 16, 129)),
                ),
                // ignore: prefer_interpolation_to_compose_strings

                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text(
                        "- " +
                            (dynamicValuesList.isNotEmpty
                                ? dynamicValuesList[0]
                                : ""),
                      ),
                    ))
              ],
            )));
  }
}
