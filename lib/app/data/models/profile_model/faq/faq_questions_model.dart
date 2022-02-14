class FAQQuestionsModel {
  String? categoryTitle;
  List<FAQQuestion>? questions;

  FAQQuestionsModel({this.questions, this.categoryTitle});

  FAQQuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <FAQQuestion>[];
      json['questions'].forEach((v) {
        questions?.add(new FAQQuestion.fromJson(v));
      });
    }
  }
}

class FAQQuestion {
  String? question;
  String? answer;
  int? id;
  int? categoryId;
  String? videoId;

  FAQQuestion(
      {this.id, this.question, this.answer, this.categoryId, this.videoId});

  FAQQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    categoryId = json['categoryId'];
  }
}
