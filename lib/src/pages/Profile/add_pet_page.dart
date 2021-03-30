import 'dart:ui';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_petshopcr/src/models/pet.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/textfielform.dart';
import 'package:lamanda_petshopcr/src/blocs/PetCubit/pet_cubit.dart';
import 'package:lamanda_petshopcr/src/repository/pet_repositorydb.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';

class PetFormPage extends StatefulWidget {
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PetCubit(PetRepository()), child: Body());
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
  bool _isCastrated = false;
  bool _isSociable = false;
  bool _isVacunas = false;
  String? dropdownValue;
  String? dropdownValueFur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage() as PreferredSizeWidget?,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
              child: Column(
            children: <Widget>[
              _viewPhoto(),
              SizedBox(height: 20.0),
              _chooseKindPet(),
              SizedBox(height: 20.0),
              _petName(),
              SizedBox(height: 20.0),
              _petBreed(),
              SizedBox(height: 20.0),
              _petAge(),
              SizedBox(height: 20.0),
              _petFur(),
              SizedBox(height: 20.0),
              _petWeigth(),
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
        onPressed: () => _selectImage(context),
      ),
    );
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

  Widget _chooseKindPet() {
    var list = context.read<PetCubit>().getKindPetList();
    dropdownValue = list.elementAt(0).value;
    return BlocBuilder<PetCubit, PetState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 2),
          alignment: Alignment.bottomLeft,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                hint: Text('Tipo de mascota'),
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
                iconSize: 25,
                style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                items: list,
                //value: dropdownValue,
                onChanged: (dynamic value) {
                  dropdownValue = value;
                  context.read<PetCubit>().kindPetChanged(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _viewPhoto() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.photoUrl != current.photoUrl,
      builder: (context, state) {
        if (state.photoUrl != null) {
          return Image(
            image: FileImage(state.photo!),
            height: 300.0,
            fit: BoxFit.cover,
          );
        } else {
          return Image(
            image: AssetImage('assets/images/no-image.png'),
            height: 300.0,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  Widget _petName() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: state.name.value,
          errorOccurred: state.name.invalid,
          errorMessage: 'Ingresar el nombre de su mascota',
          icon: Icons.edit_outlined,
          lavel: 'Nombre de mi Mascota',
          inputType: TextInputType.text,
          onChanged: (value) => context.read<PetCubit>().nameChanged(value),
        );
      },
    );
  }

  Widget _petBreed() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.breed != current.breed,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: state.breed.value,
          errorOccurred: state.breed.invalid,
          errorMessage: ' Ingresar la raza de su mascota',
          icon: Icons.edit_outlined,
          lavel: 'Raza de mi Mascota',
          inputType: TextInputType.text,
          onChanged: (value) => context.read<PetCubit>().breedChanged(value),
        );
      },
    );
  }

  Widget _petAge() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: state.age.value,
          errorOccurred: state.age.invalid,
          errorMessage: 'Ingresar la edad de su mascota. Ej: 7',
          icon: Icons.edit_outlined,
          lavel: 'Edad de mi Mascota',
          inputType: TextInputType.number,
          onChanged: (value) => context.read<PetCubit>().ageChanged(value),
        );
      },
    );
  }

  Widget _petFur() {
    var list = context.read<PetCubit>().getfurList();
    dropdownValueFur = list.elementAt(0).value;
    return BlocBuilder<PetCubit, PetState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 2),
          alignment: Alignment.bottomLeft,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                hint: Text('Pelaje de su mascota'),
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
                iconSize: 25,
                style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                items: list,
                //value: dropdownValueFur,
                onChanged: (dynamic value) {
                  dropdownValueFur = value;
                  context.read<PetCubit>().furChanged(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _petWeigth() {
    return BlocBuilder<PetCubit, PetState>(
      buildWhen: (previous, current) => previous.weigth != current.weigth,
      builder: (context, state) {
        return TextFieldForm(
          initialValue: state.weigth.value,
          errorOccurred: state.weigth.invalid,
          errorMessage: 'Formato Incorrecto. Ej: 2.4 o 2',
          icon: Icons.edit_outlined,
          lavel: 'Peso de mi Mascota',
          inputType: TextInputType.number,
          onChanged: (value) => context.read<PetCubit>().weigthChanged(value),
        );
      },
    );
  }

  Widget buildOptionsSwitch() {
    return Container(
        height: 175.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.blue,
          ),
          child: Column(
            children: [
              BlocBuilder<PetCubit, PetState>(builder: (context, state) {
                return SwitchListTile(
                  title: Text('Vacunas al dia'),
                  activeColor: ColorsApp.secondaryColorlightPurple,
                  value: _isVacunas,
                  onChanged: (value) {
                    setState(() {
                      _isVacunas = value;
                      context
                          .read<PetCubit>()
                          .isVaccinationUpDateChanged(value);
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
          ),
        ));
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
          if (!state.status.isValidated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Debe llenar todos los campos')),
              );
          } else if (state.photo == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Debe agregar foto de su mascota')),
              );
          } else {
            context.read<PetCubit>().addPetForm(user.id);
            final pet = new Pet(
              userId: user.id,
              name: state.name.value,
              breed: state.breed.value,
              age: int.parse(state.age.value),
              fur: state.fur.value,
              kindPet: state.kindPet.value,
              weight: double.parse(state.weigth.value),
              isVaccinationUpDate: state.isVaccinationUpDate,
              castrated: state.isCastrated,
              sociable: state.isSociable,
              photoUrl: state.photoUrl,
            );
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationAddPetUpdate(pet));
            Navigator.of(context).pop();
          }
        },
        icon: Icon(Icons.save),
        label: Text('Guardar'),
      );
    });
  }

  Future<void> _selectImage(BuildContext _contxt) {
    return showDialog(
        context: _contxt,
        builder: (context) {
          return AlertDialog(
            title: Text("Seleccione el medio"),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                    child: Text("Galería"),
                    onTap: () {
                      _contxt.read<PetCubit>()
                        ..filePhotoChange(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      _contxt.read<PetCubit>()
                        ..filePhotoChange(ImageSource.camera);
                      Navigator.of(context).pop();
                    }),
              ],
            )),
          );
        });
  }
}
