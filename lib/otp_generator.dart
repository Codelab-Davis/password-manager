import 'package:otp/otp.dart';
import 'package:timezone/timezone.dart' as timezone;

String generateOTP() {
  final now = DateTime.now();
  final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
  final date = timezone.TZDateTime.from(now, pacificTimeZone);
  return OTP.generateTOTPCodeString('ISHANT', date.millisecondsSinceEpoch, 
  length: 6, interval: 5, algorithm: Algorithm.SHA256, isGoogle: true);
}
