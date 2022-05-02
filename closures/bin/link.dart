void main() {
  final httpsScheme = getLinkCreator('https://');
  final httpsCom = httpsScheme('.com');
  final httpsRu = httpsScheme('.ru');

  print(httpsRu('rutube'));
  print(httpsRu('mail'));
  print(httpsRu('tproger'));
  print(httpsCom('google'));
  print(httpsCom('amazon'));
  print(httpsCom('netflix'));
}

String Function(String) Function(String) getLinkCreator(String scheme) {
  return (String domain) {

    String getWebsite(String link) {
      return scheme + link + domain;
    }
    return getWebsite;
  };
}