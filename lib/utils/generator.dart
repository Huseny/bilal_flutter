import 'dart:math';

class Generator {
  static String generateEmail(String fullName) {
    String nameWithoutSpaces = fullName.toLowerCase().replaceAll(' ', '');
    String uniqueNumber = DateTime.now().millisecondsSinceEpoch.toString();

    return "$nameWithoutSpaces$uniqueNumber@bilal.medresa";
  }

  static String generatePassword({int length = 6}) {
    const String charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*';
    final Random random = Random();
    final passwordBuffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      final randomIndex = random.nextInt(charset.length);
      passwordBuffer.write(charset[randomIndex]);
    }

    return passwordBuffer.toString();
  }
}
