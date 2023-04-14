import 'dart:io';

import 'package:chat_app/controllers/controller.dart';
import 'package:chat_app/services/store_services.dart';
import 'package:chat_app/views/profile_screen/components/picker_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../consts/conste.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        title: profile.text.bold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                if (controller.imgPath.isEmpty) {
                  controller.updateProfile(context);
                } else {
                  await controller.uploadProfileImage();
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.white.semiBold.make())
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        //init FutureBuilder
        child: FutureBuilder(
          future: StoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs[0];
              controller.nameController.text = data['name'];
              controller.phoneController.text = data['phone'];
              controller.aboutController.text = data['about'];
              return Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: [
                          controller.imgPath.isEmpty && data['image_url'] == ''
                              ? Image.asset(
                                  ic_user,
                                  color: Colors.white,
                                )
                              : controller.imgPath.isNotEmpty
                                  ? Image.file(
                                      File(controller.imgPath.value),
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(data['image_url'])
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                          Positioned(
                              right: 0,
                              bottom: 20,
                              child: CircleAvatar(
                                backgroundColor: btnColor,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ).onTap(() {
                                  Get.dialog(pickerDialog(context, controller));
                                }),
                              ))
                        ],
                      ),
                    ),
                  ),
                  //   20.heightBox,
                  const Divider(
                    color: btnColor,
                    height: 10,
                  ),
                  10.heightBox,
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.nameController,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 14,
                          color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          label: "Name".text.make(),
                          isDense: true,
                          labelStyle: const TextStyle(
                              color: Colors.white, fontFamily: semibold)),
                    ),
                    subtitle: nameSub.text.semiBold.gray400.make(),
                  ),
                  20.heightBox,
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.aboutController,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 14,
                          color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          label: "About".text.make(),
                          isDense: true,
                          labelStyle: const TextStyle(
                              color: Colors.white, fontFamily: semibold)),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.phoneController,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 14,
                          color: Colors.white),
                      readOnly: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          label: "Phone".text.make(),
                          isDense: true,
                          labelStyle: const TextStyle(
                              color: Colors.white, fontFamily: semibold)),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
