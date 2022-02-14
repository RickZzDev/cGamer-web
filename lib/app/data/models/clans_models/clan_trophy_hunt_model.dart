import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';

class TrophyHuntModel {
  late HunterTrophy hunterTrophy;

  TrophyHuntModel.fromJson(Map<String, dynamic> json) {
    hunterTrophy = HunterTrophy.fromJson(json['hunterTrophy']);
  }
}

class HunterTrophy {
  late bool hunting;
  late bool bag;
  late int payPoints;
  late List<ClanDetailsMembers> hunters;

  HunterTrophy.fromJson(Map<String, dynamic> json) {
    hunting = json['hunting'];
    bag = json['bag'];
    payPoints = json['payPoints'];
    if (json['hunters'] != null) {
      hunters = [];
      json['hunters'].forEach(
          (object) => hunters.add(ClanDetailsMembers.fromJson(object)));
    }
  }
}

class TrophyHuntModelRequest {
  bool? bag;
  TrophyHuntModelRequest();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bag'] = bag ?? false;

    return data;
  }
}

// POST
// /cla/hunter-trophy

// REQUEST
// bag = true/false

// Regras de negócio
// --Salvar dados na tabela cla_trophy_hunters
// --Se bag == true, descontar 20 pontos do usuário.
// --Verificar se o usuário tem os pontos suficientes para descontar


// GET
// /cla/hunter-trophy

// RESPONSE 
// - hunting = true/false (se existir o customer id na tabela cla_trophy_hunters, retornar true)
// - bag = true, se caso hunting = true, devolver valor da coluna "bag" da linha na tabela cla_trophy_hunters. Caso contrário retornar false;
// - payPoints: 20 (valor em pontos que será descontado para o usuário, caso opte por usar uma bag para caçar os trofeus)
// - hunters (Array de membros) - trazer array de membros do clã em questão que estão na tabela cla_trophy_hunters, procurando.