import 'dart:io';
import 'dart:math';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/api/model/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getBy({String query});
}

class MovieRepositoryImpl extends MovieRepository {

  static const _BASE_URL = 'http://10.0.2.2:8000';
  // static const _BASE_URL = 'http://84.252.135.247';

  Dio _dio;

  static Random random = Random();

  List<String> urls = [
    'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1570824104453-508955ab713e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1548802673-380ab8ebc7b7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1577023311546-cdc07a8454d9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1589883661923-6476cb0ae9f2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1574231164645-d6f0e8553590?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1568043210943-0e8aac4b9734?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1557246565-8a3d3ab5d7f6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNhdHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1548366086-7f1b76106622?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fGNhdHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
  ];
  
  @override
  Future<List<Movie>> getBy({String query}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    _dio.options.headers = headers;
    final response = await _dio.get("/movie", queryParameters: {'query': query});
    final rawMovies = response.data['results'];
    List<Movie> movies = List.empty(growable: true);
    for (int i = 0; i < rawMovies.length; i++) {

      movies.add(Movie.fromJson(rawMovies[i]));
    }
    return movies;
  }

  MovieRepositoryImpl() {
    this._dio = Dio(
      BaseOptions(baseUrl: _BASE_URL),
    );
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}

class FakeMovieRepositoryImpl extends MovieRepository {
  List<String> movies = [
    "1 друг Оушена",
    "2 друга Оушена",
    "3 друга Оушена",
    "4 друга Оушена",
    "5 друзей Оушена",
    "6 друзей Оушена",
    "7 друзей Оушена",
    "8 друзей Оушена",
    "9 друзей Оушена",
    "10 друзей Оушена",
  ];

  List<String> urls = [
    'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1570824104453-508955ab713e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1548802673-380ab8ebc7b7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1577023311546-cdc07a8454d9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1589883661923-6476cb0ae9f2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1574231164645-d6f0e8553590?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1568043210943-0e8aac4b9734?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1557246565-8a3d3ab5d7f6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y2F0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543852786-1cf6624b9987?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNhdHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1548366086-7f1b76106622?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fGNhdHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
  ];


  static const _BASE_URL = 'https://some-random-api.ml';

  static Random random = Random();

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _BASE_URL),
  );


  @override
  Future<List<Movie>> getBy({String query}) async {
    int n = random.nextInt(10);
    movies.shuffle();

    List<Movie> result = List.empty(growable: true);

    for (int i = 0; i < n; i++) {
      // final link = (await _dio.get('/img/cat')).data['link'];
      final link = urls[random.nextInt(urls.length - 1)];
      result.add(Movie(movies[i], link, 1990 + random.nextInt(30), []));
    }
    return result;
  }}