import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/routes/app_routes.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_btn.dart';

class BusCard extends StatelessWidget {
  final String bus, circuit, arrivee, stationActuelle;
  final bool dispo;
  const BusCard({
    Key? key,
    required this.bus,
    required this.circuit,
    required this.arrivee,
    required this.stationActuelle,
    required this.dispo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  Assets.bus,
                  width: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(bus, style: AppTextStyles.primarySlab24),
                    Text(
                      circuit,
                      style: AppTextStyles.primarySlab17,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: dispo ? AppColors.green : AppColors.errorColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: dispo
                      ? Text(
                          "Disponible",
                          style: AppTextStyles.primarySlab17
                              .copyWith(color: AppColors.white),
                        )
                      : Text(
                          "Complet",
                          style: AppTextStyles.primarySlab17
                              .copyWith(color: AppColors.white),
                        ),
                ),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Text(
              "Arrivée dans $arrivee",
              style: AppTextStyles.primarySlab17,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Station actuelle $stationActuelle",
                style: AppTextStyles.primarySlab17,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                isSmall: true,
                width: null,
                text: "Visualiser",
                btnType: BtnType.AccentOutlined,
                onTap: () => Get.toNamed(Routes.welcome),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
