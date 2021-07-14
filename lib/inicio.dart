import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'http_provider.dart';


class inicio extends StatefulWidget {
  
  @override
  _inicioState createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  String numeroRomano = '';
 
  // String mensaje = '';

  // int resultado = 0;

  TextEditingController numero = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Provider.of<httpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only( top: 50, left: 50, right: 50, bottom: 10 ),
            height: size.height * 0.10,
            // color: Colors.red,
            child: TextFormField(
              controller: numero,
            // initialValue: usuario.telefono == null ? '' : usuario.telefono ,
              validator: (valor){
                if(valor.isEmpty)
                  return "Ingrese un numero";
                return null;
              },
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Ingrese el numero Romano',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Icon(Icons.tag),
                // hintStyle: tipografia,
              ),
              onSaved: (value){
                numeroRomano = value;
              },
            )
          ), 
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric( horizontal: 50 ),
              height: size.height * 0.07,
              color: color.colorboton,
              child: Center(
                child: Text(
                  color.mensajeBoton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ) 
              ),
            ),
            onTap: () async{
              if(color.bloqueado){
                numeroRomano = numero.text;
                await color.insertApi(numeroRomano);
              }
            },
          ),
          Container(
            margin: EdgeInsets.only( top: 30, left: 50, right: 50, bottom: 10 ),
            width: size.width * 0.8,
            height: size.height * 0.10,
            color: Colors.black38, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text( 'Resultado: ', style: TextStyle( fontSize: 20, color: Colors.white ) ),
                Text( color.resultado.toString(), style: TextStyle( fontSize: 25, color: Colors.white ) )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only( top: 30, left: 50, right: 50, bottom: 10 ),
            width: size.width * 0.8,
            height: size.height * 0.10,
            color: color.colorContainer, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text( 'Estatus: ', style: TextStyle( fontSize: 20, color: Colors.white ) ),
                Text( color.mensaje, style: TextStyle( fontSize: 18, color: Colors.white ) )
              ],
            ),
          )
        ],
      ),
    
    );
  }
}