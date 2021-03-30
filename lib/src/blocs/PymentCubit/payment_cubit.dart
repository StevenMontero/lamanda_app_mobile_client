import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lamanda_petshopcr/src/models/sthetic_appointment.dart';
import 'package:lamanda_petshopcr/src/repository/esthetic_appointment_repositorydb.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState());

  void serviceChanged(Object? service) {
    emit(state.copyWith(service: service));
  }

  void imageChanged(File image) {
    emit(state.copyWith(proofPhoto: image));
  }

  void pymetnTypeChanged(String payment) {
    emit(state.copyWith(typePayment: payment));
  }

  void summitReservation() {
    final a = state.service!;
    if( a is StheticAppointment){
      final repo = StheticAppointmentRepository();
      final idDate = '${a.entrytDate!.day}-${a.entrytDate!.month}-${a.entrytDate!.year}';
      repo.addNewAppointment(a, idDate);
    }
  }
}
