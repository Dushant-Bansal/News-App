import 'dart:io' show Platform;

bool kIsDesktop = Platform.isMacOS;
bool kIsMobile = Platform.isAndroid || Platform.isIOS;
bool kIsMacOS = Platform.isMacOS;
