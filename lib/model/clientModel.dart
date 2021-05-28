//Classe usada criando o site: https://javiercbk.github.io/json_to_dart/
//Basta passar um resultado json da API para clientes que ele cria a classe dart.

class Clients {
    int id;
    String nome;
    String email;
    String fone;

    Clients({this.id, this.nome, this.email, this.fone});

    Clients.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        nome = json['nome'];
        email = json['email'];
        fone = json['fone'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['nome'] = this.nome;
        data['email'] = this.email;
        data['fone'] = this.fone;
        return data;
    }
}
