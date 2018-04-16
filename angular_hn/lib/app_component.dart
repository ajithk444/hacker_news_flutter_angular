// Ignore generated templates imported for route definitions.
// ignore_for_file: uri_has_not_been_generated

import 'package:angular/angular.dart';
import 'package:angular_hn/src/routes.dart';
import 'package:angular_router/angular_router.dart';

import 'src/feed_component.template.dart' as feed;

@Component(
  selector: 'app',
  templateUrl: 'app_component.html',
  directives: const [routerDirectives],
  // Disabled. We use global styles that are used before the JavaScript loads.
  //
  // See web/index.html's <style> tag.
  encapsulation: ViewEncapsulation.None,
)
class AppComponent {
  static final newsUrl = newsRoutePath.toUrl();

  static final routes = [
    new RouteDefinition(
      routePath: newsRoutePath,
      component: feed.FeedComponentNgFactory,
    ),
  ];
}
