import 'package:cGamer/app/data/provider/profile_provider/faq_provider/faq_provider.dart';
import 'package:meta/meta.dart';

class FAQRepository {
  final FAQApiClient apiClient;

  FAQRepository({required this.apiClient});

  getCategories() async {
    return await apiClient.getCategories();
  }

  getQuestions(int categoryId) async {
    return await apiClient.getQuestions(categoryId);
  }
}
