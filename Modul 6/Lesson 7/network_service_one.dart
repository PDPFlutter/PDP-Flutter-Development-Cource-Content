sealed class Network {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  static const apiPost = "/posts";

  static const Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<String?> methodGet({required String api, Object? id}) async {
    Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}");
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }

  static Future<String?> methodDelete({required String api, required Object id}) async {
    Uri url = Uri.https(baseUrl, "$api/$id");
    final response = await delete(url);
    if (response.statusCode == 200) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }

  static Future<String?> methodPost({required String api, required Map<String, Object?> data}) async {
    Uri url = Uri.https(baseUrl, api);
    final response = await post(url, body: jsonEncode(data));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }

  static Future<String?> methodPut({required String api, required Object id, required Map<String, Object?> data}) async {
    Uri url = Uri.https(baseUrl, "$api/$id");
    final response = await put(url, body: jsonEncode(data));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }
}
