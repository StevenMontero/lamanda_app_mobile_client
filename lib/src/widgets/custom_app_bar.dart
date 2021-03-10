import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget  {
  final String? userPhoto;
  final IconData? leadingIcon;
  final bool withPhoto;

  CustomAppBar({
    this.leadingIcon,
    this.userPhoto,
    this.withPhoto = false,
  });




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: <Widget>[
            leadingIcon != null
                ? InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: AppBar().preferredSize.height + 40,
                      height: AppBar().preferredSize.height,
                      child: Icon(leadingIcon),
                    ),
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    width: AppBar().preferredSize.height + 40,
                    height: AppBar().preferredSize.height,
                    child: SizedBox()),
            Expanded(
                child: Container(
              color: Colors.white,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: SvgPicture.asset(
                'assets/images/Logo_COLOR.svg',
                fit: BoxFit.scaleDown,
              ),
            )),
            Container(
              color: Colors.white,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: withPhoto
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: userPhoto != null
                              ? NetworkImage(userPhoto!)
                              : null,
                          child: userPhoto == null
                              ? const Icon(Icons.person_outline, size: 20)
                              : null,
                        )
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    ));
  }
}
