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
                            splashColor: Colors.green.shade400,
                            icon: Icons.group_add,
                            text: "Cadastrar",
                        ),
                    )
                ],
            ),
        ),
    );
  }
}
