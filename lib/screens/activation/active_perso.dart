import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';

class ActivePerso extends StatefulWidget {
  const ActivePerso({
    Key? key,
  }) : super(key: key);

  @override
  _ActivePersoState createState() => _ActivePersoState();
}

class _ActivePersoState extends State<ActivePerso> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivationController());

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: controller.formKeyPersonel,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nom ",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.nameController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Prénom",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.lastnameController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "E-mail",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.emailController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmail,
                enabled: false,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Téléphone",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.phoneController,
                inputType: TextInputType.number,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validatePhone,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Poste",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.posteController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                    text: "Suivant",
                    onTap: controller.setPerso,
                    btnType: BtnType.AccentFilled),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
