import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/mainpageCubit/mainpage_cubit.dart';
import 'package:lamanda_petshopcr/src/widgets/BottomNavBar/bottom_navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageCubit(),
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: (index) => context.read<MainPageCubit>().indexChange(index),
      ),
      body: BlocBuilder<MainPageCubit, MainPageState>(
        buildWhen: (previous, current) =>
            current.currenIndex != previous.currenIndex,
        builder: (context, state) {
          return state.bodyPage!;
        },
      ),
    );
  }
}
