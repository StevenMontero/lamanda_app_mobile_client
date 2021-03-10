import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lamanda_petshopcr/src/pages/Quotes/components/quotes_card.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [backgraund(), optionsQuotes(context)],
    );
  }

  Widget optionsQuotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
          child: Row(
            children: [
              QuotesCard(
                itemBgColor: ColorsApp.primaryColorBlue,
                itemImg: 'assets/icons/041-grooming.svg',
                itemTextColor: Colors.white,
                itemTitle: 'Estetica',
                onPress: () {
                  Navigator.of(context).pushNamed('grooming');
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
                  Navigator.of(context).pushNamed('hotel');
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
                  Navigator.of(context).pushNamed('nursey');
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
                  Navigator.of(context).pushNamed('kinder');
                },
              )
            ],
          ),
        ),
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
          bottom: -115,
          child: Container(
              height: 350,
              width: 470,
              child: SvgPicture.asset('assets/images/dogvector.svg')),
        )
      ],
    );
  }
}
