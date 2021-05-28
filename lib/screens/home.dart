import 'package:consumoapi/model/clientModel.dart';
import 'package:consumoapi/searchs/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Searchs search = Searchs();
  List<Clients> result = [];

  @override
  void initState() {
      super.initState();
      //Pegando os resultados da pesquisa
      search.getAllClients().then((value) =>{
        result = value,
        print(result)
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 12.0,
            title: Text("Recebendo dados da API"),
        ),
        body: ListView.separated(
            separatorBuilder: (context, index){
              return Divider(color: Colors.indigo, height: 0, indent: 55, endIndent: 55, thickness: 1,);
            },
            itemBuilder: (context, index){
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                      title: Text("${result[index].nome}",
                        style: TextStyle(color: Colors.indigo),
                      ),
                  ),
              );
            },
            itemCount: result.length,
        ),
      );
    }
}
