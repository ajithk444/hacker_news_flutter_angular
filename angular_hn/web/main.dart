import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

// We are ignoring files that will be generated at compile-time.
// ignore: uri_has_not_been_generated
import 'package:angular_hn/app_component.template.dart' as app;
import 'package:model/model.dart';
import 'package:http/browser_client.dart';

// We are ignoring files that will be generated at compile-time.
// ignore: uri_has_not_been_generated
import 'main.template.dart' as ng;

@GenerateInjector(const [
  // HTTP and Services.
  const FactoryProvider(HackerNewsService, getNewsService),
  // SPA Router.
  routerProviders,
])
final InjectorFactory hackerNewsApp = ng.hackerNewsApp$Injector;

HackerNewsService getNewsService() =>
    new HackerNewsService(new BrowserClient());

void main() async {
  runApp(
    app.AppComponentNgFactory,
    createInjector: hackerNewsApp,
  );
}
