import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/controller/overview_controller.dart';
import 'package:iwl/pages/dashboard/dashboard_tab/overview/model/rewards_response.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/ValidationHelper.dart';
import 'package:iwl/utils/WidgetHelper.dart';
import 'package:iwl/utils/buttons/ButtonView.dart';
import 'package:iwl/utils/common_widget.dart';
import 'package:iwl/utils/outLineBorderTextFormField.dart';

class RewardsClaimPage extends GetView<OverviewController> {
  final OverviewController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetHelper.getHeader(
          context, "Claim ${controller.clickedReward.value.title} Reward"),
      body: SingleChildScrollView(
        padding: mainPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitle(textTheme),
            showLoader(
                child: getItemList(textTheme),
                isLoading: controller.rewards.value.tShirt == null ||
                    controller.rewards.value.books == null),
            SizedBox(height: 10),
            getDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Shipping details',
                style: textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
            shippingForm(textTheme, context),
            getFieldSeparator(height: 30),
            ButtonView(
                onPressed: () {
                  controller.claimReward();
                },
                text: "Submit"),
            getFieldSeparator(height: 30),
          ],
        ),
      ),
    );
  }

  shippingForm(TextTheme textTheme, BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        children: [
          OutlineBorderTextFormField(
            labelText: "Name",
            myFocusNode: controller.nameFocus,
            tempTextEditingController: controller.nameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            validation: (value) =>
                ValidationHelper.checkBlankValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: "Email",
            myFocusNode: controller.emailFocus,
            tempTextEditingController: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofocus: false,
            autofillHints: [
              AutofillHints.email,
            ],
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            validation: (value) =>
                ValidationHelper.checkEmailValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: "Phone",
            myFocusNode: controller.phoneFocus,
            tempTextEditingController: controller.phoneController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            validation: (value) =>
                ValidationHelper.checkBlankValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          OutlineBorderTextFormField(
            labelText: "Address",
            myFocusNode: controller.addressFocus,
            tempTextEditingController: controller.addressController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autofocus: false,
            checkOfErrorOnFocusChange: true,
            inputFormatters: [
              //LengthLimitingTextInputFormatter(18),
            ],
            validation: (value) =>
                ValidationHelper.checkBlankValidation(context, value!),
            // validation: (textToValidate) {
            //   return ValidationHelper.checkEmailValidation();
            // },
          ),
          getFieldSeparator(height: 10),
          Row(children: [
            Expanded(
              child: OutlineBorderTextFormField(
                labelText: "Zip Code",
                myFocusNode: controller.zipFocus,
                tempTextEditingController: controller.zipController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                checkOfErrorOnFocusChange: true,
                inputFormatters: [
                  //LengthLimitingTextInputFormatter(18),
                ],
                validation: (value) =>
                    ValidationHelper.checkBlankValidation(context, value!),
                // validation: (textToValidate) {
                //   return ValidationHelper.checkEmailValidation();
                // },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: OutlineBorderTextFormField(
                labelText: "City",
                myFocusNode: controller.cityFocus,
                tempTextEditingController: controller.cityController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                checkOfErrorOnFocusChange: true,
                inputFormatters: [
                  //LengthLimitingTextInputFormatter(18),
                ],
                validation: (value) =>
                    ValidationHelper.checkBlankValidation(context, value!),
                // validation: (textToValidate) {
                //   return ValidationHelper.checkEmailValidation();
                // },
              ),
            ),
          ]),
          getFieldSeparator(height: 10),
          Row(children: [
            Expanded(
              child: OutlineBorderTextFormField(
                labelText: "State",
                myFocusNode: controller.stateFocus,
                tempTextEditingController: controller.stateController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                checkOfErrorOnFocusChange: true,
                inputFormatters: [
                  //LengthLimitingTextInputFormatter(18),
                ],
                validation: (value) =>
                    ValidationHelper.checkBlankValidation(context, value!),
                // validation: (textToValidate) {
                //   return ValidationHelper.checkEmailValidation();
                // },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedCountry.value = controller
                      .rewards.value.countries!
                      .firstWhere((element) => element.id == 13);
                  // "Australia"
                  // selectedCountry.value = rewards.value.countries!
                  //     .firstWhere((element) => rewards.value.countries[element].);
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200.0,
                          child: CupertinoPicker(
                              itemExtent: 32.0,
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      controller.selectedCountry.value.id! - 1),
                              onSelectedItemChanged: (value) {
                                controller.selectedCountry.value =
                                    controller.rewards.value.countries![value];
                              },
                              children: List<Widget>.generate(
                                  controller.rewards.value.countries!.length,
                                  (int index) {
                                return Center(
                                  child: Text(controller
                                      .rewards.value.countries![index].name
                                      .toString()),
                                );
                              })),
                        );
                      });
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: 60,
                      // margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colorGrey)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.selectedCountry.value.id != null
                                    ? controller.selectedCountry.value.name
                                        .toString()
                                    : "Country",
                                style: textTheme.bodyText1!.copyWith(
                                    color:
                                        controller.selectedCountry.value.id !=
                                                null
                                            ? colorBlack
                                            : colorHint),
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      )),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  getTitle(TextTheme textTheme) {
    if (controller.clickedReward.value.title == "Bronze") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Select book',
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      );
    } else if (controller.clickedReward.value.title == "Silver") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'T-Shirt size',
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Congratulation',
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  getItemList(TextTheme textTheme) {
    if (controller.clickedReward.value.title == "Bronze") {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.rewards.value.books!.length,
        itemBuilder: (context, index) {
          return getBookItem(controller.rewards.value.books![index], textTheme);
        },
      );
    } else if (controller.clickedReward.value.title == "Silver") {
      return Wrap(
        spacing: 20,
        direction: Axis.horizontal,
        children: [
          for (var item in controller.rewards.value.tShirt!)
            getTShirtItem(item, textTheme),
        ],
      );
    } else {
      return Container(
        height: 10,
      );
    }
  }

  getBookItem(Books book, TextTheme textTheme) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          controller.selectedBooks.value = book;
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Container(
                height: 25.0,
                width: 25.0,
                padding: EdgeInsets.all(7),
                child: CircleAvatar(backgroundColor: colorWhite),
                decoration: new BoxDecoration(
                  color: controller.selectedBooks.value.id == book.id
                      ? colorSecondary
                      : Colors.transparent,
                  border: new Border.all(
                      width: 1.0,
                      color: controller.selectedBooks.value.id == book.id
                          ? colorSecondary
                          : colorNeutral60),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(50.0)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: new EdgeInsets.only(left: 10.0),
                child: new Text(
                  book.name.toString(),
                  style: textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTShirtItem(TShirt tShirt, TextTheme textTheme) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          controller.selectedTShirt.value = tShirt;
        },
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(
              () => Container(
                height: 25.0,
                width: 25.0,
                padding: EdgeInsets.all(7),
                child: CircleAvatar(backgroundColor: colorWhite),
                decoration: new BoxDecoration(
                  color: controller.selectedTShirt.value.id == tShirt.id
                      ? colorSecondary
                      : Colors.transparent,
                  border: new Border.all(
                      width: 1.0,
                      color: controller.selectedTShirt.value.id == tShirt.id
                          ? colorSecondary
                          : colorNeutral60),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(50.0)),
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(left: 10.0),
              child: new Text(
                tShirt.name.toString(),
                style: textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
