import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_code_page.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_controller.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_email_page.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_success_page.dart';
import 'package:softun_bus_mobile/screens/forgetPassword/forgot_password_update.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ForgetPasswordController());

    return Scaffold(
      floatingActionButton: Obx(
        () => Container(
          child: c.step == ForgetPasswordStep.recuperationCode
              ? GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    c.step.value = ForgetPasswordStep.recuperationEmail;
                    c.update();
                  },
                )
              : null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: ConnectivityContainer(
        child: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingRecuper.value
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
                                          ForgetPasswordStep.recuperationSucces
                                      ? ForgetPasswordSuccessPage()
                                      : controller.step ==
                                              ForgetPasswordStep
                                                  .recuperationCode
                                          ? ForgetPasswordCodePage()
                                          : controller.step ==
                                                  ForgetPasswordStep
                                                      .recuperationPassword
                                              ? ForgetPasswordUpdatePage()
                                              : ForgetPasswordEmailPage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
            }),
      ),
    );
  }
}
