import 'package:cGamer/app/data/models/models_export.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CompleteRegisterPayload {
  String? phone;
  String? code;
  Address? address;
  String? username;
  String? motherName;

  MaskedTextController cepWithOutMask = MaskedTextController(mask: '00000000');

  CompleteRegisterPayload({this.phone, this.code, this.address});

  CompleteRegisterPayload.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    username = json['username'];
    code = json['code'];
    motherName = json['motherName'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['username'] = this.username;
    data['motherName'] = this.motherName;
    if (this.address != null) {
      data['customerAddress'] = this.address?.toJson();
    }
    return data;
  }

  // CompleteRegisterPayload.fromView(CepController _controller) {
  //   address = Address(
  //       address: _controller.responseCep.logradouro,
  //       cep: _controller.cepWithOutmask.text,
  //       city: _controller.responseCep.localidade,
  //       district: _controller.responseCep.bairro,
  //       uf: _controller.responseCep.uf,
  //       // complement: _controller.complementTxtController.text,
  //       number: _controller.numberController.text);

  //   phone = _controller.phoneWithOutMask.text;
  //   code = _controller.codeWithOutMask.text;
  // }

  CompleteRegisterPayload.fromCepPages(
      {CepModel? cepmodel,
      String? number,
      String? complement,
      String? username,
      String? motherName}) {
    cepWithOutMask.text = cepmodel?.cep ?? "";
    this.address = Address(
        address: cepmodel?.logradouro,
        cep: cepWithOutMask.text,
        city: cepmodel?.localidade,
        district: cepmodel?.bairro,
        uf: cepmodel?.uf,
        complement: complement,
        number: number);

    this.phone = "";
    this.code = "";
    this.username = username;
    this.motherName = motherName;
  }
}

class Address {
  String? address;
  String? uf;
  String? city;
  String? district;
  String? cep;
  String? complement;
  String? number;

  Address(
      {this.address,
      this.uf,
      this.city,
      this.district,
      this.cep,
      this.complement,
      this.number});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    uf = json['uf'];
    city = json['city'];
    district = json['district'];
    cep = json['cep'];
    complement = json['complement'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['uf'] = this.uf;
    data['city'] = this.city;
    data['district'] = this.district;
    data['cep'] = this.cep;
    data['complement'] = this.complement;
    data['number'] = this.number;
    return data;
  }
}
