import 'dart:convert';
import 'package:consumoapi/widgets/myAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:consumoapi/widgets/MyDrawerNavigation.dart';
import 'package:consumoapi/widgets/myButton.dart';
import 'package:consumoapi/widgets/myTextFormField.dart';
import 'package:flutter/material.dart';

class CadastrarCliente extends StatefulWidget {
  @override
  _CadastrarClienteState createState() => _CadastrarClienteState();
}

class _CadastrarClienteState extends State<CadastrarCliente> {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _foneController = TextEditingController();
    //Ao que parece, na versão 2.2.1 não permite reaproveitamento de keys para
    // os widgets iguais, logo, serão 2 chaves para os alerts. Decidi não usar
    //por hora as keys.
    final GlobalKey alertSuccessKey = GlobalKey();
    final GlobalKey alertFailKey = GlobalKey();
    var errorMessage, statusCodeResponse;


    Future<void> success() async{
        return showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Cliente cadastrado com sucesso.",
                    content: "O cliente foi cadastrado com sucesso na base de dados."
                );
            }
        );
    }

    Future<void> fail() async{
        showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Erro ao cadastrar o cliente.",
                    content: "Não foi possível cadastrar o cliente. O seguinte erro foi encontrado: \n"
                        "Status: ${statusCodeResponse}\n"
                        "Mensagem: ${errorMessage}"
                );
            }
        );
    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawerNavigation(),
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[
                            Color.fromRGBO(242, 36, 126, 95),
                            Color.fromRGBO(252, 38, 230, 90),
                            Color.fromRGBO(193, 46, 230, 90),
                            Color.fromRGBO(154, 38, 252, 99),
                            Color.fromRGBO(69, 0, 245, 96),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                    )
                ),
            ),
            title: Text("Cadastrar Cliente", style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900
            ), overflow: TextOverflow.ellipsis,),
        ),

        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    MyTextFormField(
                        hint: "Nome",
                        help: "Informe o nome do cliente",
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                    ),

                    MyTextFormField(
                        hint: "Email",
                        help: "Informe o email do cliente",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                    ),

                    MyTextFormField(
                        hint: "Telefone",
                        help: "Informe o telefone do cliente",
                        controller: _foneController,
                        keyboardType: TextInputType.phone,
                    ),

                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: MyButton(
                            splashColor: Colors.purpleAccent,
                            icon: Icons.group_add,
                            text: "Cadastrar",
                            onPressed: () async {
                                if(_formKey.currentState.validate()){
                                    var response = await http.post(Uri.parse('https://api-client-serviceorder.herokuapp.com/clientes'),
                                        headers: <String, String>{
                                            'Content-Type': 'application/json; charset=UTF-8',
                                        },
                                        body: jsonEncode(<String, String>{
                                            'email': _emailController.value.text,
                                            'nome' : _nameController.value.text,
                                            'fone' : _foneController.value.text,
                                        })
                                    );
                                    if(response.statusCode == 200){
                                        success();
                                    } else {
                                        /*
                                        Por algum motivo, a API está retornando um texto HTML na resposta da requisição,
                                        mesmo estando configurado pra responder como um JSON. Inicialmente, para lançar
                                        o app, vou utilizar de um recurso "feio" para receber as informações do erro e exibir
                                        o alerta da melhor forma possível ao usuário.
                                         */
                                        var decodingErrorMessage = response.body.substring(response.body.indexOf("<titulo>"),response.body.indexOf("</titulo>"));
                                        errorMessage = decodingErrorMessage.substring(8);
                                        var decodingStatusResponse = response.body.substring(response.body.indexOf("<status>"),response.body.indexOf("</status>"));
                                        statusCodeResponse = decodingStatusResponse.substring(8);
                                        fail();
                                    }
                                }
                            },
                        ),
                    )
                ],
            ),
        ),
    );
  }
}
