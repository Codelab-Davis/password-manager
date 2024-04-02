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
