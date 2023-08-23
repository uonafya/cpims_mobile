import 'dart:convert';

import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpReponseHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 401:
      errorSnackBar(context, json.decode(response.body)['detail']);
      break;
    case 500:
      errorSnackBar(context, json.decode(response.body)['detail']);
  }
}
