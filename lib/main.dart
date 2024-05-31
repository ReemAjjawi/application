import 'package:flutter/material.dart';

import 'get_config.dart';
import 'ligin_s.dart';
import 'user_model.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  TextEditingController UserName = TextEditingController();
  TextEditingController PassWord = TextEditingController();

  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: UserName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: PassWord,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          bool status = await LogInServiceImp().Login(
              UserModel(username: UserName.text, password: PassWord.text));
          print(status);
          if (status) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Failed to log in'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  Homepage({super.key});
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextFormField(
              onChanged: (value) {
                print(value);
                password.text = value;
              },
              controller: password,
            ),
          )
        ],
      ),
    );
  }
}
