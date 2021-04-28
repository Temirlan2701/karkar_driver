

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/brand_colors.dart';
import 'package:rider_app/datamodels/tripdetails.dart';
import 'package:rider_app/globalvariable.dart';
import 'package:rider_app/screens/newtripspage.dart';
import 'package:rider_app/widgets/BrandDivier.dart';
import 'package:rider_app/widgets/ProgressDialog.dart';
import 'package:rider_app/widgets/TaxiOutlineButton.dart';
import 'package:toast/toast.dart';

class NotificationDialog extends StatelessWidget {

  final TripDetails tripDetails;

  NotificationDialog({this.tripDetails});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SizedBox(height: 30.0,),

            Image.asset('assets/images/taxi.png', width: 100,),

            SizedBox(height: 16,),

            Text('Новый заказ', style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),),

            SizedBox(height: 30.0,),

            Padding(
                padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/images/pickicon.png', height: 16, width: 16,),
                      SizedBox(width: 18,),

                      Expanded(child: Container(child: Text(tripDetails.pickupAddress, style: TextStyle(fontSize: 18),)))
                    ],
                  ),

                  SizedBox(height: 15,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/images/desticon.png', height: 16, width: 16,),
                  SizedBox(width: 18,),

                  Expanded(child: Container(child: Text(tripDetails.destinationAddress, style: TextStyle(fontSize: 18),)))
                ],
              ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            BrandDivier(),

            SizedBox(height: 8,),

            Padding(
                padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: TaxiOutlineButton(
                          title: 'Отклонить',
                          color: BrandColors.colorPrimary,
                          onPressed: () async {

                            assetsAudioPlayer.stop();
                            Navigator.pop(context);
                          },
                        ),

                      ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        title: 'Принять',
                        color: BrandColors.colorGreen,
                        onPressed: () async {
                          assetsAudioPlayer.stop();
                          checkAvailablity(context);
                        },
                      ),

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void checkAvailablity(context){

    showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(status: 'Принятие заказа',)
    );

    DatabaseReference newRideRef = FirebaseDatabase.instance.reference().child('drivers/${currentFirebaseUser.uid}/newtrip');
    newRideRef.once().then((DataSnapshot snapshot){

      Navigator.pop(context);
      Navigator.pop(context);

      String thisRideID = "";
      if(snapshot.value != null){
        thisRideID = snapshot.value.toString();
      }
      else{
        print('Заказ не найден');
      }

      if(thisRideID == tripDetails.rideID){
        newRideRef.set('accepted');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTripPage(tripDetails: tripDetails,),
          ));
      }
      else if(thisRideID == 'cancelled'){
        Toast.show("Заказ был отменен", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else if(thisRideID == 'timeout'){
        Toast.show("Время ожидания истекло", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
      else{
        Toast.show("Заказ не найден", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    });
  }
}
