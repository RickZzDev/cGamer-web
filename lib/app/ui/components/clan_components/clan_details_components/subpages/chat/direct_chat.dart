import 'dart:io';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/extensions/user_name_extension.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class DirectChatPage extends StatefulWidget {
  const DirectChatPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _DirectChatPageState createState() => _DirectChatPageState();
}

class _DirectChatPageState extends State<DirectChatPage> {
  bool _isAttachmentUploading = false;

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.network(
                      widget.room.imageUrl ?? "",
                      width: 32,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(UserNameExtension.reduceName(widget.room.name ?? ""),
                        style: textStyle.copyWith(fontSize: 16)),
                  ]),
                  GenericButton(
                      text: 'Ver perfil',
                      height: 26,
                      txtSize: 12,
                      txtColor: secondaryColor,
                      color: Colors.white,
                      onPressedFunction: () async {
                        String customerId = await getCustomerIdMetadata();
                        Get.toNamed(Routes.USER_PROFILE,
                            arguments: {'customerId': int.parse(customerId)});
                      }),
                ],
              )),
              leading: BackButton(color: Colors.white),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: IntrinsicHeight(
                  child: Divider(
                    color: Colors.white,
                    height: 10,
                  ),
                ),
              ),
            )),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(
              child: StreamBuilder<types.Room>(
            initialData: widget.room,
            stream: FirebaseChatCore.instance.room(widget.room.id),
            builder: (context, snapshot) {
              return StreamBuilder<List<types.Message>>(
                initialData: const [],
                stream: FirebaseChatCore.instance.messages(snapshot.data!),
                builder: (context, snapshot) {
                  return SafeArea(
                    bottom: false,
                    child: Chat(
                      isAttachmentUploading: _isAttachmentUploading,
                      messages: snapshot.data ?? [],
                      onAttachmentPressed: null,
                      onMessageTap: _handleMessageTap,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      showUserAvatars: true,
                      showUserNames: true,
                      disableImageGallery: true,
                      sendButtonVisibilityMode: SendButtonVisibilityMode.always,
                      dateLocale: "pt_BR",
                      l10n: ChatL10nPt(inputPlaceholder: "Enviar mensagem"),
                      theme: DefaultChatTheme(
                          backgroundColor: secondaryColor,
                          attachmentButtonIcon: null,
                          primaryColor: primaryColor,
                          sendButtonIcon: Icon(
                            Icons.send,
                            color: primaryColor,
                          ),
                          documentIcon: null),
                      user: types.User(
                        id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                      ),
                    ),
                  );
                  //return Container();
                },
              );
            },
          ))
        ]));
  }

  Future<String> getCustomerIdMetadata() async {
    String myCustomerId =
        await Provider.of<GetStorage>(Get.context, listen: false)
            .read('x-customerId');
    String customerId = "";

    widget.room.metadata?.keys.toList().forEach((e) {
      if (widget.room.metadata?[e] != myCustomerId) {
        customerId = widget.room.metadata?[e];
      }
    });

    return customerId;
  }
}
