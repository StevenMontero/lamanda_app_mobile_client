import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_petshopcr/src/models/daycare_appointment.dart';
import 'package:lamanda_petshopcr/src/models/hotel_appointment.dart';
import 'package:lamanda_petshopcr/src/models/sthetic_appointment.dart';
import 'package:lamanda_petshopcr/src/models/veterinary_appointment.dart';
import 'package:lamanda_petshopcr/src/repository/daycare_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/esthetic_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/hotel_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/veterinary_appointment_repositorydb.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
      {required this.esteticRepo,
      required this.dayCareRepo,
      required this.veterinaryRepo,
      required this.hotelRepo})
      : super(PaymentState());
  final picker = ImagePicker();
  final StheticAppointmentRepository esteticRepo;
  final DaycareAppointmentRepository dayCareRepo;
  final VeterinaryAppointmentRepository veterinaryRepo;
  final HotelAppointmentRepository hotelRepo;
  void serviceChanged(Object? service) {
    emit(state.copyWith(service: service));
  }

  void imageChanged(File image) {
    emit(state.copyWith(proofPhoto: image));
  }

  void pymetnTypeChanged(String payment) {
    emit(state.copyWith(typePayment: payment));
  }

  void filePhotoChange(ImageSource source) async {
    File? _photo;
    final pickedFile = await picker.getImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(state.copyWith(proofPhoto: _photo));
  }

  void summitReservation() {
    final appoiment = state.service!;
    if (appoiment is StheticAppointment) {
      appoiment.pymentType = state.typePayment;
      final idDate =
          '${appoiment.entrytDate!.day}-${appoiment.entrytDate!.month}-${appoiment.entrytDate!.year}';
      esteticRepo.addNewAppointment(appoiment, idDate, proof: state.proofPhoto);
    } else if (appoiment is VeterinaryAppointment) {
      appoiment.pymentType = state.typePayment;
      final idDate =
          '${appoiment.date!.day}-${appoiment.date!.month}-${appoiment.date!.year}';
      veterinaryRepo.addNewAppointment(appoiment, idDate,
          proof: state.proofPhoto);
    } else if (appoiment is HotelAppointment) {
      appoiment.pymentType = state.typePayment;
      hotelRepo.addNewAppointment(appoiment, proof: state.proofPhoto);
    } else if (appoiment is DaycareAppointment) {
      appoiment.pymentType = state.typePayment;
      dayCareRepo.addNewAppointment(appoiment, proof: state.proofPhoto);
    }
    //Limpia el stream
    emit(PaymentState());
  }
}
