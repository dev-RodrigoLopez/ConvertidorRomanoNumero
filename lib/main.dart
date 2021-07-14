import 'package:flutter/material.dart';
import 'package:numerosromanos/http_provider.dart';
import 'package:numerosromanos/inicio.dart';
import 'package:provider/provider.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new httpProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: inicio(),
      ),
    );
  }


}






