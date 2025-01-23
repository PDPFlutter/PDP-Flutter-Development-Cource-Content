// lib/core/utils/string_utils.dart

sealed class StringUtils {
  static String extractUrlFromString(String input) {
    if (input.isEmpty) {
      return "";
    }

    String cleanedInput = input.replaceAll(RegExp(r'[\[\]\"]'), '');

    if (!cleanedInput.startsWith('http')) {
      return "";
    }

    return cleanedInput;
  }
}  
