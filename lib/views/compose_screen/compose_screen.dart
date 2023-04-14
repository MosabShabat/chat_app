import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:chat_app/views/chat_screen/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "New Message".text.semiBold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: Colors.white),
        child: StreamBuilder(
          stream: StoreServices.getAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     var data = snapshot.data!.docs[0];
            //  print(snapshot.data!.docs[0]);
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),
              );
            } else {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  var doc = snapshot.data!.docs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: bgColor.withOpacity(0.1))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage("${doc['image_url']}")),
                                5.widthBox,
                                "${doc['name']}"
                                    .split(' ')
                                    .take(1)
                                    .join(' ')
                                    .text
                                    .semiBold
                                    .size(14)
                                    .color(textColor)
                                    .make()
                              ],
                            ),
                            20.heightBox,
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      primary: bgColor),
                                  onPressed: () {
                                    Get.to(() => ChatScreen(),
                                        transition: Transition.downToUp,
                                        arguments: [
                                          doc['name'],
                                          doc['id'],
                                        ]);
                                  },
                                  icon: Icon(Icons.message),
                                  label: "Message".text.make()),
                            )
                          ],
                        )),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
