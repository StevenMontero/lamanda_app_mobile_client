import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/VeterinaryCubit/veterinary_cubit.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/veterinary_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class NurseyScreen extends StatefulWidget {
  @override
  _NurseyScreenState createState() => _NurseyScreenState();
}

class _NurseyScreenState extends State<NurseyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VeterinaryCubit(VeterinaryAppointmentRepository())
        ..scheduleLoad(DateTime.now()),
      child: Scaffold(
          backgroundColor: ColorsApp.primaryColorOrange,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () => Navigator.of(context).pop()),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Seleccione una fecha",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container()),//Body()),
    );
  }
}

// class Body extends StatefulWidget {
//   Body({Key key}) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   CalendarController _calendarController;
//   int _valueM = 0;
//   String _valueTypeFur = "Labrador";
//   bool _transfer = false;
//   int edad = 1;
//   @override
//   void initState() {
//     super.initState();
//     _calendarController = CalendarController();
//   }

//   @override
//   void dispose() {
//     _calendarController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TableCalendar(
//           onDaySelected: (day, events, holidays) =>
//               BlocProvider.of<VeterinaryCubit>(context).dateChanged(day),
//           calendarController: _calendarController,
//           startDay: DateTime.now(),
//           initialCalendarFormat: CalendarFormat.week,
//           startingDayOfWeek: StartingDayOfWeek.monday,
//           formatAnimation: FormatAnimation.slide,
//           headerStyle: HeaderStyle(
//             centerHeaderTitle: true,
//             formatButtonVisible: false,
//             titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
//             leftChevronIcon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//               size: 15,
//             ),
//             rightChevronIcon: Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.white,
//               size: 15,
//             ),
//             leftChevronMargin: EdgeInsets.only(left: 70),
//             rightChevronMargin: EdgeInsets.only(right: 70),
//           ),
//           calendarStyle: CalendarStyle(
//               selectedColor: ColorsApp.primaryColorBlue,
//               weekendStyle: TextStyle(color: Colors.white),
//               weekdayStyle: TextStyle(color: Colors.white)),
//           daysOfWeekStyle: DaysOfWeekStyle(
//               weekendStyle: TextStyle(color: Colors.white),
//               weekdayStyle: TextStyle(color: Colors.white)),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         buildForm()
//       ],
//     );
//   }

//   Expanded buildForm() {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40), topRight: Radius.circular(40)),
//             color: Colors.white),
//         child: Container(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     'Horaio',
//                     style:
//                         TextStyle(fontSize: 20.0, color: Colors.blueGrey[700]),
//                   ),
//                 ),
//                 BlocBuilder<VeterinaryCubit, VeterinaryFormState>(
//                     buildWhen: (previous, current) =>
//                         previous.schedule != current.schedule,
//                     builder: (context, state) {
//                       return state.status != FormzStatus.submissionInProgress
//                           ? buildTimeTable(state.schedule)
//                           : CircularProgressIndicator();
//                     }),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 buildTypeRace(),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 buildAgeDog(),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 SwitchListTile(
//                   value: _transfer,
//                   onChanged: (value) {
//                     setState(() {
//                       _transfer = value;
//                       context.bloc<VeterinaryCubit>().transferChanged(value);
//                     });
//                   },
//                   activeColor: ColorsApp.primaryColorBlue,
//                   title: Text('Necesita trasnporte'),
//                 ),
//                 _transfer
//                     ? buildTextFieldDirection()
//                     : SizedBox(
//                         height: 5.0,
//                       ),
//                 Container(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     'Que malestar precenta su mascota?',
//                     style:
//                         TextStyle(fontSize: 20.0, color: Colors.blueGrey[700]),
//                   ),
//                 ),
//                 buildTextField(),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 BlocBuilder<VeterinaryCubit, VeterinaryFormState>(
//                   builder: (context, state) {
//                     return CustomButton(
//                       color: ColorsApp.primaryColorBlue,
//                       press: state.description != '' &&
//                               state.hourRerservation != null
//                           ? () {
//                               final user =
//                                   BlocProvider.of<AuthenticationBloc>(context)
//                                       .state
//                                       .user;
//                               context
//                                   .bloc<VeterinaryCubit>()
//                                   .addAppointmentVeterinaryForm(UserProfile(
//                                       userName: user.name,
//                                       email: user.email,
//                                       id: user.id,
//                                       photoUri: user.photo));
//                               Navigator.of(context).pop();
//                             }
//                           : null,
//                       text: 'Reservar',
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTimeTable(List<DateTime> list) {
//     return Container(
//       alignment: Alignment.center,
//       width: double.infinity,
//       child: Wrap(
//         spacing: 15.0,
//         children: List<Widget>.generate(
//           list.length,
//           (int index) {
//             return ChoiceChip(
//               label: Text(
//                 DateFormat.jm().format(list[index]),
//                 style: TextStyle(color: Colors.white, fontSize: 12.0),
//               ),
//               selected: _valueM == index,
//               selectedColor: ColorsApp.primaryColorOrange,
//               backgroundColor: ColorsApp.secondaryColorlightBlue,
//               avatar: Icon(
//                 FontAwesomeIcons.clock,
//                 color: Colors.white,
//               ),
//               onSelected: (bool selected) {
//                 setState(() {
//                   _valueM = selected ? index : null;
//                   context.bloc<VeterinaryCubit>().hourChanged(list[index]);
//                 });
//               },
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }

//   Widget buildTypeRace() {
//     return Row(
//       children: [
//         Container(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Raza',
//             style: TextStyle(fontSize: 20.0, color: Colors.blueGrey[700]),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             alignment: Alignment.center,
//             child: DropdownButtonHideUnderline(
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton(
//                   items: [
//                     DropdownMenuItem(
//                       child: Text('Labrador'),
//                       value: 'Labrador',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Pastor Aleman'),
//                       value: 'Pastor Aleman',
//                     )
//                   ],
//                   value: _valueTypeFur,
//                   onChanged: (value) {
//                     setState(() {
//                       _valueTypeFur = value;
//                       context.bloc<VeterinaryCubit>().typeRaceChanged(value);
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildTextField() {
//     return Container(
//       padding: EdgeInsets.only(top: 8.0),
//       child: TextField(
//           maxLines: 10,
//           onChanged: (value) =>
//               context.bloc<VeterinaryCubit>().descriptionSymptomsChanged(value),
//           decoration: InputDecoration(
//             hintText: 'Escriba aqui',
//             filled: true,
//             fillColor: Color(0xFFDBEDFF),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//           )),
//     );
//   }

//   Widget buildTextFieldDirection() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5.0),
//       child: Container(
//         padding: EdgeInsets.only(top: 8.0),
//         child: TextField(
//             maxLines: 3,
//             onChanged: (value) =>
//                 context.bloc<VeterinaryCubit>().direccionChanged(value),
//             decoration: InputDecoration(
//               hintText: 'Escriba aqui la dirección',
//               filled: true,
//               fillColor: Color(0xFFDBEDFF),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//             )),
//       ),
//     );
//   }

//   Widget buildAgeDog() {
//     return Row(
//       children: [
//         Container(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Edad',
//             style: TextStyle(fontSize: 20.0, color: Colors.blueGrey[700]),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             alignment: Alignment.center,
//             child: DropdownButtonHideUnderline(
//               child: ButtonTheme(
//                 alignedDropdown: true,
//                 child: DropdownButton(
//                   items: List.generate(
//                       20,
//                       (index) => DropdownMenuItem(
//                             child: Text('$index'),
//                             value: index,
//                           )),
//                   value: edad,
//                   onChanged: (value) {
//                     setState(() {
//                       edad = value;
//                       context.bloc<VeterinaryCubit>().ageChanged(value);
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
