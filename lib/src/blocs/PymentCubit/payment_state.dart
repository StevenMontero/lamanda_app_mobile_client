part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  const PaymentState({this.service, this.proofPhoto, this.typePayment = ''});
  final Object? service;
  final File? proofPhoto;
  final String typePayment;

  PaymentState copyWith({
    Object? service,
    File? proofPhoto,
    String? typePayment,
  }) {
    return PaymentState(
        service: service ?? this.service,
        proofPhoto: proofPhoto ?? this.proofPhoto,
        typePayment: typePayment ?? this.typePayment);
  }

  @override
  List<Object?> get props => [service, proofPhoto, typePayment];
}
