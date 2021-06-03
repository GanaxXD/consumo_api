import 'package:consumoapi/model/clientModel.dart';
import 'package:consumoapi/searchs/search.dart';
import 'package:consumoapi/widgets/myDrawerNavigation.dart';
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
          super.setState(() {
            loading = false;
          })
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: MyDrawerNavigation(),

        //Colocando o fundo do app bar num gradiente:
        backgroundColor: Colors.white,
        appBar: AppBar(
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

            centerTitle: true,
            elevation: 5.0,
            title: Text("Listar Clientes",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w700, letterSpacing: 5,
                    color: Colors.white,
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
            itemCount: result == null ? 1 : result.length.toInt(),
        ),
      );
    }
}
