import 'package:cGamer/app/data/provider/profile_provider/my_progress_provider/my_progress_provider.dart';
import 'package:meta/meta.dart';

class MyProgressRepository {
  final MyProgressApiClient apiClient;

  MyProgressRepository({required this.apiClient});

  getLevels() async {
    return await apiClient.getLevels();
  }

  getMyProgressInfo() async {
    return await apiClient.getMyProgressInfo();
  }
}
