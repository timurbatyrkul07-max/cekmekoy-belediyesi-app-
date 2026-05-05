class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  ApiException({this.statusCode, required this.message, this.data});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class NetworkException extends ApiException {
  NetworkException({super.message = 'İnternet bağlantısı yok veya zaman aşımı'});
}

class NotFoundException extends ApiException {
  NotFoundException({super.message = 'Aranan kayıt bulunamadı'}) : super(statusCode: 404);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({super.message = 'Yetkilendirme gerekiyor'}) : super(statusCode: 401);
}

class ServerException extends ApiException {
  ServerException({super.statusCode, super.message = 'Sunucu hatası'});
}
