import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension RemoveAllWhiteSpace on String {
  String removeAllWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }
}

extension FormatAndConvertToDateString on String {
  String formatAndConvertToDateString() {
    final String val = this;
    // Check if the string is empty or null
    if (val.isEmpty) {
      return "Invalid date";
    }

    try {
      // Parse the string into a DateTime object
      DateTime formattedDateTime =
          DateFormat("M/d/yyyy hh:mm:ss a").parse(this);

      // Format the DateTime object into the desired string format
      String expectedDateString =
          DateFormat("dd/MMM/yyyy hh:mm a").format(formattedDateTime);

      return expectedDateString;
    } catch (e) {
      return "Invalid date";
    }
  }
}

extension ReadFromGetStorage on String {
  Future<String> readFromGetStorage() async {
    String value = "";
    var result = await GetStorage().read(this);
    if (result != null) {
      value = result;
    }
    return value;
  }
}

extension ReadListFromGetStorage on String {
  Future<List<dynamic>> readJsonListFromGetStorage() async {
    List<dynamic> jsonList = [];
    var jsonString = await GetStorage().read(this);
    if (jsonString != null && jsonString.isNotEmpty) {
      jsonList = jsonDecode(jsonString);
    }
    return jsonList;
  }
}

extension SaveToGetStorage on String {
  Future<void> saveToGetStorage({required String key}) async {
    return await GetStorage().write(key, this);
  }
}
