import 'package:flutter/material.dart';
import 'package:iwl/theme/color.dart';

class Borders {
  static OutlineInputBorder border = new OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey.withOpacity(0.5), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static OutlineInputBorder focusBlueBorder = new OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey.withOpacity(0.5), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static OutlineInputBorder focusBorder = new OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey.withOpacity(0.5), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static OutlineInputBorder enableBorder = new OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey.withOpacity(0.5), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static OutlineInputBorder disableBorder = new OutlineInputBorder(
    borderSide: BorderSide(color: colorGrey.withOpacity(0.5), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static UnderlineInputBorder borderWhite =
      new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white));

  static UnderlineInputBorder borderGrey =
      new UnderlineInputBorder(borderSide: new BorderSide(color: colorGrey));

  static UnderlineInputBorder focusGrey =
      new UnderlineInputBorder(borderSide: new BorderSide(color: colorGrey));

  static UnderlineInputBorder enableGrey =
      new UnderlineInputBorder(borderSide: new BorderSide(color: colorGrey));

  static UnderlineInputBorder disableGrey =
      new UnderlineInputBorder(borderSide: new BorderSide(color: colorGrey));
}
