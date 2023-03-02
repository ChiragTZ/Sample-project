import 'package:flutter/material.dart';
import 'package:iwl/theme/color.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.margin,
    this.color,
    this.colorBorder,
    this.height,
    this.style,
  }) : super(key: key);

  final String text;
  final Function onPressed;
  final double? height;
  final double? width;
  final TextStyle? style;
  final EdgeInsets? margin;
  final Color? color;
  final Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: width ?? MediaQuery.of(context).size.width * 0.9,
          height: height ?? 45,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(50),
            color: color ?? colorPrimary,
            border: Border.all(color: colorBorder ?? color ?? colorPrimary),
          ),
          child: Center(
            child: Text(
              text,
              style: style ?? Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
