import 'package:chat_app/consts/styles.dart';

import '../../../consts/conste.dart';

Widget statusComponents() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: btnColor,
            child: Image.asset(
              ic_user,
              color: Colors.white,
            ),
          ),
          title: "My status".text.semiBold.color(textColor).make(),
          subtitle: "Tap to add status updates".text.gray400.make(),
          // title: RichText(
          //     text: const TextSpan(children: [
          //   TextSpan(
          //       text: "My status\n",
          //       style: TextStyle(
          //           fontFamily: semibold, fontSize: 14, color: textColor)),
          //   TextSpan(
          //       text: "Tap to add status updates",
          //       style: TextStyle(
          //           fontFamily: semibold, fontSize: 14, color: greyColor))
          // ])),
        ),
        20.heightBox,
        recentUpdates.text.semiBold.color(textColor).make(),
        20.heightBox,
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: btnColor, width: 3)),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Vx.randomColor,
                    child: Image.asset(ic_user),
                  ),
                ),
                title: "Username".text.semiBold.color(textColor).make(),
                subtitle: "Today, 8:47 PM".text.gray400.make(),
              ),
            );
          },
        )
      ],
    ),
  );
}
