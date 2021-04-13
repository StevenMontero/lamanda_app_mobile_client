//import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/profileCubit/profile_cubit.dart';
import 'package:lamanda_petshopcr/src/models/userProfile.dart';
import 'package:lamanda_petshopcr/src/repository/user_repository.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/textfielform.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    UserProfile _userProfile =
        context.read<AuthenticationBloc>().state.userProfile!;
    return BlocProvider(
        create: (context) =>
            ProfileCubit(UserRepository())..fillInitialDataUser(_userProfile),
        child: Body(_userProfile));
  }
}

class Body extends StatefulWidget {
  Body(this.userProfile) : super();
  final UserProfile userProfile;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserProfile? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppbar() as PreferredSizeWidget?,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 10),
                  child: Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: widget.userProfile.photoUri != null
                          ? NetworkImage(widget.userProfile.photoUri!)
                          : null,
                      child: widget.userProfile.photoUri == null
                          ? const Icon(Icons.person, size: 20)
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
                      SizedBox(height: 20.0),
                      _userName(),
                      SizedBox(height: 20.0),
                      _lastName(),
                      SizedBox(height: 20.0),
                      _email(),
                      SizedBox(height: 20.0),
                      _phone(),
                      SizedBox(height: 20.0),
                      _addres(),
                      SizedBox(height: 20.0),
                    ]),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _userName() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: widget.userProfile.userName,
          errorOccurred: state.userName.invalid,
          errorMessage: 'No ingresar signos ni números',
          icon: Icons.person,
          lavel: 'Nombre de Usuario',
          inputType: TextInputType.text,
          onChanged: (value) =>
              context.read<ProfileCubit>().userNameChanged(value),
        );
      },
    );
  }

  Widget _lastName() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: widget.userProfile.lastName,
          errorOccurred: state.lastName.invalid,
          errorMessage: 'No ingresar signos ni números',
          icon: Icons.person,
          lavel: 'Apellidos',
          inputType: TextInputType.text,
          onChanged: (value) =>
              context.read<ProfileCubit>().lastNameChanged(value),
        );
      },
    );
  }

  Widget _email() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: widget.userProfile.email,
          errorOccurred: state.email.invalid,
          errorMessage: 'Correo electrónico no válido',
          icon: Icons.email,
          lavel: 'Correo electrónico',
          inputType: TextInputType.text,
          onChanged: (value) =>
              context.read<ProfileCubit>().emailChanged(value),
        );
      },
    );
  }

  Widget _phone() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: widget.userProfile.phone,
          errorOccurred: state.phone.invalid,
          errorMessage: 'Número no válido',
          icon: Icons.phone,
          lavel: 'Número de teléfono',
          inputType: TextInputType.number,
          onChanged: (value) =>
              context.read<ProfileCubit>().phoneChanged(value),
        );
      },
    );
  }

  Widget _addres() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.addres != current.addres,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: widget.userProfile.address,
          errorOccurred: state.addres.invalid,
          errorMessage: 'No ingresar signos ni números',
          icon: Icons.edit,
          lavel: 'Dirección de domicilio',
          inputType: TextInputType.text,
          onChanged: (value) =>
              context.read<ProfileCubit>().addresChanged(value),
        );
      },
    );
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
              Navigator.of(context).pushReplacementNamed('home');
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
              if (!state.status!.isValidated) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                        content: Text('Debe llenar todos los campos')),
                  );
              } else {
                context.read<ProfileCubit>().editUserForm(
                    widget.userProfile.id!, widget.userProfile.photoUri ?? '');
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                        content: Text('Datos actualizados correctamente')),
                  );
                final userProfile = new UserProfile(
                  id: widget.userProfile.id,
                  userName: state.userName.value,
                  email: state.email.value,
                  photoUri: widget.userProfile.photoUri,
                  lastName: state.lastName.value,
                  address: state.addres.value,
                  phone: state.phone.value,
                );
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationUserUpdate(userProfile));
                //Navigator.of(context).pop();
              }
            },
          );
        })
      ],
    );
  }
}
