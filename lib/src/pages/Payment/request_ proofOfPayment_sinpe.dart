import 'package:flutter/material.dart';
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
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.red,
                      child: Image.asset(
                        'assets/images/no-image.png',
                        fit: BoxFit.cover,
                      ),
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
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '*Enviar el pago al número 8800-0000',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      color: Colors.black,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: CustomButton(
                    color: ColorsApp.primaryColorBlue,
                    press: () {},
                    text: 'Reservar',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
