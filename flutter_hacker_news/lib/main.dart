import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:model/model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(title: 'Hacker News Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HackerNewsService hackerNewsService;
  @override
  void initState() {
    super.initState();
    print('init state');
    hackerNewsService = new HackerNewsService(new IOClient());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
          leading: new Container(
              decoration: const BoxDecoration(
                  border: const Border(
                top: const BorderSide(
                    width: 1.0, color: const Color(0xFFFFFFFFFF)),
                left: const BorderSide(
                    width: 1.0, color: const Color(0xFFFFFFFFFF)),
                right: const BorderSide(
                    width: 1.0, color: const Color(0xFFFFFFFFFF)),
                bottom: const BorderSide(
                    width: 1.0, color: const Color(0xFFFFFFFFFF)),
              )),
              margin: new EdgeInsets.all(8.0),
              child: const Icon(const IconData(89)) // code point for 'Y'
              ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              new TextField(onChanged: hackerNewsService.filterQuery.add),
              new Expanded(
                child: _buildResults(),
              ),
            ],
          ),
        ));
  }

  Widget _buildResults() {
    return new StreamBuilder(
      stream: hackerNewsService.results,
      builder: (context, snapshot) => new ListView(
            padding: EdgeInsets.fromLTRB(1.0, 20.0, 1.0, 0.0),
            children: (snapshot?.data ?? <Item>[])
                .map<NewsItem>((Item item) => new NewsItem(item))
                .toList(),
          ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final Item item;
  NewsItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => new ListTile(
        leading: new Row(
          children: <Widget>[
            new Text('${item.index + 1}.'),
            const Icon(Icons.arrow_drop_up)
          ],
        ),
        title: new RichText(
          text: new TextSpan(
            text: item.title,
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              new TextSpan(text: ' '),
              new TextSpan(
                  text: '(${item.site})',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  )),
            ],
          ),
        ),
        subtitle: new RichText(
          text: new TextSpan(
            text:
                '${item.score} points by ${item.by} ${item.hoursAgo} h ago | hide | ${item.descendants} comments',
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      );
}
