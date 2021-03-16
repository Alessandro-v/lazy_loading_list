import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();

  bool _isLoading = false;
  List<String> _dummy = List.generate(20, (index) => 'Item $index');

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onScroll() {
    if (_controller.offset >=
        _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isLoading = true;
      });
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lazy list'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _isLoading ? _dummy.length + 1 : _dummy.length,
        itemBuilder: (context, index) {
          if (_dummy.length == index)
            return Center(
                child: CircularProgressIndicator()
            );
          return ListTile(
            title: Text(
                _dummy[index]
            )
          );
        },
      ),
    );
  }

  Future _fetchData() async {
    await new Future.delayed(new Duration(seconds: 2));
    int lastIndex = _dummy.length;

    setState(() {
      _dummy.addAll(
          List.generate(15, (index) => "New Item ${lastIndex+index}")
      );
      _isLoading = false;
    });
  }
}

