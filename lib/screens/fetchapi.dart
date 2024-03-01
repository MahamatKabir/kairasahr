import 'dart:convert';
import 'package:http/http.dart' as http;

class YourApi {
  static Future<List<String>> fetchContainerIDs() async {
    // Replace this URL with your actual API endpoint
    final String apiUrl = 'https://example.com/api/containerIDs';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        final List<dynamic> data = json.decode(response.body);

        // Assuming the JSON response is a list of container IDs
        List<String> containerIDs =
            data.map((item) => item.toString()).toList();

        return containerIDs;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load container IDs');
      }
    } catch (e) {
      // If there's an error with the HTTP request, throw an exception
      throw Exception('Failed to load container IDs: $e');
    }
  }
}
