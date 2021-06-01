import 'package:consumoapi/model/clientModel.dart';
import 'package:consumoapi/model/comentsModel.dart';
import 'package:consumoapi/model/orderModel.dart';
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

    //Recebendo dados das ordens de serviço
    Future getAllOrders() async{
        List<Orders> ordens = [];
        try{
            final result = await http.get(urlGetAllOrders);
            print(result);
            if(result.statusCode == 200){
                print("RESULT BODY: ");
                print(result.body);
                var decodeJson = jsonDecode(result.body);
                //transformando os dados json da api em objeto ordem
                decodeJson.forEach((ordem)=> ordens.add(Orders.fromJson(ordem)));
                print("RESULT ORDENS: ");
                print(ordens);
                return ordens;
            } else {
                return null;
            }
        } catch (error){
            print("Erro ao receber os dados das Ordens de Serviço da api. Erro:  "+ error.toString());
            return null;
        }
    }

    //Carregando comentários
    Future getAllComments(String id) async{
        print(id);
        String idOrder = id.toString();
        print(idOrder);
        List<ComentsModel> ordens = [];
        String urlBeforeParse = "https://api-client-serviceorder.herokuapp.com/ordemservico/$idOrder/comentario";
        print(urlBeforeParse);
        var urlAfterParse = Uri.parse(urlBeforeParse);
        try{
            final result = await http.get(urlAfterParse);
            print(result);
            if(result.statusCode == 200){
                var decodeJson = jsonDecode(result.body);
                //transformando os dados json da api em objeto ordem
                decodeJson.forEach((ordem)=> ordens.add(ComentsModel.fromJson(ordem)));
                return ordens;
            } else {
                return null;
            }
        } catch (error){
            print("Erro ao receber os dados das Ordens de Serviço da api. Erro:  "+ error.toString());
            return null;
        }
    }
}

