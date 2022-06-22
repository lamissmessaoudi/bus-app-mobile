import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_controller.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_form_page.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_list_page.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_success_page.dart';
import 'package:softun_bus_mobile/widgets/bottombar_builder.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';
import 'package:softun_bus_mobile/widgets/custom_navigation_drawer.dart';
import 'package:softun_bus_mobile/widgets/drawer_icon.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    final c = Get.put(FeedBackController());

    return Scaffold(
      key: scaffoldState,
      drawer: CustomDrawer(),
      // floatingActionButton: Obx(
      //   () => Container(
      //     child: c.step == FeedBackStep.feedbackList
      //         ? GestureDetector(
      //             child: Image.asset(
      //               Assets.add,
      //               width: 50,
      //             ),
      //             onTap: () {
      //               c.step.value = FeedBackStep.feedbackForm;
      //               c.update();
      //             },
      //           )
      //         : null,
      //   ),
      // ),
      bottomNavigationBar: buildNavBar(),
      body: ConnectivityContainer(
        child: GetBuilder<FeedBackController>(
            init: FeedBackController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingFeedback.value
                  ? CustomLoader()
                  : Stack(children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // BODY OF THE PAGE
                              Center(
                                child: Container(
                                  width: 500,
                                  margin: EdgeInsets.symmetric(horizontal: 35),
                                  padding: EdgeInsets.only(top: 30, bottom: 10),
                                  child: controller.step ==
                                          FeedBackStep.feedbackSucces
                                      ? FeedBackSuccessPage()
                                      : controller.step ==
                                              FeedBackStep.feedbackForm
                                          ? FeedbackFormPage()
                                          : FeedbackListPage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DrawerIcon(scaffoldState: scaffoldState)
                    ]);
            }),
      ),
    );
  }
}
