import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/brand_colors.dart';
import 'package:rider_app/globalvariable.dart';
import 'package:rider_app/screens/mainpage.dart';
import 'package:rider_app/widgets/TaxiButton.dart';


class VehicleInfoPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  static const String id = 'vehicleinfo';

  var carModelController = TextEditingController();
  var carColorController = TextEditingController();
  var vehicleNumberController = TextEditingController();

  void updateProfile(context) {
    String id = currentFirebaseUser.uid;
    
    DatabaseReference driverRef = FirebaseDatabase.instance.reference().child('drivers/$id/vehicle_details');

    Map map = {
      'car_color': carColorController.text,
      'car_model': carModelController.text,
      'vehicle_number': vehicleNumberController.text,
    };
    driverRef.set(map);

    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),

              Image.asset('assets/images/logo.png', height: 110, width: 110,),

              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                 children: <Widget>[

                   SizedBox( height: 10,),

                   Text('Введите данные об автомобиле', style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 22),),

                   SizedBox(height: 25,),

                   TextField(
                     controller: carModelController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                     labelText: 'Модель автомобиля',
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 10,
                       )
                   ),
                       style: TextStyle(fontSize: 14),
                   ),

                   SizedBox(height: 10,),

                   TextField(
                     controller: carColorController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                         labelText: 'Цвет автомобиля',
                         hintStyle: TextStyle(
                           color: Colors.grey,
                           fontSize: 10,
                         )
                     ),
                     style: TextStyle(fontSize: 14),
                   ),

                   SizedBox(height: 10,),

                   TextField(
                     controller: vehicleNumberController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                         labelText: 'Номер автомобиля',
                         hintStyle: TextStyle(
                           color: Colors.grey,
                           fontSize: 10,
                         )
                     ),
                     style: TextStyle(fontSize: 14),
                   ),

                   SizedBox(height: 40,),

                   TaxiButton(
                     color: BrandColors.colorGreen,
                     title: 'Продолжить',
                     onPressed: (){
                       
                       if(carModelController.text.length < 3){
                         showSnackBar('Пожалуйста, введите действительную модель автомобиля');
                         return;
                       }

                       if(carModelController.text.length < 3){
                         showSnackBar('Пожалуйста, введите действительный цвет автомобиля');
                         return;
                       }

                       if(carModelController.text.length < 3){
                         showSnackBar('Пожалуйста, введите действительный номер автомобиля');
                         return;
                       }

                       updateProfile(context);

                     },
                   )


                 ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
