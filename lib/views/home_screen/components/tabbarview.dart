import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/views/home_screen/home.dart';

Widget tabbarView() {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
      child: TabBarView(children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
          child: chatsComponents(),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: statusComponents(),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
        ),
      ]),
    ),
  );
}
