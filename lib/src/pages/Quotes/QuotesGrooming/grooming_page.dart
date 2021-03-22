import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_petshopcr/src/blocs/GroomingCubit/grooming_cubit.dart';
import 'package:lamanda_petshopcr/src/blocs/GroomingCubit/infoForm/infoform_cubit.dart';
import 'package:lamanda_petshopcr/src/blocs/GroomingCubit/scheduleCubit/selectschedule_cubit.dart';
import 'package:lamanda_petshopcr/src/blocs/GroomingCubit/serviceFormCubit/serviceform_cubit.dart';
import 'package:lamanda_petshopcr/src/models/service.dart';
import 'package:lamanda_petshopcr/src/repository/esthetic_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class GroomingScreen extends StatefulWidget {
  @override
  _GroomingScreenState createState() => _GroomingScreenState();
}

class _GroomingScreenState extends State<GroomingScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroomingCubit>(create: (context) => GroomingCubit()),
        BlocProvider<InfoformCubit>(create: (context) => InfoformCubit()),
        BlocProvider<SelectscheduleCubit>(
            create: (context) =>
                SelectscheduleCubit(StheticAppointmentRepository())
                  ..scheduleLoad(DateTime.now())),
        BlocProvider<ServiceformCubit>(create: (context) => ServiceformCubit()),
      ],
      child: Scaffold(
          backgroundColor: ColorsApp.backgroundColor,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                  size: 25.0,
                ),
                onPressed: () => Navigator.of(context).pop()),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorsApp.primaryColorDark,
            title: Text(
              "Reservaciones para Estética",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          body: Body()),
    );
  }
}

class Body extends StatefulWidget {
  Body() : super();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(child: stepper()),
        ],
      ),
    );
  }

  Widget stepper() {
    return Builder(
      builder: (context) {
        final gromingCubitState = context.watch<GroomingCubit>().state;
        final serviceFormCubitState = context.watch<ServiceformCubit>().state;

        return Stepper(
          physics: ScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: gromingCubitState.currentStep,
          onStepContinue: () => context.read<GroomingCubit>().nextStep(),
          onStepCancel: () => context.read<GroomingCubit>().backStep(),
          steps: [
            Step(
              title:
                  Text(gromingCubitState.currentStep == 0 ? 'Servicios' : ''),
              isActive: gromingCubitState.currentStep == 0,
              state: serviceFormCubitState.status ==
                          StatusFormService.invalidForm &&
                      serviceFormCubitState.status != StatusFormService.pureForm
                  ? StepState.error
                  : StepState.indexed,
              content: BlocBuilder<ServiceformCubit, ServiceformState>(
                builder: (context, state) {
                  return Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          children: [
                            buildOptionsServices(serviceFormCubitState),
                            Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Center(
                                  child: Text(
                                    '*Debe seleccionar al menos una opción',
                                    style: TextStyle(
                                        color: serviceFormCubitState.status ==
                                                StatusFormService.invalidForm
                                            ? Colors.red
                                            : Colors.black45),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Step(
              title: Text(gromingCubitState.currentStep == 1 ? 'Horario' : ''),
              isActive: gromingCubitState.currentStep == 1,
              state: StepState.indexed,
              content: buildChooseDateHour(context),
            ),
            Step(
              title: Text(gromingCubitState.currentStep == 2 ? 'Datos' : ''),
              isActive: gromingCubitState.currentStep == 2,
              state: StepState.indexed,
              content: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildFormInfo(),
                ),
              ),
            ),
            Step(
              isActive: gromingCubitState.currentStep == 3,
              state: StepState.indexed,
              title: Text(
                  gromingCubitState.currentStep == 3 ? 'Confirmación' : ''),
              content: Column(
                children: <Widget>[
                  buildSummary(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Column buildFormInfo() {
    return Column(
      children: <Widget>[
        _petDropList(),
        SizedBox(
          height: 12.0,
        ),
        buildOptionsLsit(),
        SizedBox(
          height: 12.0,
        ),
        buildTextField(
            label: '¿Que necesita su mascota?',
            hintText: 'Tipo de corte, tipo de baño … Etc.',
            maxLines: 4,
            onChanged: (value) =>
                context.read<InfoformCubit>().descriptionChanged(value)),
      ],
    );
  }

  Column buildChooseDateHour(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  'Seleccione una fecha',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15),
                ),
              ),
              buildTableCalendar(context),
            ],
          ),
          color: Colors.white,
        ),
        SizedBox(
          height: 23,
        ),
        Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Text(
                'Seleccione una hora',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
            ),
            Container(
              child: buildSchedule(),
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13.0),
            ),
          ],
        ))
      ],
    );
  }

  Widget buildSummary() {
    return Builder(
      builder: (context) {
        final serviceCubitState = context.watch<ServiceformCubit>().state;
        final scheduleCubitState = context.watch<SelectscheduleCubit>().state;
        final groomingCubitState = context.watch<GroomingCubit>().state;
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPetInfo(nombre: 'Nana', peso: '10', pelaje: 'largo'),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${scheduleCubitState.date.day}/${scheduleCubitState.date.month}/${scheduleCubitState.date.year}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15),
                ),
                Text(
                  '${DateFormat.jm().format(scheduleCubitState.hourRerservation!)} - ${DateFormat.jm().format(DateTime(scheduleCubitState.hourRerservation!.year, 1, 1, scheduleCubitState.hourRerservation!.hour + 1))}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                ),
                buildSummaryServices(
                    serviceList: serviceCubitState.listService),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                    Text(
                      'CRC ${serviceCubitState.total}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSummaryServices({required List<Service> serviceList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
          children: List.generate(serviceList.length, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              serviceList[index].name,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
            ),
            Text(
              'CRC ${serviceList[index].price}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
            ),
          ],
        );
      })),
    );
  }

  Widget _buildPetInfo(
      {required String nombre, required String peso, required String pelaje}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nombre,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15),
        ),
        Text(
          'Peso: $peso kg',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        ),
        Text(
          'Pelaje: $pelaje',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        ),
      ],
    );
  }

  Widget buildTableCalendar(BuildContext context) {
    return BlocBuilder<SelectscheduleCubit, SelectscheduleState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return TableCalendar(
          locale: 'es_Es',
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.black),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.black,
              )),
          calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  color: ColorsApp.primaryColorOrange, shape: BoxShape.circle),
              defaultTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: Colors.black),
              disabledTextStyle: TextStyle(color: Colors.black),
              isTodayHighlighted: false),
          daysOfWeekHeight: 25,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.black),
            weekendStyle: TextStyle(color: Colors.orangeAccent),
          ),
          availableCalendarFormats: {CalendarFormat.month: 'Month'},
          firstDay: DateTime.now(),
          lastDay: DateTime(3000, 12),
          focusedDay: state.date,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return isSameDay(state.date, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(state.date, selectedDay)) {
              // Call `setState()` when updating the selected day

              context
                  .read<SelectscheduleCubit>()
                  .dateInCalendarChanged(selectedDay);
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            context
                .read<SelectscheduleCubit>()
                .dateInCalendarChanged(focusedDay);
          },
        );
      },
    );
  }

  Widget buildSchedule() {
    return BlocBuilder<SelectscheduleCubit, SelectscheduleState>(
        builder: (context, state) {
      return state.status != FormzStatus.submissionInProgress
          ? Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 15.0,
              children: List<Widget>.generate(
                state.schedule.length,
                (int index) {
                  return ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    label: Text(
                      DateFormat.jm().format(state.schedule[index]),
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    selected: state.index == index,
                    selectedColor: ColorsApp.primaryColorOrange,
                    backgroundColor: ColorsApp.secondaryColorlightBlue,
                    avatar: Icon(
                      FontAwesomeIcons.clock,
                      size: 17,
                      color: Colors.white,
                    ),
                    onSelected: (bool selected) {
                      context.read<SelectscheduleCubit>().hourChanged(
                          state.schedule[index], selected ? index : null);
                    },
                  );
                },
              ).toList(),
            )
          : Center(child: CircularProgressIndicator());
    });
  }

  Widget buildOptionsLsit() {
    return BlocBuilder<InfoformCubit, InfoformState>(
      builder: (context, state) {
        return Column(
          children: [
            CheckboxListTile(
              subtitle: Text('Vamos por su mascota'),
              title: Text('¿Necesita traslado?'),
              activeColor: ColorsApp.primaryColorOrange,
              value: state.transfer,
              onChanged: (value) {
                context.read<InfoformCubit>().istransferChanged(value!);
              },
            ),
            state.transfer
                ? buildTextField(
                    label: 'Dirección',
                    hintText: 'Escriba aquí su dirección',
                    maxLines: 1,
                    errorMessage: 'Caracteres especiales no permitidos',
                    onChanged: (value) =>
                        context.read<InfoformCubit>().addresChanged(value),
                    isErrorOccurred: state.address.invalid)
                : Container()
          ],
        );
      },
    );
  }

  Widget _petDropList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 5.0),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: 'Seleccione su mascota'),
          iconSize: 24,
          elevation: 16,
          value: 'Nana',
          style: const TextStyle(color: ColorsApp.primaryColorBlue),
          onChanged: (String? newValue) {},
          items: [
            DropdownMenuItem<String>(
              value: 'Nana',
              child: Text('Nana'),
            ),
            DropdownMenuItem<String>(
              value: 'Hola',
              child: Text('Hola2'),
            )
          ]),
    );
  }

  Widget buildTextField(
      {required String label,
      required String hintText,
      required int maxLines,
      required ValueChanged<String> onChanged,
      String errorMessage = '',
      bool isErrorOccurred = false}) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: ColorsApp.primaryColorBlue),
        labelText: label,
        hintText: hintText,
        filled: true,
        errorText: isErrorOccurred ? errorMessage : null,
        enabledBorder: OutlineInputBorder(),
        helperText: '*Obligatorio',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: ColorsApp.primaryColorOrange),
        ),
      ),
    );
  }

  Widget buildOptionsServices(ServiceformState state) {
    return Column(
      children: [
        CheckboxListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.pets,
                  size: 18.0,
                  color: ColorsApp.primaryColorBlue,
                ),
              ),
              Text('Corte + Baño'),
            ],
          ),
          activeColor: ColorsApp.primaryColorOrange,
          value: state.isHaircutAndWash,
          onChanged: (value) => context
              .read<ServiceformCubit>()
              .isHaircutAndWashChanged(value ?? false, 12.0, 'Perro'),
        ),
        CheckboxListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.pets,
                  size: 18.0,
                  color: ColorsApp.primaryColorBlue,
                ),
              ),
              Text('Baño'),
            ],
          ),
          activeColor: ColorsApp.primaryColorOrange,
          value: state.isWash,
          onChanged: (value) => context
              .read<ServiceformCubit>()
              .isWashChanged(value ?? false, 12.0, 'Perro', 'Largo'),
        ),
        CheckboxListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.pets,
                  size: 18.0,
                  color: ColorsApp.primaryColorBlue,
                ),
              ),
              Text('Limpieza de oídos'),
            ],
          ),
          activeColor: ColorsApp.primaryColorOrange,
          value: state.isEarCleaning,
          onChanged: (value) => context
              .read<ServiceformCubit>()
              .isEarCleaningChanged(value ?? false),
        ),
        CheckboxListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.pets,
                  size: 18.0,
                  color: ColorsApp.primaryColorBlue,
                ),
              ),
              Text('Lavado de dientes'),
            ],
          ),
          activeColor: ColorsApp.primaryColorOrange,
          value: state.isTeethCleaning,
          onChanged: (value) => context
              .read<ServiceformCubit>()
              .isTeethCleaningChanged(value ?? false),
        ),
      ],
    );
  }
}
