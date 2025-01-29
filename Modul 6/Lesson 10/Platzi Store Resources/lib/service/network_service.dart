import 'dart:convert';
import 'package:flutter/foundation.dart' hide Category;
import 'package:http/http.dart';
import '../models/file/attachment.dart';
import '../core/router/app_router.dart';
import '../models/category/category.dart';
import '../models/product/product.dart';
import '../models/token/token.dart';
import '../models/user/user.dart';
import 'local_service.dart';

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
  static const headersForUpload = {'Content-type': 'multipart/form-data'};

  static Map<String, String> headersForAuth(String accessToken) => {'Authorization': 'Bearer $accessToken'};

  static const products = "/api/v1/products";
  static const categories = "/api/v1/categories";
  static const users = "/api/v1/users";
  static const isAvailable = "/api/v1/users/is-available";
  static const login = "/api/v1/auth/login";
  static const profile = "/api/v1/auth/profile";
  static const refreshToken = "/api/v1/auth/refresh-token";
  static const fileUpload = "/api/v1/files/upload";

  static String productsByCategory(Object categoryID) => "/api/v1/categories/$categoryID/products";

  static String getFile(String fileName) => "/api/v1/files/$fileName";

  // query
  static Map<String, String> paginationProduct(int offset, int limit) => {
        "offset": offset.toString(),
        "limit": limit.toString(),
      };

  static Map<String, String> searchProduct(String title) => {"title": title};

  // body
  static Map<String, Object?> dataRefreshToken(String? refreshToken) => {"refreshToken": refreshToken};
}

sealed class Network {
  static Future<String?> request({
    required String api,
    Object? id,
    RequestMethod method = RequestMethod.get,
    bool useToken = false,
    Map<String, Object?>? data,
    Map<String, String> headers = Apis.headers,
    Map<String, String>? queryParams,
  }) async {
    final url = Uri.https(Apis.baseUrl, "$api${id != null ? "/$id" : ""}", queryParams);
    final String body = jsonEncode(data);

    if (useToken) {
      final accessToken = await TokenService.accessToken;
      if (accessToken != null) {
        headers = Map<String, String>.of(Apis.headers)..addAll(Apis.headersForAuth(accessToken));
      }
    }

    final response = await switch (method) {
      RequestMethod.get => get(url, headers: headers),
      RequestMethod.post => post(url, headers: headers, body: body),
      RequestMethod.put => put(url, headers: headers, body: body),
      RequestMethod.patch => patch(url, headers: headers, body: body),
      RequestMethod.delete => delete(url, headers: headers),
    };

    if (response.statusCode == 200 || response.statusCode == 201) {
      return utf8.decoder.convert(response.bodyBytes);
    } else if (response.statusCode == 401) {
      final result = await _refreshTokens();
      if (result) {
        return request(
            api: api, id: id, method: method, queryParams: queryParams, useToken: useToken, data: data, headers: headers);
      }
    }

    return null;
  }

  static Future<bool> _refreshTokens() async {
    final refreshToken = await TokenService.refreshToken;
    final url = Uri.https(Apis.baseUrl, Apis.refreshToken);
    final response = await post(url, body: jsonEncode(Apis.dataRefreshToken(refreshToken)), headers: Apis.headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = utf8.decoder.convert(response.bodyBytes);
      await TokenService.saveTokens(token: parseToken(data));
      return true;
    } else if (response.statusCode == 401) {
      await TokenService.deleteTokens();
      AppRoute.router.go(Routes.login);
    }
    return false;
  }

  static Future<String?> uploadFile(String path) async {
    final url = Uri.https(Apis.baseUrl, Apis.fileUpload);
    final multiPartFile = await MultipartFile.fromPath('file', path);

    final request = MultipartRequest(RequestMethod.post.name, url);
    request.files.add(multiPartFile);
    request.headers.addAll(Apis.headersForUpload);

    final StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      return await response.stream.bytesToString();
    }
    return null;
  }

  static List<Product> parseProductList(String data) {
    final jsonList = jsonDecode(data) as List;
    return jsonList.map((item) => Product.fromJson(item)).toList();
  }

  static Product parseProduct(String data) {
    final json = jsonDecode(data);
    return Product.fromJson(json);
  }

  static List<Category> parseCategoryList(String data) {
    final jsonList = jsonDecode(data) as List;
    return jsonList.map((item) => Category.fromJson(item)).toList();
  }

  static Attachment parseAttachment(String data) {
    final json = jsonDecode(data);
    return Attachment.fromJson(json);
  }

  static User parseUser(String data) {
    final json = jsonDecode(data);
    return User.fromJson(json);
  }

  static Token parseToken(String data) {
    final json = jsonDecode(data);
    return Token.fromJson(json);
  }

  static bool isAvailable(String data) {
    final json = jsonDecode(data);
    return json["isAvailable"] ?? false;
  }
}
