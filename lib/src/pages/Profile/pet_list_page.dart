import '../../theme/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/blocs/PetCubit/pet_cubit.dart';
import 'package:lamanda_petshopcr/src/pages/Profile/edit_pet_page.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';

class PetListPage extends StatefulWidget {
  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetListPage> {
  @override
  Widget build(BuildContext context) {
    List<Pet> _pets = context
        .read<AuthenticationBloc>()
        .state
        .petList; // Se jala la lista de mascotas
    return BlocProvider(
      create: (context) => PetCubit(PetRepository()),
      child: Scaffold(
          appBar: _titlePage(context) as PreferredSizeWidget?,
          body: _body(context, _pets),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, size: 40.0),
            backgroundColor: ColorsApp.secondaryColorlightPurple,
            onPressed: () => Navigator.pushNamed(context, 'petForm'),
          )),
    );
  }

  Widget _body(BuildContext context, List<Pet> pets) {
    return Container(
      child: Column(
        children: [
          Divider(),
          Expanded(
            child: _showPets(context, pets),
          ),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  Widget _showPets(BuildContext context, List<Pet>? pets) {
    if (pets != null) {
      if (pets.length == 0) {
        return Center(
          child: Text(
            'Presione el boton \'+\' para agregar una mascota',
            style: TextStyle(color: ColorsApp.textPrimaryColor),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, i) => _cardPet(context, pets, i),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _cardPet(BuildContext context, List<Pet> pets, int index) {
    return Card(
      margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0, top: 15),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.art_track_outlined,
              size: 40,
            ),
            title: Text(pets[index].name!, style: TextStyle(fontSize: 20.0)),
            subtitle: Text('Datos de mi mascota'),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: (pets[index].photoUrl == null)
                ? Image(
                    image: AssetImage('assets/images/no-image.png'),
                    height: 250.0,
                    width: 350,
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: NetworkImage(pets[index].photoUrl!),
                    height: 250.0,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
          ),
          ButtonTheme(
              child: ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditPetPage(pets, index)));
                },
                child: Text('Ver y Editar'),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: ColorsApp.secondaryColorlightPurple),
              ),
              BlocBuilder<PetCubit, PetState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      context.read<PetCubit>().deletePet(pets[index].petId!);
                      context.read<AuthenticationBloc>()
                          .add(AuthenticationPetDelete(pets[index]));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Eliminación Exitosa')),
                        );
                      Navigator.of(context).pushNamed('profile');
                    },
                    child: Text('Borrar'),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: ColorsApp.secondaryColorlightPurple),
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _titlePage(context) {
    return AppBar(
      leading: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
