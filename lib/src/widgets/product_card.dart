import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamanda_petshopcr/src/models/product.dart';
import 'package:lamanda_petshopcr/src/theme/colors.dart';

class ProductCard extends StatelessWidget {
  final Product? item;
  final Function? onTab;
  ProductCard({this.item, this.onTab});

  @override
  Widget build(BuildContext context) {
    var networkImage = FadeInImage.assetNetwork(
      image: item!.photoUrl!,
      placeholder: 'assets/images/Dual Ball-1s-200px.gif',
      fit: BoxFit.cover,
    );
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: onTab as void Function()?,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
                )
              ]),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 160.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: item!.codeProduct!,
                          child: Container(
                            height: 185.0,
                            width: 160.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0)),
                            ),
                            child: networkImage,
                          ),
                        ),
                        Container(
                          height: 35.5,
                          width: 55.0,
                          child: RaisedButton(
                              color: ColorsApp.primaryColorBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(5.0))),
                              child: Icon(
                                FontAwesomeIcons.cartPlus,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              onPressed: () => print('1object')),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 7.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        item!.name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: ColorsApp.textPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 1.0)),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 0.0),
                      child: Container(
                        child: Text(
                          '${item!.price} CRC',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                              color: ColorsApp.primaryColorBlue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
