import 'package:angular_router/angular_router.dart';

final newsRoutePath = new RoutePath(
  path: '/',
  additionalData: const {'feed': 'news'},
  useAsDefault: true,
);
