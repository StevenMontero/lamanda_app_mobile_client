import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/PetCubit/pet_cubit.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import '../../theme/colors.dart';

class PetListPage extends StatefulWidget {
  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetListPage> {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return BlocProvider(
      create: (context) => PetCubit(PetRepository())..getPets(user.id),
      child: Scaffold(
          appBar: _titlePage(context) as PreferredSizeWidget?,
          body: BlocBuilder<PetCubit, PetState>(builder: (_, state) {
            return _body(context);
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, size: 40.0),
            backgroundColor: ColorsApp.secondaryColorlightPurple,
            onPressed: () => Navigator.pushNamed(context, 'petForm'),
          )),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Expanded(
            child: _showProducts(context),
          ),
        ],
      ),
    );
  }

  Widget _showProducts(BuildContext context) {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.petList != current.petList,
      builder: (context, state) {
        if (state.petList != null) {
          if (state.petList == []) {
            return Center(
              child: Text(
                'Presione el boton \'+\' para agregar una mascota',
                style: TextStyle(color: ColorsApp.textPrimaryColor),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.petList!.length,
              itemBuilder: (context, i) => _cardPet(context, state.petList![i]),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _cardPet(BuildContext context, Pet pet) {
    String age = ('${pet.age}');

    return Card(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: (pet.photoUrl == null)
                ? Image(
                    image: AssetImage('assets/images/no-image.png'),
                    height: 100,
                    width: 100,
                  )
                : Image(
                    image: NetworkImage(pet.photoUrl!),
                    height: 100,
                    width: 100,
                  ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ' + pet.name!,
                  style: TextStyle(
                      color: ColorsApp.primaryColorBlue, fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Raza: ' + pet.breed!,
                  style: TextStyle(
                    color: ColorsApp.primaryColorBlue,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Edad: ' + age,
                  style: TextStyle(
                    color: ColorsApp.primaryColorBlue,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Pelaje: ' + pet.fur!,
                  style: TextStyle(
                    color: ColorsApp.primaryColorBlue,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titlePage(context) {
    return AppBar(
      leading: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      centerTitle: true,
      title: SafeArea(
        child: Container(
          child: SvgPicture.asset(
            'assets/images/Logo_COLOR.svg',
            height: 45,
            width: 60,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
