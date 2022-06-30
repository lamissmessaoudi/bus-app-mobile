// ignore_for_file: prefer__ructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/models/station_model.dart';

import 'package:softun_bus_mobile/screens/auth/signin/signin_controller.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class FixStation extends GetView<SigninController> {
  FixStation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ConnectivityContainer(
        child: GetBuilder<SigninController>(
          init: SigninController(),
          initState: (_) {},
          builder: (controller) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                    width: 500,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: controller.isLoadingFix.value
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Text(
                                                  "Ajouter votre Station",
                                                  style: AppTextStyles
                                                      .primarySlab36,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              Text(
                                                "Choisissez votre Station",
                                                style:
                                                    AppTextStyles.hintPTMono18,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Form(
                                                key: controller
                                                    .formKeyDropDownFix,
                                                child: DropdownButtonFormField(
                                                  isExpanded: true,
                                                  decoration: InputDecoration(
                                                    focusColor:
                                                        AppColors.accentColor,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .borderColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .accentColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .errorColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    filled: true,
                                                  ),
                                                  value:
                                                      controller.chosenStation,
                                                  onChanged:
                                                      controller.selectStation,
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return controller
                                                        .stationsList
                                                        .map<Widget>(
                                                            (Station item) {
                                                      return Text(item.name);
                                                    }).toList();
                                                  },
                                                  items: controller.stationsList
                                                      .map<
                                                              DropdownMenuItem<
                                                                  Station>>(
                                                          (Station valueItem) {
                                                    return DropdownMenuItem(
                                                        value: valueItem,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          3),
                                                              child: Text(
                                                                valueItem.name,
                                                                style: AppTextStyles
                                                                    .primarySlab17,
                                                              ),
                                                            ),
                                                            Text(
                                                              valueItem
                                                                  .description,
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
                                    Center(
                                      child: CustomButton(
                                          text: "Suivant",
                                          width: null,
                                          onTap: controller.setLocation,
                                          btnType: BtnType.AccentFilled),
                                    ),
                                  ]),
                            ),
                          )),
              ),
            );
          },
        ),
      ),
    );
  }
}
