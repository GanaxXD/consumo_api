import 'package:consumoapi/model/clientModel.dart';
import 'package:consumoapi/searchs/search.dart';
import 'package:consumoapi/widgets/MyDrawerNavigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Searchs search = Searchs();
  List<Clients> result = [];
  bool loading = true;

  @override
  void initState() {
      super.initState();

      //Pegando os resultados da pesquisa
      search.getAllClients().then((value) =>{
          result = value,
          print(result),
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
            elevation: 5.0,
            backgroundColor: Colors.transparent,
            title: Text("Listar Clientes",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w700, letterSpacing: 5,
                    color: Colors.indigo,
                ),
            ),
        ),
        body: ListView.separated(
            reverse: true,
            separatorBuilder: (context, index){
              return Divider(color: Colors.indigo, height: 0.5, indent: 55, endIndent: 55, thickness: 0.5,);
            },
            itemBuilder: (__, index){
              return loading == true ? Center(child: CircularProgressIndicator(color: Colors.indigo,),)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                          color: Colors.white70,
                          elevation: 2,
                          borderOnForeground: true,
                          clipBehavior: Clip.antiAlias,
                          /*
                          Informações do cliente
                           */
                          child: ListTile(
                              title: Text("Nome: ${result[index].nome}",
                                  style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Email: ${result[index].email}\nTelefone: ${result[index].fone}",
                                  style: TextStyle(color: Colors.indigo, fontSize: 12),
                              ),
                              //Adiciona uma "terceira linha"
                              isThreeLine: true,
                              dense: true,
                              leading: Icon(Icons.person, color: index%2 == 0 ? Colors.indigo : Colors.indigoAccent,),
                          ),
                      ),
              );
            },
            itemCount: result.length,
        ),
      );
    }
}
