import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_petshopcr/src/blocs/mainpageCubit/mainpage_cubit.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int index)? onTap;
  BottomNavBar({Key? key, this.onTap}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.0,
      child: BlocBuilder<MainPageCubit, MainPageState>(
        buildWhen: (previous, current) =>
            current.currenIndex != previous.currenIndex,
        builder: (context, state) {
          return BottomNavigationBar(
            items: items,
            selectedItemColor: ColorsApp.primaryColorBlue,
            unselectedItemColor: ColorsApp.secondaryColorlightBlue,
            type: BottomNavigationBarType.fixed,
            onTap: widget.onTap,
            currentIndex: state.currenIndex,
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.solidCalendarPlus, size: 20),
      label: "Citas",
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.solidUser, size: 20),
      label: "Perfil",
    )
  ];
}
