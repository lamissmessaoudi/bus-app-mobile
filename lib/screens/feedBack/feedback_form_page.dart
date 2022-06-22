import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/feedBack/feedback_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class FeedbackFormPage extends StatelessWidget {
  const FeedbackFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedBackController());

    return Column(
      children: [
        Center(
          child: Text(
            "Ajouter un Feedback",
            style: AppTextStyles.primarySlab36,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
        Form(
          key: controller.formKeyFeedback,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title:",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.titleController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                hint: "Ex: Capacité de Bus",
              ),
              SizedBox(height: 20),
              Text(
                "Votre Feeddback:",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.descriptionController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                hint: "N'hésitez pas à partager.. ",
                minLines: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  text: "Envoyer votre retour",
                  onTap: controller.sendFeedback,
                  btnType: BtnType.AccentFilled,
                  width: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
