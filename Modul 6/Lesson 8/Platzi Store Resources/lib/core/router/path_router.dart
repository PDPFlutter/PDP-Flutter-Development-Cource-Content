part of 'app_router.dart';

sealed class Routes {
  static String _appendToCurrentPath(String newPath) {
    final newPathUri = Uri.parse(newPath);
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    Map<String, dynamic> params = Map.of(currentUri.queryParameters);
    params.addAll(newPathUri.queryParameters);
    Uri loc = Uri(path: '${currentUri.path}/${newPathUri.path}'.replaceAll('//', '/'), queryParameters: params);
    return loc.toString();
  }

  static String _replaceToCurrentPath(String newPath, String oldPath) {
    final newUri = Uri.parse(newPath);
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    final oldUri = Uri.parse(oldPath);
    final subUri =
        Uri(pathSegments: currentUri.pathSegments.sublist(0, currentUri.pathSegments.indexOf(oldUri.pathSegments.first)));

    Map<String, Object?> params = Map.of(currentUri.queryParameters);
    params.addAll(newUri.queryParameters);

    Uri loc = Uri(path: '/${subUri.path}/${newUri.path}'.replaceAll('//', '/'), queryParameters: params);
    return loc.toString();
  }

  /// main
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String cart = '/cart';
  static const String favorite = '/favorite';
  static const String profile = '/profile';

  /// other
  static const product = "product/:id";
  static String productWithId(Object id) {
    final currentUri = AppRoute.router.routeInformationProvider.value.uri;
    if (currentUri.path.contains("product")) {
      return _replaceToCurrentPath(
        "product/$id",
        currentUri.path.substring(
          currentUri.path.indexOf("product"),
        ),
      );
    }

    return _appendToCurrentPath('product/$id');
  }

  static const categoryDetail = "detail/:catalogID";
  static String categoryDetailWithId(Object id) => "/catalog/detail/$id";
}
