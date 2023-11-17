import '../../../../config.dart';

class Validation {

  final RegExp regexNum = RegExp(r'^[0-9]*$');
  // Number Validation
  broadCastValidation (number) {
    if (number.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    if(!regexNum.hasMatch(number)){
      return fonts.enterNumberOnly.tr;
    }
    return null;
  }

  // Number Validation
  groupValidation (number) {
    if (number.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    if(!regexNum.hasMatch(number)){
      return fonts.enterNumberOnly.tr;
    }
    return null;
  }

  // Number Validation
  maxContactValidation (number) {
    if (number.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    if(!regexNum.hasMatch(number)){
      return fonts.enterNumberOnly.tr;
    }
    return null;
  }

  // Number Validation
  maxFileValidation (number) {
    if (number.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    if(!regexNum.hasMatch(number)){
      return fonts.enterNumberOnly.tr;
    }
    return null;
  }

  // Number Validation
  maxFileMultiValidation (number) {
    if (number.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    if(!regexNum.hasMatch(number)){
      return fonts.enterNumberOnly.tr;
    }
    return null;
  }

  // Number Validation
  statusValidation (status) {
    if (status.isEmpty) {
      return fonts.pleaseEnterValue.tr;
    }
    return null;
  }

}
