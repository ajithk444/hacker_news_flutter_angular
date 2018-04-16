import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:model/model.dart';

import 'item_component.dart';

@Component(
  selector: 'feed',
  templateUrl: 'feed_component.html',
  directives: const [
    ItemComponent,
    NgFor,
    NgIf,
    routerDirectives,
    MaterialInputComponent
  ],
  pipes: const [AsyncPipe],
  encapsulation: ViewEncapsulation.None,
)
class FeedComponent implements OnActivate {
  final HackerNewsService hackerNewsService;
  FeedComponent(this.hackerNewsService);
  @override
  Future onActivate(_, __) async {}
}
