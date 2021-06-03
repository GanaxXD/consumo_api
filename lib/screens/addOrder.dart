import 'dart:convert';

import 'package:consumoapi/widgets/myAlert.dart';
import 'package:consumoapi/widgets/myButton.dart';
import 'package:consumoapi/widgets/myDrawerNavigation.dart';
import 'package:consumoapi/widgets/myTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastrarOrdem extends StatefulWidget {
  @override
  _CadastrarOrdemState createState() => _CadastrarOrdemState();
}

class _CadastrarOrdemState extends State<CadastrarOrdem> {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _clienteIdController = TextEditingController();
    final TextEditingController _descricaoController = TextEditingController();
    final TextEditingController _precoController = TextEditingController();
    var errorMessage, statusCodeResponse;


    Future<void> success() async{
        return showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Ordem de Serviço cadastrada com sucesso.",
                    content: "A ordem de serviço foi cadastrado com sucesso na base de dados."
                );
            }
        );
    }

    Future<void> fail() async{
        showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Erro ao cadastrar a ordem de serviço.",
                    content: "Não foi possível cadastrar a ordem de serviço. O seguinte erro foi encontrado: \n"
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
                title: Text("Cadastrar Ordem de serviço", style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900
                ), overflow: TextOverflow.ellipsis,),
            ),

            body: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        MyTextFormField(
                            hint: "Id do Proprietário",
                            help: "Informe o Id do cliente proprietário da Ordem de serviço",
                            controller: _clienteIdController,
                            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                        ),

                        MyTextFormField(
                            hint: "Descrição",
                            help: "Informe a descrição da ordem de serviço",
                            controller: _descricaoController,
                            keyboardType: TextInputType.multiline,
                        ),

                        MyTextFormField(
                            hint: "Preço",
                            help: "Informe o valor da ordem de serviço",
                            controller: _precoController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: MyButton(
                                splashColor: Colors.purpleAccent,
                                icon: Icons.group_add,
                                text: "Cadastrar",
                                onPressed: () async {
                                    if(_formKey.currentState.validate()){
                                        var response = await http.post(Uri.parse('https://api-client-serviceorder.herokuapp.com/ordemservico'),
                                            headers: <String, String>{
                                                'Content-Type': 'application/json; charset=UTF-8',
                                            },
                                            body: jsonEncode(<String, String>{
                                                'descricao': _descricaoController.value.text,
                                                'clienteId' : _clienteIdController.value.text,
                                                'preco' : _precoController.value.text,
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
