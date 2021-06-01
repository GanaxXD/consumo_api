import 'package:consumoapi/model/comentsModel.dart';
import 'package:consumoapi/searchs/search.dart';
import 'package:consumoapi/widgets/MyDrawerNavigation.dart';
import 'package:flutter/material.dart';


class Coments extends StatefulWidget {
  @override
  _ComentsState createState() => _ComentsState();
}

class _ComentsState extends State<Coments> {

    Searchs search = Searchs();
    List<ComentsModel> result;
    bool loading;
    TextEditingController searchController;

    @override
    void initState() {
        super.initState();
        searchController = TextEditingController();
        result = [];
        loading = true;
        //Pegando os resultados da pesquisa
        search.getAllComments("1").then((value) =>{
            result = value,
            super.setState(() {
                loading = false;
            })
        });
    }

    //Encerrando o contolador da pesquisa
    @override
    void dispose() {
        searchController.dispose();
        super.dispose();
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
                title: Text("Listar Comentários",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, letterSpacing: 5,
                        color: Colors.white,
                    ),
                ),
            ),


            body: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 22),
                                        child: TextField(
                                            controller: searchController,
                                            cursorColor: Colors.indigo,
                                            decoration: InputDecoration(
                                                errorBorder: InputBorder.none,
                                                hintText: "Digite o id da ordem de serviço",
                                            ),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                        onPressed: () => {
                                            setState((){
                                                loading = true;
                                                loading = true;
                                                //Pegando os resultados da pesquisa
                                                search.getAllComments(searchController.value.text).then((value) =>{
                                                    result = value,
                                                    print (result),
                                                    super.setState(() {
                                                        loading = false;
                                                    })
                                                });
                                            })
                                        },
                                        icon: Icon(Icons.search, color: Colors.indigoAccent,)
                                    ),
                                ),
                            ],
                        ),

                        //Comentários
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true, //Se dentro de uma SingleChieldScrollview, e quando eu uso quando eu uso a propriedade NeverScrolablePhysics, preciso somar a altura dos filhos para caber na tela, por isso, uso essa propriedade.
                            reverse: true,
                            separatorBuilder: (__, index){
                                return Divider(color: Colors.indigo, height: 0.5, indent: 55, endIndent: 55, thickness: 0.5,);
                            },
                            itemBuilder: (__, index){
                                return loading == true ? Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Center(child: CircularProgressIndicator(color: Colors.indigo,),),
                                ) :
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Card(
                                        color: Colors.white70,
                                        elevation: 2,
                                        borderOnForeground: true,
                                        clipBehavior: Clip.antiAlias,

                                        //informações dos comentários
                                        child: result == null ?
                                        Center(
                                            child: ListTile(
                                                title: Text("Digite o id da ordem.",
                                                    style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                subtitle: Text("Por favor, informe o id da ordem de serviço que você deseja mostrar os comentários.",
                                                    style: TextStyle(color: Colors.indigo, fontSize: 12),
                                                ),
                                                //Adiciona uma "terceira linha"
                                                isThreeLine: true,
                                                leading: Icon(Icons.warning, color: Colors.yellow),
                                            ),
                                        ) :
                                        ListTile(
                                            title: Text("#: ${index+1}",
                                                style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text("Descrição: ${result[index].descricao}",
                                                style: TextStyle(color: Colors.indigo, fontSize: 12),
                                            ),
                                            //Adiciona uma "terceira linha"
                                            isThreeLine: true,
                                            dense: true,
                                            leading: Icon(Icons.comment, color: index%2 == 0 ? Colors.indigo : Colors.indigoAccent,),
                                        ),
                                    ),
                                );
                            },
                            itemCount: result == null ? 1 : result.length.toInt(),
                        ),
                    ],
                )
            ),
        );
    }
}
