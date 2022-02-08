import 'package:get/get.dart';

class PagesHolderController extends GetxController {
  final currentIndex = 0.obs;

  changeIndex(value) => this.currentIndex.value = value;

  Function? changeTabView;

  @override
  void onReady() {
    changeTabView = changeIndex;
    super.onReady();
  }

  // List<Widget> pages = [
  //   HomePage(changeTabView),
  //   // SizedBox(),
  //   MarketplaceView(),
  //   WalletCardsView(),
  //   ProfileView()
  // ];
}
