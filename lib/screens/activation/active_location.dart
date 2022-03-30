import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/screens/activation/activation_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class ActiveLocation extends StatefulWidget {
  ActiveLocation({
    Key? key,
  }) : super(key: key);

  @override
  _ActiveLocationState createState() => _ActiveLocationState();
}

class _ActiveLocationState extends State<ActiveLocation> {
  // final controller = Get.put(ActivationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivationController>(
        init: ActivationController(),
        initState: (_) {},
        builder: (controller) {
          return controller.isLoadingActivation.value
              ? CustomLoader()
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Choisissez votre Station ",
                                      style: AppTextStyles.hintPTMono18,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Form(
                                      key: controller.formKeyDropDown,
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.accentColor,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.borderColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.accentColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.errorColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          filled: true,
                                        ),
                                        value: controller.chosenStation,
                                        onChanged: controller.selectStation,
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return controller.stationsList
                                              .map<Widget>((Station item) {
                                            return Text(item.name);
                                          }).toList();
                                        },
                                        items: controller.stationsList
                                            .map<DropdownMenuItem<Station>>(
                                                (Station valueItem) {
                                          return DropdownMenuItem(
                                              value: valueItem,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 3),
                                                    child: Text(
                                                      valueItem.name,
                                                      style: AppTextStyles
                                                          .primarySlab17,
                                                    ),
                                                  ),
                                                  Text(
                                                    valueItem.description,
                                                    style: AppTextStyles
                                                        .primarySlab14,
                                                  )
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Ou bien choisissez la position dans map:",
                            style: AppTextStyles.hintPTMono18,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: AppColors.inactiveGrayBg,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                  text: "Retour",
                                  onTap: controller.returnPage,
                                  btnType: BtnType.AccentOutlined),
                              CustomButton(
                                  text: "Suivant",
                                  onTap: controller.setLocation,
                                  btnType: BtnType.AccentFilled),
                            ],
                          ),
                        ]),
                  ),
                );
        });
  }
}
