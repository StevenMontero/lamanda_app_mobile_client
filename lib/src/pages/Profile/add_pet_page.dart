import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/PetCubit/pet_cubit.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class PetFormPage extends StatefulWidget {
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  Pet _pet = new Pet();
  File? _photo;
  final picker = ImagePicker();

  bool _isCastrated = false;
  bool _isSociable = false;
  bool _isVacunas = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PetCubit(PetRepository()),
        child: Scaffold(
          appBar: _titlePage() as PreferredSizeWidget?,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  _viewPhoto(),
                  SizedBox(height: 20.0),
                  _petName(),
                  SizedBox(height: 20.0),
                  _petBreed(),
                  SizedBox(height: 20.0),
                  _petAge(),
                  SizedBox(height: 20.0),
                  _petFur(),
                  SizedBox(height: 20.0),
                  buildOptionsSwitch(),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      _submitButton(),
                    ],
                  ),
                ],
              )),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorsApp.primaryColorBlue,
            child: Icon(Icons.add_a_photo),
            onPressed: () => _selectImage(),
          ),
        ));
  }

  Widget _titlePage() {
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

  Widget _viewPhoto() {
    if (_pet.photoUrl != null) {
      return Image(
        image: NetworkImage(_pet.photoUrl!),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(_photo?.path ?? 'assets/images/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _petName() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: '',
          decoration: InputDecoration(
              labelText: 'Nombre De Mi Mascota',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onChanged: (value) => context.read<PetCubit>().nameChanged(value),
          validator: (value) {
            if (value!.length < 1) {
              return 'Digite el nombre de la mascota';
            } else {
              return null;
            }
          },
        );
      },
    );
  }

  Widget _petBreed() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.breed != current.breed,
      builder: (context, state) {
        return TextFormField(
          initialValue: '',
          decoration: InputDecoration(
              labelText: 'Raza De Mi Mascota',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onChanged: (value) => context.read<PetCubit>().breedChanged(value),
          validator: (value) {
            if (value!.length < 1) {
              return 'Digite la raza de la mascota';
            } else {
              return null;
            }
          },
        );
      },
    );
  }

  Widget _petAge() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
              labelText: 'Edad De Mi Mascota',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              context.read<PetCubit>().ageChanged(int.parse(value)),
        );
      },
    );
  }

  Widget _petFur() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.fur != current.fur,
      builder: (context, state) {
        return TextFormField(
          initialValue: '',
          decoration: InputDecoration(
              labelText:
                  'Pelaje De Mi Mascota',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onChanged: (value) => context.read<PetCubit>().furChanged(value),
          validator: (value) {
            if (value!.length < 1) {
              return 'Digite el tipo de pelaje de la mascota';
            } else {
              return null;
            }
          },
        );
      },
    );
  }

  Widget buildOptionsSwitch() {
    return Column(
      children: [
        BlocBuilder<PetCubit, PetState>(builder: (context, state) {
          return SwitchListTile(
            title: Text('Vacunas al dia'),
            activeColor: ColorsApp.secondaryColorlightPurple,
            value: _isVacunas,
            onChanged: (value) {
              setState(() {
                _isVacunas = value;
                context.read<PetCubit>().isVaccinationUpDateChanged(value);
              });
            },
          );
        }),
        BlocBuilder<PetCubit, PetState>(builder: (context, state) {
          return SwitchListTile(
            title: Text('Castrado'),
            activeColor: ColorsApp.secondaryColorlightPurple,
            value: _isCastrated,
            onChanged: (value) {
              setState(() {
                _isCastrated = value;
                context.read<PetCubit>().isCastratedDateChanged(value);
              });
            },
          );
        }),
        BlocBuilder<PetCubit, PetState>(builder: (context, state) {
          return SwitchListTile(
            title: Text('Sociable'),
            activeColor: ColorsApp.secondaryColorlightPurple,
            value: _isSociable,
            onChanged: (value) {
              setState(() {
                _isSociable = value;
                context.read<PetCubit>().isSociableChanged(value);
              });
            },
          );
        })
      ],
    );
  }

  Widget _submitButton() {
    return BlocBuilder<PetCubit, PetState>(builder: (context, state) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.all(15.0),
            primary: ColorsApp.primaryColorBlue,
            textStyle: TextStyle(
              color: Colors.white,
            )),
        onPressed: () {
          final user = BlocProvider.of<AuthenticationBloc>(context).state.user;
          context.read<PetCubit>().addPetForm(user.id);
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.save),
        label: Text('Guardar'),
      );
    });
  }

  Future<void> _selectImage() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Seleccione el medio"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () => _selectPhoto(ImageSource.gallery),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Cámara"),
                    onTap: () => _selectPhoto(ImageSource.camera),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _selectPhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 70);
    setState(() {
      if (pickedFile != null) {
        //product.photoUrl = null;
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
