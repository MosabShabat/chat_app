import 'package:chat_app/consts/conste.dart';


Widget tabbar() {
  return Container(
    child: RotatedBox(
      quarterTurns: 3,
      child: const TabBar(
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Vx.gray500,
          indicator: BoxDecoration(),
          tabs: [
            Tab(
              text: chats,
            ),
            Tab(
              text: status,
            ),
            Tab(
              text: camera,
            ),
          ]),
    ),
  );
}
