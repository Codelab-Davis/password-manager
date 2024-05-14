import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final Logger _logger = Logger('NetworkService');

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/test/')); 
    if (response.statusCode == 200) {
      _logger.info('Data from backend: ${response.body}');
    } else {
      _logger.warning('Failed to fetch data with status code: ${response.statusCode}');
    }
  } catch (e) {
    _logger.severe('Failed to fetch data: $e');
  }
}



update2FA(String userId, String twoFAType) async {
  try {
    print('Updating 2FA Settings');
    var url = Uri.http('localhost:5001', '/update2FAType'); 
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

    if (response.statusCode == 200) {
      print('2FA type updated successfully');
    } else {
      print('Failed to update 2FA type');
    }
  } catch (e) {
    print('Error updating 2FA settings: $e');
  }
}
