part of 'services.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class Request {
  static Future<http.Response> sendRequest(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('${Environment.serverUrl}$url');
    final headers = {
      'Content-Type': 'application/json',
    };
    switch (method) {
      case RequestType.get:
        return await http.get(uri, headers: headers);
      case RequestType.post:
        return await http.post(uri, headers: headers, body: jsonEncode(body));
      case RequestType.put:
        return await http.put(uri, headers: headers, body: jsonEncode(body));
      case RequestType.delete:
        return await http.delete(uri, headers: headers);
    }
  }

  static Future<http.Response?> sendRequestWithToken(
    RequestType method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    /* final token = await KeyValueStorageServiceImpl().getValue<String>('token'); */
    final headers = {
      'Content-Type': 'application/json',
      /* 'Authorization': 'Bearer $token', */
    };

    Uri uri;
    if (url.contains('http')) {
      uri = Uri.parse(url);
    } else {
      uri = Uri.parse('${Environment.serverUrl}/$url');
    }
    late http.Response res;
    switch (method) {
      case RequestType.get:
        res = await http.get(uri, headers: headers);
        break;
      case RequestType.post:
        res = await http.post(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.put:
        res = await http.put(uri, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.delete:
        res = await http.delete(uri, headers: headers);
    }
    return res;
  }
}
