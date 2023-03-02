import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iwl/theme/color.dart';

class OutlineBorderTextFormField extends StatefulWidget {
  final FocusNode myFocusNode;
  final TextEditingController tempTextEditingController;
  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool autofocus;
  final int? maxLine;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final Function validation;
  final bool checkOfErrorOnFocusChange;
  final bool? obscureText;
  final List<String>? autofillHints;
  final Function? onSubmit;
  final InkWell? suffixIcon;
  final Function? suffixClick;
  @override
  State<StatefulWidget> createState() {
    return _OutlineBorderTextFormField();
  }

  OutlineBorderTextFormField({
    required this.labelText,
    this.hintText,
    required this.autofocus,
    this.maxLine,
    required this.tempTextEditingController,
    required this.myFocusNode,
    required this.inputFormatters,
    required this.keyboardType,
    required this.textInputAction,
    required this.validation,
    required this.checkOfErrorOnFocusChange,
    this.obscureText,
    this.autofillHints,
    this.onSubmit,
    this.suffixIcon,
    this.suffixClick,
  });
}

class _OutlineBorderTextFormField extends State<OutlineBorderTextFormField> {
  bool isError = false;
  String errorString = "";

  getLabelTextStyle(color) {
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: colorGreyText);
  } //label text style

  getTextFieldStyle() {
    return Theme.of(context).textTheme.bodyText1;
  } //textfield style

  getErrorTextFieldStyle() {
    return Theme.of(context).textTheme.bodyText2!.copyWith(color: colorError);
  } // Error text style

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FocusScope(
            child: Focus(
              onFocusChange: (focus) {
                //Called when ever focus changes
                print("focus: $focus");
                setState(() {
                  if (widget.checkOfErrorOnFocusChange &&
                      widget.tempTextEditingController.text.isNotEmpty &&
                      widget.validation(
                              widget.tempTextEditingController.text) !=
                          null) {
                    isError = true;
                    errorString = widget
                        .validation(widget.tempTextEditingController.text);
                  } else {
                    isError = false;
                    errorString = "";
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            10) //                 <--- border radius here
                        ),
                    border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: isError
                          ? colorError
                          : widget.myFocusNode.hasFocus
                              ? colorSecondary
                              : colorGrey,
                    )),
                child: FormBuilderTextField(
                  focusNode: widget.myFocusNode,
                  controller: widget.tempTextEditingController,
                  style: getTextFieldStyle(),
                  obscureText: widget.obscureText ?? false,
                  autofillHints: widget.autofillHints ?? [],
                  autofocus: widget.autofocus,
                  maxLines: widget.maxLine,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  inputFormatters: widget.inputFormatters,
                  validator: (string) {
                    if (widget.validation(string) != null &&
                        widget.validation(string).toString().isNotEmpty) {
                      setState(() {
                        isError = true;
                        errorString = widget.validation(string);
                      });
                      return "";
                    } else {
                      setState(() {
                        isError = false;
                        errorString = "";
                      });
                    }
                    return null;
                  },
                  onSubmitted: (value) {
                    if (widget.onSubmit != null) {
                      widget.onSubmit!();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: widget.labelText ?? null,
                    labelStyle: isError
                        ? getLabelTextStyle(colorError)
                        : getLabelTextStyle(widget.myFocusNode.hasFocus
                            ? colorSecondary
                            : colorGreyText),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    filled: false,
                    hintText: widget.hintText ?? "",
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorStyle: TextStyle(height: 0),
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: widget.suffixIcon ?? null,
                    // hasFloatingPlaceholder: true,
                  ),
                  name: 'email',
                ),
              ),
            ),
          ),
          Visibility(
              visible: isError ? true : false,
              child: Container(
                  padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5),
                  child: Text(
                    errorString,
                    style: getErrorTextFieldStyle(),
                  ))),
        ],
      ),
    );
  }
}
