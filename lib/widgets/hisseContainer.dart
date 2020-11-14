import 'package:flutter/material.dart';

class HisseContainer extends StatelessWidget {
  HisseContainer({this.child,this.widthPayda});
  final Widget child;
  final double widthPayda;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      width: (screenSize.width / widthPayda),
      height: screenSize.height / 10,
      child: child,
    );
  }
}
