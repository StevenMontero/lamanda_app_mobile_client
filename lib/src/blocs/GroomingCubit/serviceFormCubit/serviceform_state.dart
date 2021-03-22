part of 'serviceform_cubit.dart';

enum StatusFormService { pureForm, invalidForm, validForm }

class ServiceformState extends Equatable {
  const ServiceformState({
    this.status = StatusFormService.pureForm,
    this.listService = const [],
    this.isHaircutAndWash = false,
    this.isWash = false,
    this.isEarCleaning = false,
    this.isTeethCleaning = false,
  });
  final List<Service> listService;
  final bool isHaircutAndWash;
  final bool isWash;
  final bool isEarCleaning;
  final bool isTeethCleaning;
  final StatusFormService status;

  double get total {
    double total = 0;
    if (listService.length > 0) {
      listService.forEach((element) {
        total += element.price;
      });
    }
    return total;
  }

  ServiceformState copyWith({
    List<Service>? listService,
    StatusFormService? status,
    bool? isHaircutAndWash,
    bool? isWash,
    bool? isEarCleaning,
    double? total,
    bool? isTeethCleaning,
  }) {
    return ServiceformState(
        isEarCleaning: isEarCleaning ?? this.isEarCleaning,
        isWash: isWash ?? this.isWash,
        listService: listService ?? this.listService,
        isHaircutAndWash: isHaircutAndWash ?? this.isHaircutAndWash,
        isTeethCleaning: isTeethCleaning ?? this.isTeethCleaning,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        isEarCleaning,
        isHaircutAndWash,
        isTeethCleaning,
        isWash,
        status,
        listService
      ];
}
