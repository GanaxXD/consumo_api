import 'dart:convert';
import 'package:consumoapi/widgets/myAlert.dart';
import 'package:consumoapi/widgets/myButton.dart';
import 'package:consumoapi/widgets/myDrawerNavigation.dart';
import 'package:consumoapi/widgets/myTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastrarComentario extends StatefulWidget {
  @override
  _CadastrarComentarioState createState() => _CadastrarComentarioState();
}

class _CadastrarComentarioState extends State<CadastrarComentario> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _ordemIdController = TextEditingController();
    final TextEditingController _comentarioController = TextEditingController();
    var errorMessage, statusCodeResponse;


    Future<void> success() async{
        return showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Comentário cadastrado com sucesso.",
                    content: "O comentário da ordem de serviço foi cadastrado com sucesso na base de dados."
                );
            }
        );
    }

    Future<void> fail() async{
        showDialog(
            context: context,
            builder: (BuildContext context){
                return MyAlert(
                    title: "Erro ao cadastrar o Comentário.",
                    content: "Não foi possível cadastrar o comentário na ordem de serviço. O seguinte erro foi encontrado: \n"
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
                title: Text("Cadastrar Comentário", style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900
                ), overflow: TextOverflow.ellipsis,),
            ),

            body: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        MyTextFormField(
                            hint: "Id da Ordem de Serviço",
                            help: "Informe o Id da Ordem de serviço em que deseja cadastrar o comentário",
                            controller: _ordemIdController,
                            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                        ),

                        MyTextFormField(
                            hint: "Comentário",
                            help: "Informe a descrição do comentário",
                            controller: _comentarioController,
                            keyboardType: TextInputType.multiline,
                        ),

                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: MyButton(
                                splashColor: Colors.purpleAccent,
                                icon: Icons.add_comment,
                                text: "Cadastrar",
                                onPressed: () async {
                                    if(_formKey.currentState.validate()){
                                        var response = await http.post(Uri.parse('https://api-client-serviceorder.herokuapp.com/ordemservico/${_ordemIdController.value.text.toString()}/comentario'),
                                            headers: <String, String>{
                                                'Content-Type': 'application/json; charset=UTF-8',
                                            },
                                            body: jsonEncode(<String, String>{
                                                'descricao': _comentarioController.value.text,
                                            })
                                        );
                                        if(response.statusCode == 201){
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
