//KindergartenScreen
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/KinderCubit/kinder_cubit.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/daycare_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class KindergartenScreen extends StatefulWidget {
  @override
  _KindergartenScreenState createState() => _KindergartenScreenState();
}

class _KindergartenScreenState extends State<KindergartenScreen> {
  @override
  Widget build(BuildContext context) {
    final _userInfoProfile =
        context.read<AuthenticationBloc>().state.userProfile;
    final _userPetList = context.read<AuthenticationBloc>().state.petList;
    return BlocProvider(
        create: (context) => KinderCubit(DaycareAppointmentRepository())
          ..userDeliverChanged(_userInfoProfile!),
        child: Scaffold(
          backgroundColor: ColorsApp.primaryColorBlue, //Colors.pink[200],
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white60,
                  size: 25.0,
                ),
                onPressed: () => Navigator.of(context).pop()),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorsApp.primaryColorDark,
            title: Text(
              "Reservaciones para Guardería",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          body: Body(_userPetList),
        ));
  }
}

class Body extends StatefulWidget {
  const Body(
    this.userPetList, {
    Key? key,
  }) : super(key: key);
  final List<Pet> userPetList;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    context.read<KinderCubit>().dateInCalendarChanged(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildTableCalendar(context), buildForm()],
    );
  }

  Widget buildTableCalendar(BuildContext context) {
    return BlocBuilder<KinderCubit, KinderState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return TableCalendar(
          locale: 'es_Es',
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              )),
          calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  color: ColorsApp.primaryColorOrange, shape: BoxShape.circle),
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white),
              disabledTextStyle: TextStyle(color: Colors.white70),
              isTodayHighlighted: false),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.orangeAccent),
          ),
          availableCalendarFormats: {CalendarFormat.week: 'Week'},
          firstDay: DateTime.now(),
          lastDay: DateTime(3000, 12),
          focusedDay: state.date,
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(state.date, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(state.date, selectedDay)) {
              // Call `setState()` when updating the selected day

              context.read<KinderCubit>().dateInCalendarChanged(selectedDay);
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            context.read<KinderCubit>().dateInCalendarChanged(focusedDay);
          },
        );
      },
    );
  }

  Expanded buildForm() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17), topRight: Radius.circular(17)),
            color: ColorsApp.backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHourPiker(),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Center(
                    child: Text('*Horario de atención 10:00 a.m - 5:30 p.m'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                _petDropList(),
                buildOptionsLsit(),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<KinderCubit, KinderState>(
                  builder: (context, state) {
                    return CustomButton(
                      color: ColorsApp.primaryColorBlue,
                      press: state.status == FormzStatus.valid
                          ? () {
                              final user =
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .state
                                      .user;
                              context
                                  .read<KinderCubit>()
                                  .addAppointmentDaycareForm(new UserProfile(
                                      userName: user.name,
                                      email: user.email,
                                      id: user.id,
                                      photoUri: user.photo));
                              // Navigator.of(context).pop();
                            }
                          : null,
                      text: 'Reservar',
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _petDropList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 5.0),
      child: DropdownButtonFormField<Pet>(
          decoration: InputDecoration(labelText: 'Seleccione su mascota'),
          iconSize: 24,
          elevation: 16,
          value: widget.userPetList[0],
          style: const TextStyle(color: ColorsApp.primaryColorBlue),
          onChanged: (Pet? newValue) =>
              context.read<KinderCubit>().petChanged(newValue!),
          items: List.generate(
            widget.userPetList.length,
            (index) => DropdownMenuItem<Pet>(
              value: widget.userPetList[index],
              child: Text(widget.userPetList[index].name!),
            ),
          )),
    );
  }

  Row buildHourPiker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<KinderCubit, KinderState>(
          builder: (context, state) {
            return buildLastHourOf(
                mensaje: 'Hora de entrada',
                hour: state.entryHour.value != null &&
                        state.entryHour.value![1] != null
                    ? DateFormat.jm().format(state.entryHour.value![1]!)
                    : 'Seleccionar',
                type: 'entry',
                error: state.entryHour.invalid,
                errorMessage: 'Hora invalida',
                disable: false);
            // DateFormat.jm().format(state.entryHour)
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Container(
            width: 1,
            height: 42,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        BlocBuilder<KinderCubit, KinderState>(
          builder: (context, state) {
            return buildLastHourOf(
                mensaje: 'Hora de salida',
                hour: state.departureHour.value != null &&
                        state.entryHour.value![1] != null
                    ? DateFormat.jm().format(state.departureHour.value![1]!)
                    : 'Seleccionar',
                type: 'out',
                error: state.departureHour.invalid,
                errorMessage: 'Hora invalida',
                disable: state.entryHour.value == null ? true : false);
          },
        ),
      ],
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

  Widget buildDatePiker(String date, String type) {
    return Container(
      width: 170,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: ColorsApp.primaryColorBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: ColorsApp.primaryColorPink),
            )),
        onPressed: () => _presentDatePicker(type),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded),
            SizedBox(
              width: 10,
            ),
            Text(date),
          ],
        ),
      ),
    );
  }

  void _timePiker(String type) async {
    TimeOfDay selectedTime = await (showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        )) ??
        TimeOfDay.now();
    final date = DateTime.now();
    final dateWithTime = DateTime(date.year, date.month, date.day,
        selectedTime.hour, selectedTime.minute);
    switch (type) {
      case 'entry':
        context.read<KinderCubit>().entryHourChanged(dateWithTime);
        break;
      case 'out':
        context.read<KinderCubit>().departureHourChanged(dateWithTime);
        break;
      default:
    }
  }

  void _presentDatePicker(String type) async {
    final refDate = DateTime.now();
    var showDatePicker2 = showDatePicker(
        locale: const Locale("es", "ES"),
        context: context,
        initialDate: refDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(refDate.year + 10, refDate.month, refDate.day));
    final picked = await showDatePicker2;

    switch (type) {
      case 'deworming':
        context.read<KinderCubit>().lastDewormingChanged(picked);
        break;
      case 'fleas':
        context.read<KinderCubit>().lastProtectionFleasChanged(picked);
        break;
      default:
    }
  }

  Widget buildOptionsLsit() {
    return BlocBuilder<KinderCubit, KinderState>(
      builder: (context, state) {
        return Column(
          children: [
            CheckboxListTile(
              subtitle: Text('Si es así, ingrese la fecha de aplicación'),
              title: Text('¿Está desparasitada la mascota?'),
              activeColor: ColorsApp.primaryColorOrange,
              value: state.isDeworming,
              onChanged: (value) {
                context.read<KinderCubit>().isDewormingChanged(value!);
                context
                    .read<KinderCubit>()
                    .lastDewormingChanged(DateTime.now());
              },
            ),
            state.isDeworming
                ? buildDatePiker(
                    DateFormat.yMMMd()
                        .format(state.lastDeworming.value ?? DateTime.now()),
                    'deworming')
                : Container(),
            CheckboxListTile(
              subtitle: Text('Si es así, ingrese la fecha de aplicación'),
              title: Text('¿Control de pulgas y garrapatas?'),
              activeColor: ColorsApp.primaryColorOrange,
              value: state.isProtectionFleas,
              onChanged: (value) {
                context.read<KinderCubit>().isProtectionFleasChanged(value!);
              },
            ),
            state.isProtectionFleas
                ? buildDatePiker(
                    DateFormat.yMMMd().format(
                        state.lastProtectionFleas.value ?? DateTime.now()),
                    'fleas')
                : Container(),
            CheckboxListTile(
              subtitle: Text('Persona que no sea yo'),
              title: Text('¿Otra persona retira la mascota?'),
              activeColor: ColorsApp.primaryColorOrange,
              value: state.ispickUpSomeoneElse,
              onChanged: (value) {
                context.read<KinderCubit>().ispickUpSomeoneElseChanged(value!);
              },
            ),
            state.ispickUpSomeoneElse
                ? buildTextField(
                    label: 'Nombre',
                    hintText: 'Escriba aquí el nombre',
                    maxLines: 1,
                    errorMessage:
                        'Números y caracteres especiales no permitidos',
                    onChanged: (value) =>
                        context.read<KinderCubit>().userPickupChanged(value),
                    isErrorOccurred: state.userPickup.invalid)
                : Container(),
            CheckboxListTile(
              subtitle: Text('Vamos por su mascota'),
              title: Text('¿Necesita traslado?'),
              activeColor: ColorsApp.primaryColorOrange,
              value: state.transporte,
              onChanged: (value) {
                context.read<KinderCubit>().istransporteChanged(value!);
              },
            ),
            state.transporte
                ? buildTextField(
                    label: 'Dirección',
                    hintText: 'Escriba aquí su dirección',
                    maxLines: 1,
                    errorMessage: 'Caracteres especiales no permitidos',
                    onChanged: (value) =>
                        context.read<KinderCubit>().direccionChanged(value),
                    isErrorOccurred: state.direccion.invalid)
                : Container()
          ],
        );
      },
    );
  }

  Widget buildLastHourOf(
      {required String mensaje,
      required String hour,
      required String type,
      required bool error,
      required bool disable,
      required String errorMessage}) {
    return Expanded(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: disable
                  ? null
                  : () {
                      _timePiker(type);
                    },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      mensaje,
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.watch_later_outlined,
                            size: 17,
                            color: ColorsApp.primaryColorBlue,
                          ),
                        ),
                        Text(
                          hour,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              color: disable
                                  ? Colors.grey
                                  : error
                                      ? Colors.red
                                      : ColorsApp.primaryColorBlue),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: error
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.center,
                  )
                : Text(''),
          )
        ],
      ),
    );
  }
}
