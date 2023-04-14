import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../main_screen.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: Colors.black54,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              backIcon,
              color: Colors.white,
            ).onTap(() {
              Get.back();
            }),
            title: settings.text.semiBold.white.make(),
          ),
          20.heightBox,
          CircleAvatar(
            radius: 45,
            backgroundColor: btnColor,
            // child: Image.network(
            //   HomeController.instance.userImage,
            //   fit: BoxFit.cover,
            // ).box.roundedFull.clip(Clip.antiAlias).make(),
          ),
          10.heightBox,
          HomeController.instance.username.text.white.semiBold.size(16).make(),
          20.heightBox,
          const Divider(
            color: btnColor,
            height: 1,
          ),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                drawerIconsList.length,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const ProfileScreen(),
                                transition: Transition.downToUp);
                            break;
                        }
                      },
                      leading: Icon(
                        drawerIconsList[index],
                        color: Colors.white,
                      ),
                      title: drawerListTitles[index].text.semiBold.white.make(),
                    )),
          ),
          10.heightBox,
          const Divider(
            color: btnColor,
            height: 1,
          ),
          10.heightBox,
          ListTile(
            onTap: () {},
            leading: Icon(
              inviteIcon,
              color: Colors.white,
            ),
            title: invite.text.semiBold.white.make(),
          ),
          Spacer(),
          ListTile(
            onTap: () async {
              await auth.signOut();
              Get.offAll(() => ChatApp(), transition: Transition.downToUp);
            },
            leading: Icon(
              logoutIcon,
              color: Colors.white,
            ),
            title: logout.text.semiBold.white.make(),
          ),
        ],
      ),
    ),
  );
}
