import 'package:consumoapi/model/clientModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
    IMPORTANTE: SE FOR PUBLICAR, INSERIR A PERMISSÃO
    DE USO DA INTERNET NO ANDROIDMANIFEST
 */
class Searchs{
    var urlGetAllCients = Uri.parse('https://api-client-serviceorder.herokuapp.com/clientes');
    var urlGetAllOrders = Uri.parse('https://api-client-serviceorder.herokuapp.com/ordemservico');

    //Recebendo todos os dados dos clientes do Heroku (API)
    Future<List<Clients>> getAllClients() async{
        List<Clients> clientes = [];
        try{
            final result = await http.get(urlGetAllCients);
            if(result.statusCode == 200){
                var decodeJson = jsonDecode(result.body);
                //transformando os dados json da api em objeto client
                decodeJson.forEach((cliente)=> clientes.add(Clients.fromJson(cliente)));
                return clientes;
            } else {
                return null;
            }
        } catch (error){
            print("Erro ao receber os dados dos clientes da api. Erro:  "+ error);
            return null;
        }
    }

    Future getAllOrders() async{
        var result = await http.get(urlGetAllOrders);
        return result.body;
    }
}

