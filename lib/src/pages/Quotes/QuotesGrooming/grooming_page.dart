import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/GroomingCubit/grooming_cubit.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/sthetic_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class GroomingScreen extends StatefulWidget {
  @override
  _GroomingScreenState createState() => _GroomingScreenState();
}

class _GroomingScreenState extends State<GroomingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroomingCubit(StheticAppointmentRepository())
        ..scheduleLoad(DateTime.now()),
      child: Scaffold(
          backgroundColor: ColorsApp.primaryColorBlue,
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
          body: Container())//Body()),
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
//   String _valueTypeFur = "Liso";
//   bool _transfer = false;
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
//               BlocProvider.of<GroomingCubit>(context)
//                   .dateInCalendarChanged(day),
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
//               selectedColor: ColorsApp.primaryColorOrange,
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
//                 BlocBuilder<GroomingCubit, GroomingFormState>(
//                     buildWhen: (previous, current) =>
//                         previous.schedule != current.schedule,
//                     builder: (context, state) {
//                       print('aaaaaaaaaaaaaaaa' + state.description);
//                       return state.status != FormzStatus.submissionInProgress
//                           ? buildTimeTable(state.schedule)
//                           : CircularProgressIndicator();
//                     }),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 buildTypeFur(),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 SwitchListTile(
//                   value: _transfer,
//                   onChanged: (value) {
//                     setState(() {
//                       _transfer = value;
//                       context.bloc<GroomingCubit>().transferChanged(value);
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
//                     'Que necesita su mascota?',
//                     style:
//                         TextStyle(fontSize: 20.0, color: Colors.blueGrey[700]),
//                   ),
//                 ),
//                 buildTextField(),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 BlocBuilder<GroomingCubit, GroomingFormState>(
//                   builder: (context, state) {
//                     return CustomButton(
//                       color: ColorsApp.primaryColorBlue,
//                       press: () {
//                         if (state.description != '' &&
//                             state.hourRerservation != null) {
//                           final user =
//                               BlocProvider.of<AuthenticationBloc>(context)
//                                   .state
//                                   .user;
//                           context
//                               .bloc<GroomingCubit>()
//                               .addAppointmentGroomingForm(new UserProfile(
//                                   userName: user.name,
//                                   email: user.email,
//                                   id: user.id,
//                                   photoUri: user.photo));
//                           Navigator.of(context).pop();}
//                       },
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
//               selectedColor: ColorsApp.primaryColorBlue,
//               backgroundColor: ColorsApp.secondaryColorlightBlue,
//               avatar: Icon(
//                 FontAwesomeIcons.clock,
//                 color: Colors.white,
//               ),
//               onSelected: (bool selected) {
//                 setState(() {
//                   _valueM = selected ? index : null;
//                   context.bloc<GroomingCubit>().hourChanged(list[index]);
//                 });
//               },
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }

//   Widget buildTypeFur() {
//     return Row(
//       children: [
//         Container(
//           alignment: Alignment.topLeft,
//           child: Text(
//             'Tipo de pelaje',
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
//                       child: Text('Liso'),
//                       value: 'Liso',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Colocho'),
//                       value: 'Colocho',
//                     )
//                   ],
//                   value: _valueTypeFur,
//                   onChanged: (value) {
//                     setState(() {
//                       _valueTypeFur = value;
//                       context.bloc<GroomingCubit>().typeFurChanged(value);
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
//               context.bloc<GroomingCubit>().descriptionChanged(value),
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
//                 context.bloc<GroomingCubit>().direccionChanged(value),
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
// }
