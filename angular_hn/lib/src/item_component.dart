import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:model/model.dart';

@Component(
  selector: 'item',
  templateUrl: 'item_component.html',
  styleUrls: const ['item_component.css'],
  directives: const [NgIf, RouterLink],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ItemComponent {
  @Input()
  Item item;
}
