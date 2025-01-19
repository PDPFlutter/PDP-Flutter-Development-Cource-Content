enum RequestMethod { get, post, put, patch, delete }

sealed class Network {
  static const String baseUrl = "jsonplaceholder.typicode.com";
  static const apiPost = "/posts";

  static const Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static Future<String?> request({
    required String api,
    String? id,
    RequestMethod method = RequestMethod.get,
    Map<String, Object?>? data,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}", queryParams);
    final String body = jsonEncode(data);

    final Response response = await switch (method) {
      RequestMethod.get => get(url, headers: headers),
      RequestMethod.post => post(url, headers: headers, body: body),
      RequestMethod.put => put(url, headers: headers, body: body),
      RequestMethod.patch => patch(url, headers: headers, body: body),
      RequestMethod.delete => delete(url, headers: headers),
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    }
    return null;
  }

  static List<Post> parsePostList(String data) {
    final json = jsonDecode(data) as List; /// String => json(Map, List, ...)
    return json.map((item) => Post.fromJson(item)).toList(); /// json => object
  }

  static Post parsePost(String data) {
    final json = jsonDecode(data);
    return Post.fromJson(json);
  }
}
