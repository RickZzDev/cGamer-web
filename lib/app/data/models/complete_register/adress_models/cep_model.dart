class CepModel {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? ddd;
  String? number;

  CepModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.ddd,
      this.number});

  CepModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ddd = json['ddd'];
  }

  CepModel.fromBEJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['address'];
    complemento = json['complement'];
    bairro = json['district'];
    localidade = json['city'];
    uf = json['state'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['address'] = this.logradouro;
    data['complement'] = this.complemento;
    data['district'] = this.bairro;
    data['city'] = this.localidade;
    data['uf'] = this.uf;
    data['number'] = this.number;
    return data;
  }
}
