import 'dart:convert';
import 'package:apicalling3/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nucks Brothers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: homepage()
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}
// workd space

var data;

Future<void> fetchdata()async{
  var url = 'https://jsonplaceholder.typicode.com/users';
  var response =  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

   if(response.statusCode== 200){
     data = jsonDecode(response.body.toString());
   } else{

   }
}


class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchdata(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
             return Text('loading');
          }else{
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['address']['geo']['lat'].toString()),
                );
              },);
          }
        },
      ),
    );
  }
}

