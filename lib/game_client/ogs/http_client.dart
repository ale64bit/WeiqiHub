import 'dart:convert';

import 'package:http/http.dart' as http;

/// A thin abstraction over the HTTP client for API calls.
///
/// Handles common patterns like:
/// - Server URL management
/// - CSRF token handling
/// - Common headers
/// - API versioning
/// - JSON encoding/decoding
class HttpClient {
  static const String _userAgent = 'WeiqiHub/1.0';

  final String serverUrl;
  final http.Client _httpClient;
  final int? defaultApiVersion;

  String? _csrfToken;

  HttpClient({
    required this.serverUrl,
    http.Client? httpClient,
    this.defaultApiVersion = 1,
  }) : _httpClient = httpClient ?? http.Client();

  /// Sets the CSRF token for subsequent POST/PUT requests
  void setCsrfToken(String? token) {
    _csrfToken = token;
  }

  /// Gets the current CSRF token
  String? get csrfToken => _csrfToken;

  /// Makes a GET request and returns the parsed JSON response
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final response = await _get(path,
        queryParameters: queryParameters, apiVersion: apiVersion);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Makes a GET request and returns the raw text response
  Future<String> getText(
    String path, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final response = await _get(path,
        queryParameters: queryParameters, apiVersion: apiVersion);
    return response.body;
  }

  /// Makes a GET request and returns the raw HTTP response
  Future<http.Response> _get(
    String path, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final uri = _buildUri(path, queryParameters, apiVersion);

    final response = await _httpClient.get(
      uri,
      headers: _buildHeaders(),
    );

    _checkResponse(response);
    return response;
  }

  /// Makes a POST request with JSON payload and returns the parsed JSON response
  Future<Map<String, dynamic>> postJson(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final response = await _post(path, data,
        queryParameters: queryParameters, apiVersion: apiVersion);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Makes a POST request with JSON payload and returns the raw HTTP response
  Future<http.Response> _post(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final uri = _buildUri(path, queryParameters, apiVersion);

    final response = await _httpClient.post(
      uri,
      headers: _buildHeaders(includeContentType: true, includeCsrf: true),
      body: jsonEncode(data),
    );

    _checkResponse(response);
    return response;
  }

  /// Makes a PUT request with JSON payload and returns the parsed JSON response
  Future<Map<String, dynamic>> putJson(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final response = await _put(path, data,
        queryParameters: queryParameters, apiVersion: apiVersion);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Makes a PUT request with JSON payload and returns the raw HTTP response
  Future<http.Response> _put(
    String path,
    Map<String, dynamic> data, {
    Map<String, String>? queryParameters,
    int? apiVersion,
  }) async {
    final uri = _buildUri(path, queryParameters, apiVersion);

    final response = await _httpClient.put(
      uri,
      headers: _buildHeaders(includeContentType: true, includeCsrf: true),
      body: jsonEncode(data),
    );

    _checkResponse(response);
    return response;
  }

  /// Builds the complete URI for a given path and query parameters
  Uri _buildUri(
      String path, Map<String, String>? queryParameters, int? apiVersion) {
    // Use provided apiVersion, or default, or none
    final version = apiVersion ?? defaultApiVersion;

    String fullPath = version != null
        ? '$serverUrl/api/v$version$path'
        : '$serverUrl/api$path';

    final uri = Uri.parse(fullPath);

    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(queryParameters: queryParameters);
    }

    return uri;
  }

  /// Builds the standard headers for requests
  Map<String, String> _buildHeaders({
    bool includeContentType = false,
    bool includeCsrf = false,
  }) {
    final headers = <String, String>{
      'User-Agent': _userAgent,
    };

    if (includeContentType) {
      headers['Content-Type'] = 'application/json';
    }

    if (includeCsrf && _csrfToken != null) {
      headers['X-CSRFToken'] = _csrfToken!;
    }

    return headers;
  }

  /// Checks the HTTP response and throws an exception for error status codes
  void _checkResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  /// Disposes of the underlying HTTP client
  void dispose() {
    _httpClient.close();
  }
}

/// Exception thrown when an HTTP request fails
class HttpException implements Exception {
  final String message;
  final int statusCode;
  final String responseBody;

  const HttpException(
    this.message, {
    required this.statusCode,
    required this.responseBody,
  });

  @override
  String toString() => 'HttpException: $message';
}
