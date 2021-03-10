import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/HotelCubit/hotel_cubit.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/hotel_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class HotelScreen extends StatefulWidget {
  @override
  _HotelScreenState createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return BlocProvider(
        create: (context) => HotelCubit(HotelAppointmentRepository())
          ..userDeliverChanged(
              UserProfile(id: user.id, userName: user.name, email: user.email)),
        child: Scaffold(
          backgroundColor: ColorsApp.primaryColorTurquoise,
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
              "Hotel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Body(),
        ));
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? _valueTypeRace = "Labrador";
  int? edad = 0;

  bool _isCastrated = false;
  bool _isSociable = false;
  bool _isVacunas = false;
  bool _traslado = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        buildForm()
      ],
    );
  }

  Expanded buildForm() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        BlocBuilder<HotelCubit, HotelState>(
                          buildWhen: (previous, current) =>
                              previous.entryDate != current.entryDate,
                          builder: (context, state) {
                            return buildLastDateOf(
                                'Fecha de entrada',
                                DateFormat.yMMMd()
                                    .format(state.entryDate ?? DateTime.now()),
                                'entry');
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<HotelCubit, HotelState>(
                          buildWhen: (previous, current) =>
                              previous.departureDate != current.departureDate,
                          builder: (context, state) {
                            return buildLastDateOf(
                                'Fecha de salida',
                                DateFormat.yMMMd().format(
                                    state.departureDate ?? DateTime.now()),
                                'departure');
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    buildCupos(10)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                buildTypeDog(),
                SizedBox(
                  height: 10,
                ),
                buildAgeDog(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Encargado de retiro',
                  style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[700]),
                ),
                buildTextField(),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<HotelCubit, HotelState>(
                  buildWhen: (previous, current) =>
                      previous.lastDeworming != current.lastDeworming,
                  builder: (context, state) {
                    return buildLastDateOf(
                        'Última fecha de desparasitación',
                        DateFormat.yMMMd()
                            .format(state.lastDeworming ?? DateTime.now()),
                        'deworming');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<HotelCubit, HotelState>(
                  buildWhen: (previous, current) =>
                      previous.lastProtectionFleas !=
                      current.lastProtectionFleas,
                  builder: (context, state) {
                    return buildLastDateOf(
                        'Ultima protección contra pulgas y garrapatas',
                        DateFormat.yMMMd().format(
                            state.lastProtectionFleas ?? DateTime.now()),
                        'fleas');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                buildOptionsLsit(),
                _traslado
                    ? buildTextFieldDirection()
                    : SizedBox(
                        height: 5.0,
                      ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<HotelCubit, HotelState>(
                  builder: (context, state) {
                    return CustomButton(
                      color: ColorsApp.primaryColorTurquoise,
                      press: state.userPickup != '' && state.userDeliver != null
                          ? () {
                              final user =
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .state
                                      .user;
                              context
                                  .read()<HotelCubit>()
                                  .addAppointmentHotelForm(new UserProfile(
                                      userName: user.name,
                                      email: user.email,
                                      id: user.id,
                                      photoUri: user.photo));
                              Navigator.of(context).pop();
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

  Widget buildTextFieldDirection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        padding: EdgeInsets.only(top: 8.0),
        child: TextField(
            maxLines: 3,
            onChanged: (value) =>
                context.read<HotelCubit>().direccionChanged(value),
            decoration: InputDecoration(
              hintText: 'Escriba aqui la dirección',
              filled: true,
              fillColor: Color(0xFFDBEDFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            )),
      ),
    );
  }

  Widget buildDatePiker(String date, String type) {
    return Container(
      width: 170,
      child: OutlineButton(
        borderSide: BorderSide(color: ColorsApp.primaryColorTurquoise),
        highlightedBorderColor: ColorsApp.primaryColorTurquoise,
        highlightColor: ColorsApp.primaryColorTurquoise,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () => _presentDatePicker(type),
        child: Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(
              width: 10,
            ),
            Text(date),
          ],
        ),
      ),
    );
  }

  Widget buildTypeDog() {
    return Row(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Raza',
            style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[700]),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text('Labrador'),
                      value: 'Labrador',
                    ),
                    DropdownMenuItem(
                      child: Text('Pastator Aleman'),
                      value: 'Pastator Aleman',
                    )
                  ],
                  value: _valueTypeRace,
                  onChanged: (dynamic value) {
                    setState(() {
                      _valueTypeRace = value;
                      context.read<HotelCubit>().raceChanged(value);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAgeDog() {
    return Row(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Edad',
            style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[700]),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  items: List.generate(
                      20,
                      (index) => DropdownMenuItem(
                            child: Text('$index'),
                            value: index,
                          )),
                  value: edad,
                  onChanged: (dynamic value) {
                    setState(() {
                      edad = value;
                      context.read<HotelCubit>().ageChanged(value);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField() {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: TextField(
          onChanged: (value) =>
              context.read<HotelCubit>().userPickupChanged(value),
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Escriba aqui',
            filled: true,
            fillColor: Color(0xFFDBEDFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          )),
    );
  }

  Widget buildLastDateOf(String mensaje, String date, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mensaje,
          style: TextStyle(fontSize: 15.0, color: Colors.blueGrey[700]),
        ),
        buildDatePiker(date, type)
      ],
    );
  }

  _presentDatePicker(String type) async {
    final refDate = DateTime.now();
    final picked = await showDatePicker(
        context: context,
        initialDate: refDate,
        firstDate: refDate,
        lastDate: DateTime(refDate.year + 1, refDate.month, refDate.day));

    switch (type) {
      case 'entry':
        context.read<HotelCubit>().entryDateChanged(picked);
        break;
      case 'departure':
        context.read<HotelCubit>().departureDateChanged(picked);
        break;
      case 'deworming':
        context.read<HotelCubit>().lastDewormingChanged(picked);
        break;
      case 'fleas':
        context.read<HotelCubit>().lastProtectionFleasChanged(picked);
        break;
      default:
    }
  }

  Widget buildOptionsLsit() {
    return Column(
      children: [
        SwitchListTile(
          title: Text('Vacunas al dia'),
          activeColor: ColorsApp.primaryColorTurquoise,
          value: _isVacunas,
          onChanged: (value) {
            setState(() {
              _isVacunas = value;
              context.read<HotelCubit>().isVaccinationUpDateChanged(value);
            });
          },
        ),
        SwitchListTile(
          title: Text('Castrado'),
          activeColor: ColorsApp.primaryColorTurquoise,
          value: _isCastrated,
          onChanged: (value) {
            setState(() {
              _isCastrated = value;
              context.read<HotelCubit>().isCastratedDateChanged(value);
            });
          },
        ),
        SwitchListTile(
          title: Text('Sociable'),
          activeColor: ColorsApp.primaryColorTurquoise,
          value: _isSociable,
          onChanged: (value) {
            setState(() {
              _isSociable = value;
              context.read<HotelCubit>().isSociableChanged(value);
            });
          },
        ),
        SwitchListTile(
          title: Text('Traslado'),
          activeColor: ColorsApp.primaryColorTurquoise,
          value: _traslado,
          onChanged: (value) {
            setState(() {
              _traslado = value;
              context.read<HotelCubit>().transporteChanged(value);
            });
          },
        ),
      ],
    );
  }

  Widget buildCupos(int cupos) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(width: 1, color: ColorsApp.primaryColorTurquoise)),
      child: Stack(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: ColorsApp.primaryColorTurquoise,
            ),
            child: Center(
              child: Text(
                'Cupos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            top: 85,
            left: 45,
            child: Container(
              height: 50,
              width: 60,
              child: Center(
                child: Text(
                  '$cupos',
                  style: TextStyle(
                      fontSize: 20,
                      color: ColorsApp.primaryColorTurquoise,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
