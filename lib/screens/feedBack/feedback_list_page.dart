import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_controller.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/card_request.dart';

class FeedbackListPage extends StatelessWidget {
  const FeedbackListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedBackController());
    return Column(
      children: [
        Center(
          child: Text(
            "Vos Feedbacks",
            style: AppTextStyles.primarySlab36,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40),
        Column(
          children: [
            Text(
              "Vos retours nous aide à améliorer notre services",
              style: AppTextStyles.primarySlab20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Image.asset(
                Assets.feedback,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              " \n N'hésitez pas à vous exprimer ",
              style: AppTextStyles.primarySlab17,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Ajouter votre Feedback",
              width: null,
              onTap: () {
                controller.step.value = FeedBackStep.feedbackForm;
                controller.update();
              },
              btnType: BtnType.AccentFilled,
            )
          ],
        )
      ],
    );
  }
}

getRequestCards(List<Demande>? list) {
  return Column(children: [
    SizedBox(),
    ...?list?.map(
      (item) => RequestCard(demande: item),
    )
  ]);
}
