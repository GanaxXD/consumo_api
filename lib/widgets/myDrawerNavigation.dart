import 'package:consumoapi/screens/addClient.dart';
import 'package:consumoapi/screens/addOrder.dart';
import 'package:consumoapi/screens/comentsList.dart';
import 'package:consumoapi/screens/listClient.dart';
import 'package:consumoapi/screens/listOrders.dart';
import 'package:flutter/material.dart';

class MyDrawerNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 2,
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
                DrawerHeader(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                        child: Text("MENU", textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w900,
                                fontSize: 18,
                            ),
                        ),
                    ),
                    //Gradiente
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: <Color>[
                                Color.fromRGBO(242, 36, 126, 95),
                                Color.fromRGBO(252, 38, 230, 90),
                                Color.fromRGBO(193, 46, 230, 90),
                                Color.fromRGBO(154, 38, 252, 99),
                                Color.fromRGBO(69, 0, 245, 96),
                            ]
                        ),
                    ),
                ),

                //navegação entre as telas:

                //Listar Clientes:
                ListTile(
                    leading: Icon(Icons.list, color: Colors.indigo),
                    title: Text("Listar Clientes",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14, fontWeight: FontWeight.w800,
                        ),
                    ),
                    onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()
                        ));
                    },
                ),

                //Ordens de Serviço
                ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.indigo),
                    title: Text("Listar Ordens de Serviço",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14, fontWeight: FontWeight.w800,
                        ),
                    ),
                    onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ListOrders()
                        ));
                    },
                ),

                //Listar Comentários:
                ListTile(
                    leading: Icon(Icons.comment, color: Colors.indigo),
                    title: Text("Listar Comentários",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14, fontWeight: FontWeight.w800,
                        ),
                    ),
                    onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Coments()
                        ));
                    },
                ),

                Divider(color: Colors.indigo, indent: 55, endIndent: 55,),

                //Cadastrar Clientes:
                ListTile(
                    leading: Icon(Icons.group_add, color: Colors.indigo),
                    title: Text("Cadastrar Cliente",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14, fontWeight: FontWeight.w800,
                        ),
                    ),
                    onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CadastrarCliente()
                        ));
                    },
                ),

                //Cadastrar Ordem de Serviço:
                ListTile(
                    leading: Icon(Icons.add_shopping_cart, color: Colors.indigo),
                    title: Text("Cadastrar Ordem de Serviço",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 14, fontWeight: FontWeight.w800,
                        ), overflow: TextOverflow.fade,
                    ),
                    onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CadastrarOrdem()
                        ));
                    },
                ),

            ],
        ),
    );
  }
}
