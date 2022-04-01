import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/models/demande_model.dart';
import 'package:softun_bus_mobile/models/enum.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';

class RequestCard extends StatelessWidget {
  final Demande demande;
  const RequestCard({
    Key? key,
    required this.demande,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      color: AppColors.headerGray,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  Assets.demande,
                  width: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(demande.titre, style: AppTextStyles.primarySlab24),
                    Text(
                      demande.date ?? "",
                      style: AppTextStyles.primarySlab14,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: demande.status == RequestState.Accepted
                        ? AppColors.green
                        : demande.status == RequestState.Rejected
                            ? AppColors.errorColor
                            : AppColors.yellow),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: demande.status == RequestState.Accepted
                      ? Text(
                          "Acceptée",
                          style: AppTextStyles.primarySlab17
                              .copyWith(color: AppColors.white),
                        )
                      : demande.status == RequestState.Rejected
                          ? Text(
                              "Refusée",
                              style: AppTextStyles.primarySlab17
                                  .copyWith(color: AppColors.white),
                            )
                          : Text(
                              "En attente",
                              style: AppTextStyles.primarySlab17
                                  .copyWith(color: AppColors.white),
                            ),
                ),
              )
            ]),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "${demande.description} ",
                style: AppTextStyles.primarySlab17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
