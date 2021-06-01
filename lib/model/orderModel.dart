class Orders {
    int id;
    String descricao;
    Cliente cliente;
    double preco;
    Null dataAbertura;
    Null dataFinalizacao;
    String status;

    Orders(
        {this.id,
            this.descricao,
            this.cliente,
            this.preco,
            this.dataAbertura,
            this.dataFinalizacao,
            this.status});

    Orders.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        descricao = json['descricao'];
        cliente =
        json['cliente'] != null ? new Cliente.fromJson(json['cliente']) : null;
        preco = json['preco'];
        dataAbertura = json['dataAbertura'];
        dataFinalizacao = json['dataFinalizacao'];
        status = json['status'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['descricao'] = this.descricao;
        if (this.cliente != null) {
            data['cliente'] = this.cliente.toJson();
        }
        data['preco'] = this.preco;
        data['dataAbertura'] = this.dataAbertura;
        data['dataFinalizacao'] = this.dataFinalizacao;
        data['status'] = this.status;
        return data;
    }
}

class Cliente {
    int id;
    String nome;

    Cliente({this.id, this.nome});

    Cliente.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        nome = json['nome'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['nome'] = this.nome;
        return data;
    }
}
