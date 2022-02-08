abstract class ClanEndpoints {
  static final String _clanUrl = '/cla';
  static final String postNewClan = _clanUrl + '/create';
  static final String rankingClans = _clanUrl + '/ranking';
  static final String rankingMembers = _clanUrl + '/members/ranking';
  static getClansUrl() => _clanUrl;
  static final String getEmblems = _clanUrl + '/emblems';
  static final String getPlayWinTrophys = _clanUrl + '/earn-trophy';
  static final String rescueTrophy = _clanUrl + '/trophy/rescue';

  static getClanDetailsUrl(String id) => _clanUrl + '/$id' + '/details';
  static requestEntry(String id) => _clanUrl + '/$id' + '/requests-entry';
  static leftCla(String id) => _clanUrl + '/$id' + '/left';
  static putEditClanUrl(String id) => _clanUrl + '/$id' + '/update';
  static final String clanInfo = _clanUrl + '/info';
  static approveMember(String id, String customerId) =>
      _clanUrl + '/$id' + '/requests-entry/$customerId';
  static reproveMember(String id, String customerId) =>
      _clanUrl + '/$id' + '/requests-entry/$customerId';
  static promoveMember(String id, String customerId, String roleName) =>
      _clanUrl + '/$id' + '/manage/$customerId/$roleName/role';

  static removeMember(String id, String customerId) =>
      _clanUrl + '/$id' + '/manage/$customerId/remove';

  static final getRouletteItems = _clanUrl + '/roulette';
  static final playRoulette = _clanUrl + '/roulette';

  static final String hunterTrophy = _clanUrl + '/hunter-trophy';
  static final String jogoVelha = _clanUrl + '/jogo-velha';

  static final String getQuestions = _clanUrl + '/quiz/questions';
  static final String startQuiz = _clanUrl + '/quiz/start';
  static String sendAnswer(int questionId) => _clanUrl + '/quiz/$questionId';
}
