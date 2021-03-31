import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactInfo extends StatefulWidget {
  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
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
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 26),
              _developer1(),
              SizedBox(height: 26),
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
        Image.asset('assets/images/no-image.png',
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
                  style: TextStyle(fontSize: 30),
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
                    IconTile(
                      backColor: Color(0xffFFECDD),
                      imgAssetPath: "assets/icons/email.png",
                    ),
                    IconTile(
                      backColor: Color(0xffFEF2F0),
                      imgAssetPath: "assets/icons/call.png",
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
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.left,
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
                          color: Colors.black87.withOpacity(0.7), fontSize: 20),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          "House # 2, Road # 5, Green Road Dhanmondi, Dhaka, Bangladesh",
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
                Icon(Icons.schedule),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Horario",
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.7), fontSize: 20),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 268,
                        child: Text(
                          '''Monday - Friday Open till 7 Pm''',
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
    return Container(
        child: Stack(
      children: [
        SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.only(left: 46.0),
          height: 124.0,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    color: Colors.black12,
                    offset: new Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
          child: Text(
            'Jose Daniel Murillo Portuguez' + ' jose.murillo@ucrso.info',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        developerImageDaniel,
      ],
    ));
  }

  Widget _developer2() {
    return Container(
        child: Stack(
      children: [
        SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.only(left: 46.0),
          height: 124.0,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    color: Colors.black12,
                    offset: new Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
          child: Text(
            'Steven Gerardo Montero Muñoz' + ' stevenmontero247@gmail.com',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        developerImageSteven,
      ],
    ));
  }

  final developerImageDaniel = new Container(
    height: 92.0,
    width: 92.0,
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: CircleAvatar(
      radius: 55,
      backgroundImage: AssetImage('assets/images/Daniel.jpeg'),
    ),
  );

  final developerImageSteven = new Container(
    height: 92.0,
    width: 92.0,
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: CircleAvatar(
      radius: 55,
      backgroundImage: AssetImage('assets/images/Steven.jpeg'),
    ),
  );
}

class IconTile extends StatelessWidget {
  final String? imgAssetPath;
  final Color? backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath!,
          width: 20,
        ),
      ),
    );
  }
}
