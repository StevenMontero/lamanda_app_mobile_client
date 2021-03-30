import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_petshopcr/src/blocs/PymentCubit/payment_cubit.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage() : super();

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)!.settings.arguments;
    return BlocProvider(
        create: (context) => PaymentCubit()..serviceChanged(service),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                  size: 25.0,
                ),
                onPressed: () => Navigator.of(context).pop()),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorsApp.primaryColorDark,
            title: Text(
              "Pago",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          body: Body(),
        ));
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'Seleccione el método de pago',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24.0,
              letterSpacing: 0.25,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                  title: Text('Efectivo'),
                  leading: Image.asset(
                    'assets/images/cash_icon_147027.png',
                    width: 56,
                    height: 56,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: ColorsApp.primaryColorBlue),
                  onTap: () {
                    context.read<PaymentCubit>().summitReservation();
                    _showDialog(context);
                  }),
              Divider(),
              ListTile(
                  title: Text('Sinpe'),
                  leading: Image.asset(
                    'assets/images/sinpe-movil-2.png',
                    width: 56,
                    height: 56,
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: ColorsApp.primaryColorBlue),
                  onTap: () {
                    Navigator.of(context).pushNamed('proofSinpe');
                  })
            ],
          ),
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
            "assets/images/checklist.png",
            height: 110.0,
            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            '¡Reservación exitosa!',
            style: _txtCustomHead,
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            'Pronto nos comunicaremos \n para confirmar la reservación',
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
                onPressed: () => Navigator.of(ctx).pushReplacementNamed('home'),
                child: Text('Listo')),
          ),
        )
      ],
    ),
  );
}
