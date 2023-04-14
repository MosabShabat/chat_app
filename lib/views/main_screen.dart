import 'package:chat_app/views/singin_screen/singin_screen.dart';
import 'package:get/get.dart';

import '../consts/conste.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    width: 120,
                  ),
                  appname.text.size(28).fontFamily(bold).make(),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10.0,
                    children: List.generate(listOfFeatures.length, (index) {
                      return Chip(
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 4),
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(
                            color: Vx.gray400,
                          ),
                          label: listOfFeatures[index]
                              .text
                              .semiBold
                              .gray600
                              .make());
                    }),
                  ),
                  20.heightBox,
                  slogan.text.size(38).fontFamily(bold).letterSpacing(2).make(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.screenWidth - 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(16)),
                      onPressed: () {
                        Get.to(() => SingInScreen(),
                            transition: Transition.downToUp);
                      },
                      child: cont.text.semiBold.size(16).make(),
                    ),
                  ),
                  10.heightBox,
                  poweredby.text.size(15).gray600.make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
