import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/controllers/chats_controller.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:chat_app/views/chat_screen/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                      text: "${controller.friendName}\n",
                      style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: "Last seen",
                      style: TextStyle(
                          fontFamily: semibold, fontSize: 14, color: greyColor),
                    ),
                  ]))),
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                  ),
                  10.widthBox,
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            30.heightBox,
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(bgColor),
                        ),
                      )
                    : StreamBuilder(
                        stream: StoreServices.getChats(controller.chatId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(bgColor),
                              ),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var doc = snapshot.data!.docs[index];
                                return chatBubble(index, doc);
                              }).toList(),
                            );
                          }
                        },
                      ),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                      controller: controller.messageController,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 14,
                          color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.emoji_emotions_rounded,
                            color: Colors.white,
                          ),
                          suffixIcon: Icon(
                            Icons.attachment_rounded,
                            color: greyColor,
                          ),
                          border: InputBorder.none,
                          hintText: "Type message here...",
                          hintStyle: TextStyle(
                              fontFamily: semibold,
                              fontSize: 14,
                              color: Colors.white)),
                    ),
                  )),
                  10.widthBox,
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage(controller.messageController.text);
                    },
                    child: const CircleAvatar(
                      backgroundColor: btnColor,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
