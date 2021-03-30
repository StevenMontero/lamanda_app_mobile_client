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
        Image.asset(
          'assets/images/no-image.png',
          height: 200,
          width: 150,
          fit: BoxFit.cover
        ),
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
                  style: TextStyle(fontSize: 18, color: Colors.grey),
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
    return Container();
  }
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
