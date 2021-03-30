import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lamanda_petshopcr/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/PymentCubit/payment_cubit.dart';
import 'package:lamanda_petshopcr/src/pages/mainpage.dart';
import 'package:lamanda_petshopcr/src/repository/daycare_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/esthetic_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/hotel_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/repository/veterinary_appointment_repositorydb.dart';
import 'package:lamanda_petshopcr/src/routes/routes.dart';
import 'package:lamanda_petshopcr/src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Obliga  a la aplicacion a solo funcionar en portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider<PaymentCubit>(
            create: (context) => PaymentCubit(
                esteticRepo: StheticAppointmentRepository(),
                hotelRepo: HotelAppointmentRepository(),
                dayCareRepo: DaycareAppointmentRepository(),
                veterinaryRepo: VeterinaryAppointmentRepository()),
          )
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'La Manada',
      routes: getRoutesApp(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                state.userProfile!.isAnyDataEmpty
                    ? _navigator?.pushReplacementNamed('editProfile')
                    : _navigator?.pushReplacementNamed('homepage');
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator?.pushReplacementNamed('choseLogOSig');
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => MainScreen()),
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
    );
  }
}
