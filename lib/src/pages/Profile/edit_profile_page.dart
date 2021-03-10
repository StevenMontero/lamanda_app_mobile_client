import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/profileCubit/profile_cubit.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _userID = context.read<AuthenticationBloc>().state.user.id;
    return BlocProvider(
        create: (context) =>
            ProfileCubit(UserRepository())..fillInitialDataUser(_userID),
        child: Body());
  }
}

class Body extends StatefulWidget {
  Body() : super();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserProfile? userData;
  TextEditingController _controllerUserName = new TextEditingController();
  TextEditingController _controllerLastName = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerAddres = new TextEditingController();
  @override
  void initState() {
    getInitUserData(BlocProvider.of<AuthenticationBloc>(context).state.user.id);
    super.initState();
    print('Hola');
  }

  void getInitUserData(String id) async {
    final UserProfile? user = await context.read<ProfileCubit>().getUser(id);
    setState(() {
      if (user != null) {
        _controllerUserName.text = user.userName ?? '';
        _controllerLastName.text = user.lastName ?? '';
        _controllerEmail.text = user.email ?? '';
        _controllerPhone.text = user.phone ?? '';
        _controllerAddres.text = user.address ?? '';

      }

      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar() as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
              ),
              Positioned(
                top: 15,
                child: Center(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: userData?.photoUri != null
                        ? NetworkImage(userData!.photoUri!)
                        : null,
                    child: userData?.photoUri == null
                        ? const Icon(Icons.person_outline, size: 20)
                        : null,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text("Datos personales",
                        style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.secondaryColorlightPurple)),
                  ),
                  Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              width: 2,
                              color: ColorsApp.secondaryColorlightPurple)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.userName != current.userName,
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _controllerUserName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nombre'),
                                  onChanged: (value) => context
                                      .read<ProfileCubit>()
                                      .userNameChanged(value),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              width: 2,
                              color: ColorsApp.secondaryColorlightPurple)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.lastName != current.lastName,
                              builder: (context, state) {
                                return TextFormField(
                                 controller: _controllerLastName,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Apellidos'),
                                  onChanged: (value) => context
                                      .read<ProfileCubit>()
                                      .lastNameChanged(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              width: 2,
                              color: ColorsApp.secondaryColorlightPurple)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.email != current.email,
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _controllerEmail,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Correo Electrónico'),
                                  onChanged: (value) => context
                                      .read<ProfileCubit>()
                                      .emailChanged(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              width: 2,
                              color: ColorsApp.secondaryColorlightPurple)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.phone != current.phone,
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _controllerPhone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Teléfono'),
                                  onChanged: (value) => context
                                      .read<ProfileCubit>()
                                      .phoneChanged(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              width: 2,
                              color: ColorsApp.secondaryColorlightPurple)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              buildWhen: (previous, current) =>
                                  previous.addres != current.addres,
                              builder: (context, state) {
                                return TextFormField(
                                 controller: _controllerAddres,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Dirección de domicilio'),
                                  onChanged: (value) => context
                                      .read<ProfileCubit>()
                                      .addresChanged(value),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildAppbar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.reply,
              color: ColorsApp.secondaryColorlightPurple,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      title: Center(
          child: Text('Perfil',
              style: new TextStyle(fontSize: 20, color: Colors.black))),
      actions: <Widget>[
        BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          return IconButton(
            icon: new Icon(Icons.save,
                color: ColorsApp.secondaryColorlightPurple),
            onPressed: () {
              final user =
                  BlocProvider.of<AuthenticationBloc>(context).state.user;
              context
                  .read<ProfileCubit>()
                  .editUserForm(user.id, user.photo ?? '');
              Navigator.of(context).pop();
            },
          );
        })
      ],
    );
  }

  // Widget buildOptionPerfil(user) {
  //   return
  // }
}
