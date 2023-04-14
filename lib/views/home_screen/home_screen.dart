import 'package:chat_app/consts/conste.dart';
import 'package:chat_app/controllers/home_controller.dart';
import 'package:chat_app/views/views.dart';
import 'package:get/get.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    var controller = Get.put(HomeController());
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: btnColor,
            onPressed: () {
              Get.to(() => const ComposeScreen(),
                  transition: Transition.downToUp);
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          backgroundColor: bgColor,
          body: Column(
            children: [
              appbar(scaffoldKey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
