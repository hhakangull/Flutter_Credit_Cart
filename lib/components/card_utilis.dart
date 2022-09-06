import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CardUtilities {
  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;
      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && inputData.length != nonZeroIndex) {
        buffer.write("/");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}

class CartUtility {
  String defaultPath = "assets/icons";
  Widget getCardIcon(CreditCardType type) {
    switch (type.name) {
      case "visa":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "amex":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "discover":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "mastercard":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "dinersclub":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "unionpay":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "maestro":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      case "hipercard":
        return SvgPicture.asset("$defaultPath/${type.name}.svg");
      default:
        return const SizedBox();
    }
  }
}
