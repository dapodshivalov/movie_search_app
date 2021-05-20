import 'dart:io';
import 'dart:math';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/api/model/movie.dart';
import 'package:movie_search_app/api/model/movie_full.dart';
import 'package:movie_search_app/api/model/person.dart';

abstract class MovieRepository {
  Future<List<Movie>> getBy({String query, bool shouldIncludeReviews});

  Future<MovieFull> getByKpId(int kpId);

  Future<List<Person>> getStaffByKpId(int kpId);
}

class MovieRepositoryImpl extends MovieRepository {

  static const _BASE_URL = 'http://10.0.2.2:5000';
  // static const _BASE_URL = 'http://84.252.135.247';

  Dio _dio;

  static Random random = Random();

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
  
  @override
  Future<List<Movie>> getBy({String query, bool shouldIncludeReviews=false}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    _dio.options.headers = headers;
    _dio.options.baseUrl = _BASE_URL;
    var url = "/movie";
    if (!shouldIncludeReviews) {
      url = "/movie/by_descriptions";
    }
    final response = await _dio.get(url, queryParameters: {'query': query});
    final rawMovies = response.data['results'];
    List<Movie> movies = List.empty(growable: true);
    for (int i = 0; i < rawMovies.length; i++) {
      movies.add(Movie.fromJson(rawMovies[i]));
    }
    return movies;
  }

  @override
  Future<MovieFull> getByKpId(int kpId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    _dio.options.headers = headers;
    _dio.options.baseUrl = _BASE_URL;
    final response = await _dio.get("/movie/" + kpId.toString());
    final rawMovie = response.data;

    return MovieFull.fromJson(rawMovie);
  }

  @override
  Future<List<Person>> getStaffByKpId(int kpId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'X-API-KEY': '3ba5f8cf-eb17-4290-901b-82595735d4ef',
    };
    _dio.options.headers = headers;
    _dio.options.baseUrl = "https://kinopoiskapiunofficial.tech/api/v1";
    final response = await _dio.get('/staff?filmId=$kpId');
    final rawPersons = response.data;

    List<Person> result = List.empty(growable: true);

    for (int i = 0; i < rawPersons.length; i++) {
      result.add(Person.fromJson(rawPersons[i]));
    }

    return result;
  }
}