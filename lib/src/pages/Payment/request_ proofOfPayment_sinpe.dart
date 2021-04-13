import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamanda_petshopcr/src/blocs/PymentCubit/payment_cubit.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';
import 'package:lamanda_petshopcr/src/widgets/custom_button.dart';

class ProofPaymentSinpePage extends StatelessWidget {
  const ProofPaymentSinpePage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Comprobante de pago",
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Foto del comprobante del pago ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                letterSpacing: 0.15,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Stack(children: [
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return state.proofPhoto == null
                            ? Container(
                                height: 200,
                                width: 300,
                                color: Colors.red,
                                child: Image.asset(
                                  'assets/images/no-image.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 300,
                                color: Colors.red,
                                child: Image(
                                  image: FileImage(state.proofPhoto!),
                                  fit: BoxFit.cover,
                                ));
                      },
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: MaterialButton(
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 50,
                          ),
                          onPressed: () {
                            _selectImage(context);
                          },
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '*Enviar el pago al número 8778-3087 \n Valido para Costa Rica',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Colors.black,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: CustomButton(
                        color: ColorsApp.primaryColorBlue,
                        press: state.proofPhoto != null
                            ? () {
                                context
                                    .read<PaymentCubit>()
                                    .summitReservation();
                                _showDialog(context);
                              }
                            : null,
                        text: 'Reservar',
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
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
                      BlocProvider.of<PaymentCubit>(_contxt)
                        ..filePhotoChange(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      BlocProvider.of<PaymentCubit>(_contxt)
                        ..filePhotoChange(ImageSource.camera);
                      Navigator.of(context).pop();
                    }),
              ],
            )),
          );
        });
  }
}

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
          padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
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
