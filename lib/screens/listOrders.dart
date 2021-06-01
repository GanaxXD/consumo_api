import 'package:consumoapi/model/orderModel.dart';
import 'package:consumoapi/searchs/search.dart';
import 'package:consumoapi/widgets/myDrawerNavigation.dart';
import 'package:flutter/material.dart';


class ListOrders extends StatefulWidget {
  @override
  _ListOrdersState createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {

  Searchs search = Searchs();
  List<Orders> result = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();

    //Pegando os resultados da pesquisa
    search.getAllOrders().then((value) =>{
      result = value,
      print(result.length),
      super.setState(() {
        loading = false;
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerNavigation(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,


        //criando o gradiente:
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color> [
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


        title: Text("Listar Ordens de Serviço",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w700, letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        reverse: true,
        separatorBuilder: (context, index){
          return Divider(color: Colors.indigo, height: 0.5, indent: 55, endIndent: 55, thickness: 0.5,);
        },
        itemBuilder: (context, index){
          return loading == true ? Center(child: CircularProgressIndicator(color: Colors.indigo,),)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    color: Colors.white70,
                    elevation: 2,
                    borderOnForeground: true,
                    clipBehavior: Clip.antiAlias,
                    /*
                     Informações do ordens de serviço
                    */
                    child: result == null ?
                      Center(
                        child: ListTile(
                          title: Text("Ops... Achamos um erro.",
                            style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Parece que encontramos um erro na captura dos dados do banco de dados. Por favor, volte mais tarde.",
                            style: TextStyle(color: Colors.indigo, fontSize: 12),
                          ),
                          //Adiciona uma "terceira linha"
                          isThreeLine: true,
                          leading: Icon(Icons.error, color: Colors.red),
                        ),
                      )
                          :
                      ListTile(
                          title: Text("Ordem: ${result[index].descricao}",
                            style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Preço: ${result[index].preco.toString()}\nCliente: ${result[index].cliente.nome}",
                            style: TextStyle(color: Colors.indigo, fontSize: 12),
                          ),
                          //Adiciona uma "terceira linha"
                          isThreeLine: true,
                          dense: true,
                          leading: Icon(Icons.shopping_basket, color: index%2 == 0 ? Colors.indigo : Colors.indigoAccent,),
                      ),
                  ),
          );
        },
        itemCount: result != null ? result.length.toInt() : 0,
      ),
    );
  }
}

