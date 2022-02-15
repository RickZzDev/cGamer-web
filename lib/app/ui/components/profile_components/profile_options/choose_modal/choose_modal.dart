import 'package:cGamer/app/controllers/profile/profile_controller.dart';
import 'package:cGamer/app/data/models/profile_model/games_model/games_model.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChooseGameModalBottomSheet extends StatefulWidget {
  const ChooseGameModalBottomSheet({
    Key? key,
    required ProfileController controller,
  })   : _controller = controller,
        super(key: key);

  final ProfileController _controller;

  @override
  _ChooseGameModalBottomSheetState createState() =>
      _ChooseGameModalBottomSheetState();
}

class _ChooseGameModalBottomSheetState
    extends State<ChooseGameModalBottomSheet> {
  List<int> selected = [];
  List<Games>? gamesToFilter = [];
  var isLoading = false.obs;
  @override
  void initState() {
    gamesToFilter = widget._controller.gamesList.games;
    verifyIfAlreadySelected();
    super.initState();
  }

  FilterUtils filterUtils = FilterUtils();
  TextEditingController _filterGamesTextController = TextEditingController();

  _refreshAllGames() async {
    await widget._controller.getGames();
  }

  double _checkSelected(int _index) {
    if (selected == null) {
      if (widget._controller.gamesList.games?[_index].selected ?? false)
        return 1;
      else
        return 0;
    } else if (selected.contains(_index + 1))
      return 1;
    else
      return 0;
  }

  Color checkSelectedOpacity(int _index) {
    if (selected == null) {
      if (widget._controller.gamesList.games?[_index].selected ?? false)
        return Colors.white.withOpacity(0.5);
      else
        return Colors.white.withOpacity(0);
    } else if (selected.contains(_index + 1))
      return Colors.white.withOpacity(0.5);
    else
      return Colors.white.withOpacity(0.0);
  }

  _saveGames() async {
    isLoading.value = true;
    var response = await widget._controller.homeRepository.sendGames(selected);
    if (ExceptionUtils.verifyIfIsException(response)) {
      SnackBarUtils.showSnackBar(
          desc: 'Algo deu errado, tente novamente.', title: 'Atenção');
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.back();
    }
    print(response);
  }

  verifyIfAlreadySelected() {
    widget._controller.gamesList.games?.forEach((element) {
      if (element.selected ?? false) {
        setState(() {
          selected.add(element.id ?? 0);
        });
      }
    });
  }

  _chooseItem(int _index) {
    setState(
      () {
        if (widget._controller.gamesList.games?[_index].selected ?? false) {
          widget._controller.gamesList.games?[_index].selected = false;
        }
        selected.contains(_index + 1)
            ? selected.remove(_index + 1)
            : selected.add(_index + 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      width: double.infinity,
      height: screenHeigthSize * 0.8,
      child: Obx(
        () => ModalProgressHUD(
          inAsyncCall: isLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 20, right: 24, left: 24),
                  child: Text(
                    'Escolha seus jogos favoritos',
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              // Padding(
              //   padding: EdgeInsets.only(top: 0, bottom: 16, right: 24, left: 24),
              //   child: TextField(
              //     style: TextStyle(color: Colors.white),
              //     controller: _filterGamesTextController,
              //     onChanged: (value) {
              //       setState(() {
              //         gamesToFilter = filterUtils.filterGames(
              //             value: value,
              //             listTofilter: gamesToFilter,
              //             initialListValue: widget._controller.gamesList.games);
              //       });
              //       print(gamesToFilter);
              //     },
              //     decoration: InputDecoration(
              //       hintText: "Escolha seu jogo favorito",
              //       hintStyle: textStyle,
              //       border: UnderlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor),
              //       ),
              //       disabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor),
              //       ),
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: primaryColor),
              //       ),
              //       prefixIcon: Icon(
              //         Icons.search_outlined,
              //         color: primaryColor,
              //         size: 24,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: gamesToFilter?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => _chooseItem(index),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 8,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: screenWidthhSize / 5,
                              height: screenWidthhSize / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget._controller
                                        .gamesList.games?[index].image ??
                                    ""),
                              ),
                              // child: Center(
                              //   child: CachedNetworkImage(
                              //     imageUrl: widget.avatarModel.avatars[index].image,
                              //     fit: BoxFit.cover,
                              //     alignment: Alignment.topCenter,
                              //     placeholder: (context, url) =>
                              //         CircularProgressIndicator(
                              //       backgroundColor: primaryColor,
                              //     ),
                              //   ),
                              // ),
                            ),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: _checkSelected(index),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                width: screenWidthhSize / 5,
                                height: screenWidthhSize / 5,
                                decoration: BoxDecoration(
                                  color: widget._controller.gamesList
                                              .games?[index].selected ??
                                          false
                                      ? Colors.white.withOpacity(0.5)
                                      : selected.contains(index + 1)
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white.withOpacity(0),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: primaryColor, width: 2),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check_outlined,
                                    color: primaryColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenHeigthSize * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GenericButton(
                        text: "Cancelar",
                        onPressedFunction: () => Navigator.pop(context),
                        txtColor: Colors.blueGrey,
                        color: Colors.white),
                    SizedBox(
                      width: screenWidthhSize * 0.02,
                    ),
                    SizedBox(
                      width: screenWidthhSize * 0.55,
                      child: GenericButton(
                        text: "Salvar",
                        txtColor: Colors.white,
                        onPressedFunction: () async {
                          if (saveVerification(selected.length)) {
                            await _saveGames();

                            await widget._controller.refreshSelectedGames();
                            await _refreshAllGames();
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool saveVerification(int size) {
    if (size == 0) {
      SnackBarUtils.showSnackBar(
          desc: "Selecione algum jogo.", title: "Atenção");
      return false;
    }
    return true;
  }
}
