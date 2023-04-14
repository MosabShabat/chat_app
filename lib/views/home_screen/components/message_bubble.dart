import 'package:chat_app/consts/conste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../chat_screen/chat_screen.dart';

Widget messageBubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Card(
    child: ListTile(
      onTap: () {
        Get.to(() => ChatScreen(), transition: Transition.downToUp, arguments: [
          currentUser!.uid == doc['toId']
              ? doc['friend_name']
              : doc['user_name'],
          currentUser!.uid == doc['toId'] ? doc['formId'] : doc['toId']
        ]);
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.redAccent,
        child: Image.asset(
          ic_user,
          color: Colors.white,
        ),
      ),
      title: currentUser!.uid == doc['toId']
          ? "${doc['friend_name']}".text.semiBold.size(14).make()
          : "${doc['user_name']}".text.size(16).semiBold.make(),
      subtitle: "${doc['last_msg']}".text.maxLines(1).make(),
      trailing: Directionality(
        textDirection: TextDirection.rtl,
        child: TextButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.access_time_filled_rounded,
              size: 16,
              color: Vx.gray400,
            ),
            label: time.text.gray400.make()),
      ),
    ),
  );
}
