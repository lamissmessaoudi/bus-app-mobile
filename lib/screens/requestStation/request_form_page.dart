import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/screens/requestStation/request_station_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_text_field.dart';
import 'package:softun_bus_mobile/widgets/pick_location_container.dart';

class RequestFormPage extends StatelessWidget {
  const RequestFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestStationController());

    return Column(
      children: [
        Center(
          child: Text(
            "Demande d'ajout d'une nouvelle station",
            style: AppTextStyles.primarySlab36,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
        Form(
          key: controller.formKeyDemande,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Zone:",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.zoneController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                hint: "Ex: Ariana",
              ),
              SizedBox(height: 20),
              Text(
                "Description détaillée de l'emplacement:",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.descriptionController,
                focusColor: AppColors.accentColor,
                borderColor: AppColors.borderColor,
                errorColor: AppColors.errorColor,
                validator: controller.validateEmpty,
                hint: "Ex: Rond point petite Arianna prés de magasin général ",
                minLines: 2,
              ),
              SizedBox(height: 20),
              Text(
                "Choisissez l'emplacement sur la carte:",
                style: AppTextStyles.hintPTMono18,
              ),
              SizedBox(height: 15),
              Container(
                height: 150,
                // color: AppColors.inactiveGrayBg,
                child: LocationPicker(),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CustomButton(
                  text: "Envoyer la demande",
                  onTap: controller.sendRequest,
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
