import 'package:chat_app/consts/conste.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget pickerDialog(context, controller) {
  var listTaile = [camera, gallery, cancel];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_actual_rounded,
    Icons.cancel
  ];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      color: bgColor,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.semiBold.white.make(),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.back();
                            controller.pickImage(context, ImageSource.camera);
                            break;
                          case 1:
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;
                          case 2:
                            Get.back();
                            break;
                        }
                      },
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      title: listTaile[index].text.white.make(),
                    )),
          )
        ],
      ),
    ),
  );
}
