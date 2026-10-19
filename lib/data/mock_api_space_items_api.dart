import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/entities/space_item.dart';
import 'space_items_api.dart';

const mockApiBaseUrl = 'https://6ad663d4f71f154ac486d0df.mockapi.io';

const _resource = 'items';
const _timeout = Duration(seconds: 15);

class MockApiSpaceItemsApi implements SpaceItemsApi {
  MockApiSpaceItemsApi({this.baseUrl = mockApiBaseUrl, http.Client? client})
    : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  @override
  Future<List<SpaceItem>> fetchItems() {
    return _send(() async {
      final response = await _client
          .get(Uri.parse('$baseUrl/$_resource'))
          .timeout(_timeout);
      _checkStatus(response, 200);
      final data = _decode(response) as List;
      return data
          .map((e) => SpaceItem.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<SpaceItem> createItem(SpaceItem item) {
    return _send(() async {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/$_resource'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(item.toJson()),
          )
          .timeout(_timeout);
      _checkStatus(response, 201);
      return SpaceItem.fromJson(_decode(response) as Map<String, dynamic>);
    });
  }

  void _checkStatus(http.Response response, int expected) {
    if (response.statusCode != expected) {
      throw SpaceItemsApiException(
        'Сервер ответил статусом ${response.statusCode}',
      );
    }
  }

  dynamic _decode(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<T> _send<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on SpaceItemsApiException {
      rethrow;
    } on TimeoutException {
      throw const SpaceItemsApiException('Сервер не ответил вовремя');
    } on http.ClientException {
      throw const SpaceItemsApiException('Нет соединения с сервером');
    } on FormatException {
      throw const SpaceItemsApiException('Некорректный ответ сервера');
    } on TypeError {
      throw const SpaceItemsApiException('Некорректный ответ сервера');
    } on ArgumentError {
      throw const SpaceItemsApiException('Некорректный ответ сервера');
    }
  }
}
