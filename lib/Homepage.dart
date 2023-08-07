import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobalKey<FormState> Textformkey = GlobalKey();
  TextEditingController chaptercontroller = TextEditingController();
  TextEditingController versecontroller = TextEditingController();

  late String chapter;
  late String verse;
  Map data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bhagavad geeta"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: [
                    Form(
                      key: Textformkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: chaptercontroller,
                              decoration: InputDecoration(
                                hintText: "Enter chapter number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (val) {
                                setState(() {
                                  chapter = val!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: versecontroller,
                              decoration: InputDecoration(
                                hintText: "Enter verse number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (val) {
                                setState(() {
                                  verse = val!;
                                });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Textformkey.currentState!.save();
                                fetchdata();
                              });
                            },
                            child: Text("Enter"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: (data.isEmpty)
                    ? Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator())
                    : Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "Chapter :- ${data["chapter"]}  \n Verse :- ${data["verse"]}")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Slok :-"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(" ${data['slok']}\n"),
                                    ],
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text("\nMeaning :-"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("${data["rams"]["ht"]}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
          ],
        ));
  }

  fetchdata() async {
    final response = await http
        .get(Uri.parse("https://bhagavadgitaapi.in/slok/$chapter/$verse/"));
    final body = jsonDecode(response.body);

    setState(() {
      data = body;
    });
  }
}
