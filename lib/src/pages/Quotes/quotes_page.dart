import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/components/quotes_card.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        backgraund(),
        optionsQuotes(context),
        Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: Container(
            height: mediaQueryData.size.height * 0.2,
            width: mediaQueryData.size.width * 0.55,
            child: SvgPicture.asset(
              'assets/images/Logo_COLOR.svg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget optionsQuotes(BuildContext context) {
    final petList = BlocProvider.of<AuthenticationBloc>(context).state.petList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          child: Row(
            children: [
              QuotesCard(
                itemBgColor: ColorsApp.primaryColorBlue,
                itemImg: 'assets/icons/041-grooming.svg',
                itemTextColor: Colors.white,
                itemTitle: 'Estetica',
                onPress: () {
                  petList.isEmpty? _showDialog(context) :Navigator.of(context).pushNamed('grooming');
                },
              ),
              SizedBox(
                width: 10,
              ),
              QuotesCard(
                itemBgColor: ColorsApp.primaryColorOrange,
                itemImg: 'assets/icons/012-kennel.svg',
                itemTextColor: Colors.white,
                itemTitle: 'Hotel',
                onPress: () {
                   petList.isEmpty? _showDialog(context) :Navigator.of(context).pushNamed('hotel');
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: [
              QuotesCard(
                itemBgColor: ColorsApp.primaryColorTurquoise,
                itemImg: 'assets/icons/015-clinic.svg',
                itemTextColor: Colors.white,
                itemTitle: 'Veterinaria',
                onPress: () {
                  petList.isEmpty? _showDialog(context) : Navigator.of(context).pushNamed('nursey');
                },
              ),
              SizedBox(
                width: 10,
              ),
              QuotesCard(
                itemBgColor: ColorsApp.primaryColorPink,
                itemImg: 'assets/icons/020-pet bed.svg',
                itemTextColor: Colors.white,
                itemTitle: 'Guardería',
                onPress: () {
                   petList.isEmpty? _showDialog(context) :Navigator.of(context).pushNamed('kinder');
                },
              )
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget backgraund() {
    return Stack(
      children: [
        Positioned(
          top: 150,
          left: -130,
          child: Container(
              height: 320,
              width: 320,
              child: SvgPicture.asset('assets/icons/circularLightBlue.svg')),
        ),
        Positioned(
          top: 20,
          right: -130,
          child: Container(
              height: 320,
              width: 320,
              child: SvgPicture.asset('assets/icons/circularLightOrange.svg')),
        ),
        Positioned(
          bottom: -110,
          right: -90,
          child: Container(
              height: 300,
              width: 370,
              child: SvgPicture.asset('assets/images/dogvector.svg')),
        ),
      ],
    );
  }
}
// Custom Text Header for Dialog after user succes payment
var _txtCustomHead = TextStyle(
  color: Colors.black54,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Custom Text Description for Dialog after user succes payment
var _txtCustomSub = TextStyle(
  color: Colors.black38,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    builder: (contex) => SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "assets/images/warning.png",
            height: 110.0,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            '¡Atención!',
            style: _txtCustomHead,
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            'No tiene mascotas agregadas aun',
            textAlign: TextAlign.center,
            style: _txtCustomSub,
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0,right: 8.0),
          child: Container(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
                color: ColorsApp.primaryColorBlue,
                textColor: Colors.white,
                onPressed: () => Navigator.of(ctx).pushReplacementNamed('petForm'),
                child: Text('Agregar')),
          ),
        )
      ],
    ),
  );
}
