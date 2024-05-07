import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final Logger _logger = Logger('NetworkService');

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5001/test/')); //Change back to 5000
    if (response.statusCode == 200) {
      _logger.info('Data from backend: ${response.body}');
    } else {
      _logger.warning('Failed to fetch data with status code: ${response.statusCode}');
    }
  } catch (e) {
    _logger.severe('Failed to fetch data: $e');
  }
}


postData(String firstName, String lastName, String email, String phoneNumber, String password, String signUpType) async {
  //Create if conditon for whether or not user is already logged in the data base, to prevent multiple users
  // Using password should work for 3rd party since its a unique code for each new user
  // we can check both email and password for Passpal Logins? Also need to implement only
  // 1 user per email acc
  try {
    print('In PostData');
    var url = Uri.http('localhost:5001', '/test/add'); //Change back to 5000
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
      }),
    );
    print('Response status: ${response.statusCode}'); //Helpful for debugging
    print('Response body: ${response.body}'); //Helpful for debugging
  } catch (e) {
    print(e);
  }
}