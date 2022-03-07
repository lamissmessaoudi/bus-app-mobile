import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/badge.dart';

class ActivationHeader extends StatelessWidget {
  final ActivationStep step;
  const ActivationHeader({
    Key? key,
    required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool perso = (step == ActivationStep.Personal),
        loc = (step == ActivationStep.Location),
        conf = (step == ActivationStep.Confirmation);

    return Container(
      width: double.infinity,
      height: 170,
      color: AppColors.headerGray,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Activation",
            style: AppTextStyles.primarySlab36,
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Center(
                child: Container(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomBadge(
                            isSelected: perso,
                            text: '1',
                          ),
                          Text(
                            "Coordonnées",
                            style: AppTextStyles.activeMontserrat14,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomBadge(
                            isSelected: loc,
                            text: '2',
                          ),
                          Text(
                            "Localisation",
                            style: AppTextStyles.inactiveMontserrat14,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomBadge(
                            isSelected: conf,
                            text: '3',
                          ),
                          Text(
                            "Confirmation",
                            style: AppTextStyles.inactiveMontserrat14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
