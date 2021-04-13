import '../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: ColorsApp.secondaryColorlightPurple,
                      width: 500,
                      height: 165,
                    ),
                    buildProfile(user),
                    Padding(
                      padding: const EdgeInsets.only(top: 270.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            height: 0.5,
                          ),
                          MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('petList');
                              },
                              color: Colors.white,
                              minWidth: 100,
                              height: 60,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/pawprint.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Mis Mascotas"),
                                  ),
                                ],
                              )),
                          Divider(
                            height: 0.5,
                          ),
                          MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('contactInfo');
                              },
                              color: Colors.white,
                              minWidth: 100,
                              height: 60,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/aboutapp.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Sobre nosotros"),
                                  ),
                                ],
                              )),
                          Divider(
                            height: 0.5,
                          ),
                          MaterialButton(
                              onPressed: () =>
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationLogoutRequested()),
                              color: Colors.white,
                              minWidth: 100,
                              height: 60,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/logout.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Cerrar Sesión"),
                                  ),
                                ],
                              )),
                          Divider(
                            height: 0.5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  Widget buildProfile(dynamic user) {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage:
                      user.photo.isNotEmpty ? NetworkImage(user.photo) : null,
                  child: user.photo.isEmpty
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(user.name),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorsApp.secondaryColorlightPurple,
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('editProfile');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
