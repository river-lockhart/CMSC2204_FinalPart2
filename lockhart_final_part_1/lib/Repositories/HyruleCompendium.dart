import 'package:dio/dio.dart';

const String BaseUrl = "https://botw-compendium.herokuapp.com/api/v3";

class HyruleCompendium {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchItems() async {
    try {
      final response = await _dio.get("$BaseUrl/compendium/all");

      if (response.statusCode == 200) {
        return List<dynamic>.from(response.data['data']);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (error) {
      print(error);
      throw Exception('Error: $error');
    }
  }

  Future<Map<String, dynamic>> fetchItemDetails(int itemId) async {
    try {
      final response = await _dio.get("$BaseUrl/compendium/entry/$itemId");

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data['data']);
      } else {
        throw Exception('Failed to load item details');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
