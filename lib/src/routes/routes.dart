import 'package:flutter/material.dart';
import 'package:lamanda_petshopcr/src/pages/Payment/payment.dart';
import 'package:lamanda_petshopcr/src/pages/Payment/request_%20proofOfPayment_sinpe.dart';
import 'package:lamanda_petshopcr/src/pages/Profile/add_pet_page.dart';
import 'package:lamanda_petshopcr/src/pages/Profile/pet_list_page.dart';
import 'package:lamanda_petshopcr/src/pages/Profile/profile_page.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/Hotel/hotel_page.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/Nursey/nursey_page.dart';
import 'package:lamanda_petshopcr/src/pages/Profile/edit_profile_page.dart';
import 'package:lamanda_petshopcr/src/pages/LoginAndSignUp/Login/login_page.dart';
import 'package:lamanda_petshopcr/src/pages/LoginAndSignUp/Signup/signup_page.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/QuotesGrooming/grooming_page.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/Kindergarten/kindergarten_page.dart';
import 'package:lamanda_petshopcr/src/pages/LoginAndSignUp/choseLoginOrSignuo_page.dart';
import 'package:lamanda_petshopcr/src/pages/mainpage.dart';

Map<String, WidgetBuilder> getRoutesApp() {
  return <String, WidgetBuilder>{
    'choseLogOSig': (BuildContext context) => ChoseLogin(),
    'login': (BuildContext context) => LoginScreen(),
    'signup': (BuildContext context) => SignupScreen(),
    'profile': (BuildContext context) => ProfilePage(),
    'editProfile': (BuildContext context) => EditProfilePage(),
    'home': (BuildContext context) => MainScreen(),
    'grooming': (BuildContext context) => GroomingScreen(),
    'kinder': (BuildContext context) => KindergartenScreen(),
    'hotel': (BuildContext context) => HotelScreen(),
    'nursey': (BuildContext context) => NurseyScreen(),
    'petForm': (BuildContext context) => PetFormPage(),
    'petList': (BuildContext context) => PetListPage(),
    'payment': (BuildContext context) => PaymentPage(),
    'proofSinpe': (BuildContext context) => ProofPaymentSinpePage(),
  };
}
