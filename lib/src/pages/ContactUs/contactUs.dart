import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final String phone = '+50687783087';
  final String email = 'mailto:esteticayspacaninoconsentido@gmail.com' 
  +'?subject=${Uri.encodeFull('Consulta')}&body=${Uri.encodeFull('')}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage() as PreferredSizeWidget,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 26),
              _infoVet(),
              SizedBox(height: 26),
              _about(),
              SizedBox(height: 26),
              _addres(context),
              SizedBox(height: 26),
              Text(
                'Desarrolladores',
                style: TextStyle(fontSize: 22, color: Colors.black),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              _developer1(),
              SizedBox(height: 5),
              _developer2(),
              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titlePage() {
    return AppBar(
      leading: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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

  Widget _infoVet() {
    return Row(
      children: <Widget>[
        Image.asset('assets/images/local (2).jpeg',
            height: 200, width: 150, fit: BoxFit.cover),
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 222,
          height: 220,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Veterinaria La Manada",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                Text(
                  "Especialistas en mascotas",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.phone),
                      iconSize: 24,
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(phone);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.mail_outlined),
                      iconSize: 24,
                      onPressed: () async {
                        await launch(email);
                      },
                    ),
                  ],
                )
              ]),
        )
      ],
    );
  }

  Widget _about() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Sobre Nosotros',
            style: TextStyle(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          Text(
            'Somos la Veterianaria comprometida con sus mascotas brindando un servicio de calidad y asegurando el bienestar y confort que su mascota se merece',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _addres(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.location_on),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dirección",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          "Nuevo Centro Comercial PLaza San Ramón, antiguas Palmeras",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.schedule_outlined),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Horario",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          'Lunes - Viernes de 10 a 5:30 Pm',
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
        Image.asset("assets/images/Map.jpeg",
            height: 200, width: 180, fit: BoxFit.cover)
      ],
    );
  }

  Widget _developer1() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/Daniel.jpeg'),
            ),
            title: Text('Jose Daniel Murillo Portuguez'),
            subtitle: Text('jose.murillo@ucrso.info'),
          )
        ],
      ),
    );
  }

  Widget _developer2() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/Steven.jpeg'),
            ),
            title: Text('Steven Gerardo Montero Muñoz'),
            subtitle: Text('steven.monteromunoz@ucrso.info'),
          )
        ],
      ),
    );
  }
}
