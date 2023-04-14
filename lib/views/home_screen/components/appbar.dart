import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/controllers/home_controller.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return GestureDetector(
    onTap: () {
      key.currentState!.openDrawer();
    },
    child: Container(
      padding: const EdgeInsets.only(right: 12),
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            width: 90,
            decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            child: const Icon(
              settingsIcon,
              color: Colors.white,
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "$appname\n",
                style: TextStyle(
                    fontFamily: bold, fontSize: 22, color: Colors.black)),
            TextSpan(
                text: "                  $connectingLives\n",
                style: TextStyle(
                    fontFamily: "lato",
                    fontSize: 14,
                    color: Vx.gray600,
                    fontWeight: FontWeight.w400)),
          ])),
          CircleAvatar(
            backgroundColor: Colors.redAccent,
            radius: 25,
            // child: Image.network(
            //   HomeController.instance.userImage,
            // ).box.roundedFull.clip(Clip.antiAlias).make(),
          )
        ],
      ),
    ),
  );
}
