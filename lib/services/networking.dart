import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url ;

 Future getData() async
  {
    // Response response= await
    Response response = await
    get(Uri.parse(url));
    if (response.statusCode <= 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print('status code = ${response.statusCode}');
    }
  }
}