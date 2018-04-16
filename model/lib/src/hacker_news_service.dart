import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HackerNewsService {
  final http.Client _client;
  StreamController<String> filterQuery = new StreamController();
  Stream<List<Item>> results = new Stream.empty();

  List<Item> _items = [];

  Future<void> fetch() async {
    print('start fetch');
    final response =
        await _client.get('https://hacker-news.firebaseio.com/v0/topstories.json');
    final ids = jsonDecode(response.body).cast<int>().toList();

    await Future
        .wait<Item>(ids.take(10).map<Future<Item>>((int id) => _client
            .get(
                'https://hacker-news.firebaseio.com/v0/item/${id.toString()}.json')
            .then((http.Response res) => Item.fromMap(jsonDecode(res.body)))))
        .then((results) {
      _items = results;
    });
  }

  HackerNewsService(this._client) {
    results = filterQuery.stream.map((String text) {
      print('filtering text is $text');
      if (text.isEmpty) return _items;
      return _items.where((i) => i.title.contains(text)).toList();
    });
    fetch().then((_) {
      filterQuery.add('');
    });
  }

  void dispose() {
    filterQuery.close();
  }
}

class Item {
  final int index;
  final String title;
  final String url;
  final int score;
  final String by;
  final int time;
  final int descendants;

  const Item(
      {this.index,
      this.title,
      this.url,
      this.score,
      this.by,
      this.time,
      this.descendants});

  Item.fromMap(Map<String, dynamic> map)
      : index = map['index'] ?? 1,
        title = map['title'],
        url = map['url'],
        score = map['score'],
        by = map['by'],
        time = map['time'],
        descendants = map['descendants'];

  String get site => Uri.parse(url).host;

  int get hoursAgo {
    return new DateTime.now()
        .difference(new DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .inHours;
  }

  static Item getMock() => new Item(
        index: 0,
        title:
            'USAF Is Jamming GPS in Western U.S. For Largest Ever Red Flag Air War Exercise',
        url:
            'http://www.thedrive.com/the-war-zone/17987/usaf-is-jamming-gps-in-the-western-u-s-for-largest-ever-red-flag-air-war-exercise',
        score: 85,
        by: 'tonyztan',
        time: 1517016589,
        descendants: 37,
      );
}
