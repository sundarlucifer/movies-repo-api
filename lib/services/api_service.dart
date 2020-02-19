import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_repo/models/movie.dart';

class APIService {
  APIService._instantiate();

  static final instance = APIService._instantiate();

  final String _baseUrl = '127.0.0.1:5050';

  Future<Movie> searchMovie(String title) async {
    Map<String, String> parameters = {
      'title': title,
    };

    Uri uri = Uri.http(
      _baseUrl,
      '/movies/search',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    print('sending');
    var response;
    try{
      response = http.get('http://127.0.0.1:5000/movies/search?title=matrix');
    }catch(e){
      print(e);
    }
    print(response.body);
    print('got');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['movie'];
      return Movie.fromMap(data);
    } else {
      throw json.decode(response.body)['message'];
    }
  }
}
