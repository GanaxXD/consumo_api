//Classe usada criando o site: https://javiercbk.github.io/json_to_dart/
//Basta passar um resultado json da API para clientes que ele cria a classe dart.

class Clients {
    int id;
    String nome;
    String email;
    String fone;

    Clients({this.id, this.nome, this.email, this.fone});

    /*
    Transforma um objeto json em um cliente.
     */
    Clients.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        nome = json['nome'];
        email = json['email'];
        fone = json['fone'];
    }

    /*
    Mapeia um objeto dart em um objeto json.
     */
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['nome'] = this.nome;
        data['email'] = this.email;
        data['fone'] = this.fone;
        return data;
    }

    Map<String, dynamic> toJsonObject(Clients client) {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = client.id;
        data['nome'] = client.nome;
        data['email'] = client.email;
        data['fone'] = client.fone;
        return data;
    }
}
