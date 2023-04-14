import 'package:chat_app/consts/styles.dart';
import 'package:chat_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../consts/conste.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: letsconnect.text.black.bold.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Pleas enter your username";
                          }
                          return null;
                        },
                        controller: controller.userNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Vx.gray400)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Vx.gray400)),
                            alignLabelWithHint: true,
                            labelText: "Username",
                            hintText: "en. Alex",
                            prefixIcon: const Icon(
                              Icons.supervised_user_circle,
                              color: btnColor,
                            ),
                            labelStyle: const TextStyle(
                                color: Vx.gray600,
                                fontWeight: FontWeight.bold)),
                      ),
                      10.heightBox,
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 9) {
                            return "Pleas enter your phone number";
                          }
                          return null;
                        },
                        controller: controller.phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Vx.gray400)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Vx.gray400)),
                            alignLabelWithHint: true,
                            labelText: "Phone Number",
                            prefixText: "+97",
                            hintText: "en. 1234567890",
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                              color: btnColor,
                            ),
                            labelStyle: const TextStyle(
                                color: Vx.gray600,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
              10.heightBox,
              opt.text.fontFamily(regular).color(greyColor).size(14).make(),
              Obx(
                () => Visibility(
                  visible: controller.isOptSent.value,
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  controller: controller.optController[index],
                                  cursorColor: btnColor,
                                  onChanged: (value) {
                                    if (value.length == 1 && index <= 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: TextStyle(
                                    fontFamily: Bold,
                                    color: btnColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: "*",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            const BorderSide(color: bgColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            const BorderSide(color: bgColor)),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.screenWidth - 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(16)),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.isOptSent.value == false) {
                          controller.isOptSent.value = true;
                          await controller.sendOtp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }
                    },
                    child: continueText.text.semiBold.size(16).make(),
                  ),
                ),
              ),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
