enum RequestMethod { get, post, put, patch, delete }

sealed class Apis {
  static const String _developmentBaseUrl = "api.escuelajs.co";
  static const String _testBaseUrl = "api.escuelajs.co";
  static const String _productionBaseUrl = "api.escuelajs.co";

  static String get baseUrl {
    if (kReleaseMode) {
      return _productionBaseUrl;
    } else if (kProfileMode) {
      return _testBaseUrl;
    } else {
      return _developmentBaseUrl;
    }
  }

  static const headers = {'Content-type': 'application/json'};

  static const products = "/api/v1/products";
  static const categories = "/api/v1/categories";
  static const users = "/api/v1/users";
  static const isAvailable = "/api/v1/users/is-available";
  static const login = "/api/v1/auth/login";
  static const profile = "/api/v1/auth/profile";
  static const refreshToken = "/api/v1/auth/refresh-token";
  static const fileUpload = "/api/v1/files/upload";

  static String productsByCategory(int categoryID)
    => "/api/v1/categories/$categoryID/products";
  static String getFile(String fileName) => "/api/v1/files/$fileName";
}

sealed class Network {
  static Future<String?> request({
    required String api,
    Object? id,
    RequestMethod method = RequestMethod.get,
    Map<String, Object?>? data,
    Map<String, String> headers = Apis.headers,
    Map<String, String>? queryParams,
  }) async {
    final url = Uri.https(Apis.baseUrl, "$api${id != null ? "/$id" : ""}", queryParams);
    final String body = jsonEncode(data);

    final response = await switch (method) {
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
}
