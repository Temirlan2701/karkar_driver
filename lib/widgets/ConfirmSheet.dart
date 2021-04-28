import 'package:flutter/material.dart';
import 'package:rider_app/brand_colors.dart';
import 'package:rider_app/widgets/TaxiButton.dart';
import 'package:rider_app/widgets/TaxiOutlineButton.dart';

class ConfirmSheet extends StatelessWidget {

  final String title;
  final String subtitle;
  final Function onPressed;

  ConfirmSheet({this.title, this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 0.5,
            offset: Offset(
              0.7,
              0.7,
            ),
          )
        ]
      ),
      height: 220,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: <Widget>[

            SizedBox(height: 10,),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontFamily: 'Brand-Bold', color: BrandColors.colorText),
            ),

            SizedBox(height: 20,),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: BrandColors.colorTextLight),
            ),

            SizedBox(height: 24,),

            Row(
              children: <Widget>[

                Expanded(
                  child: Container(
                    child: TaxiOutlineButton(
                      title: 'Назад',
                      color: BrandColors.colorLightGrayFair,
                      onPressed: (){
                      Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                SizedBox(width: 16,),

                Expanded(
                  child: Container(
                    child: TaxiButton(
                      onPressed: onPressed,
                      color: (title == 'Онлайн') ? BrandColors.colorGreen : Colors.red,
                      title: 'Подтвердить',
                    ),
                  ),
                )

              ],
            )

          ],
        ),
      ),
    );
  }
}
