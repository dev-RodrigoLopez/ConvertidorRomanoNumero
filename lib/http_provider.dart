import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class httpProvider with ChangeNotifier{

  Color _colorContainer = Colors.white;
  Color _colorboton = Colors.blue;
  String _mensaje = '';
  String _mensajeBoton = 'Convertir Numero';
  int _resultado = 0;
  bool _bloqueado =  true;

  bool get bloqueado => this._bloqueado;
  set bloqueado(bool valor){
    this._bloqueado = valor;
    notifyListeners();
  }

  Color get colorContainer => this._colorContainer;
  set colorContainer(Color valor){
    this._colorContainer = valor;
    notifyListeners();
  }

  Color get colorboton => this._colorboton;
  set colorboton(Color valor){
    this._colorboton = valor;
    notifyListeners();
  }

  String get mensaje => this._mensaje;
  set mensaje(String valor){
    this._mensaje = valor;
    notifyListeners();
  }

  String get mensajeBoton => this._mensajeBoton;
  set mensajeBoton(String valor){
    this._mensajeBoton = valor;
    notifyListeners();
  }

  int get resultado => this._resultado;
  set resultado(int valor){
    this._resultado = valor;
    notifyListeners();
  }

  Future<String> insertApi( String input) async
  {
    try{

      mensajeBoton = 'Espere';
      mensaje = '';
      colorContainer = Colors.white;
      colorboton = Colors.grey;
      bloqueado =  false;
      int resultado_temp = await calculadora(input);

      final data = 
          {
            "input": "X",
            "output": "10",
            "name": "Rodrigo López Sarmiento"
          };

          final resp = await http.post(
            Uri.parse(
              'https://tranquil-spire-80509.herokuapp.com/uploadAnswer'),
              body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

          Map<String, dynamic> decodeResp = json.decode(resp.body);

          if( decodeResp['success'] == true )
            colorContainer = Colors.green[600];
          else{
            colorContainer = Colors.red[600];
          } 
          
          resultado =  resultado_temp;
          mensaje = decodeResp['msg'];
          mensajeBoton = 'Convertir Numero';
          colorboton = Colors.blue;
          bloqueado =  true;
          return   decodeResp['msg'];
    }
    catch(e){
      return e.toString();
    }
  }
    
}


Future<int> calculadora(String romano) async{

  romano = romano.toUpperCase();
  int resultado = 0;
  int tamano = romano.length;


   for( int i = 0; i < romano.length; i++ ){
     resultado += letranumero(romano[i]);
   }
  if( romano.contains("IV") || romano.contains("IX") )
    resultado -= 2;
  if( romano.contains("XL") || romano.contains("XC") )
    resultado -= 20;
  if( romano.contains("CD") || romano.contains("CM") )
    resultado -= 200;
  return resultado;
}

int letranumero(String letra){
  int valor =  0;

  switch(letra)
  {
    case 'M':
    {
      return 1000;
    }
    case 'D':
    {
      return 500;
    }
    case 'C':
    {
      return 100;
    }
    case 'L':
    {
      return 50;
    }
    case 'X':
    {
      return 10;
    }
    case 'V':
    {
      return 5;
    }
    case 'I':
    {
      return 1;
    }
    default:
      return 0;
  }

}