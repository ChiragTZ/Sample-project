import 'package:flutter/material.dart';
import 'package:iwl/theme/color.dart';

class ButtonView1 extends StatelessWidget {
  const ButtonView1({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.margin,
    this.color,
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
            color: color ?? colorTeal50,
          ),
          child: Center(
            child: Text(
              text,
              style: style ??
                  Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: colorTealDark),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
