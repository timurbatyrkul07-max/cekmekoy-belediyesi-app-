class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://api.ggtech.co';
  static const String filesPath = '/Files';

  static String fullFileUrl(String? filePath) {
    if (filePath == null || filePath.isEmpty) return '';
    var p = filePath;
    if (p.startsWith('wwwroot/')) p = p.substring('wwwroot/'.length);
    if (!p.startsWith('/')) p = '/$p';
    return '$baseUrl$p';
  }
}
