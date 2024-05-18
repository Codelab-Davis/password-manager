import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final Logger _logger = Logger('NetworkService');

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/test/'));
    if (response.statusCode == 200) {
      _logger.info('Data from backend: ${response.body}');
    } else {
      _logger.warning(
          'Failed to fetch data with status code: ${response.statusCode}');
    }
  } catch (e) {
    _logger.severe('Failed to fetch data: $e');
  }
}

postData(String firstName, String lastName, String email, String phoneNumber,
    String password, String signUpType, String TwoFAType) async {
  //Create if conditon for whether or not user is already logged in the data base, to prevent multiple users
  // Using password should work for 3rd party since its a unique code for each new user
  // we can check both email and password for Passpal Logins? Also need to implement only
  // 1 user per email acc
  try {
    print('In PostData');
    var url = Uri.http('localhost:5000', '/test/add');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'signUpType': signUpType,
        'TwoFAType': TwoFAType,
      }),
    );
    print('Response status: ${response.statusCode}'); //Helpful for debugging
    print('Response body: ${response.body}'); //Helpful for debugging
  } catch (e) {
    print(e);
  }
}

Future<void> updateTwoFAType(String email, String twoFAType) async {
  try {
    print('In UpdateData');
    var url = Uri.http('localhost:5000', '/test/update/$email');
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'twoFAType': twoFAType,
      }),
    );
    print('Response status: ${response.statusCode}'); 
    print('Response body: ${response.body}'); 
  } catch (e) {
    print(e);
  }
}
