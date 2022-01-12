import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '05_MaterialCupertino'),
    );
  }
}

Widget myGradientButton(buttonName) {  //ради любопытства стащил градиентные кнопки. т.к. кнопки вызываются дважды то запихнул в виджет
  return (ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 15),
          ),
          onPressed: () {},
          child: Text(buttonName),
        )
      ])));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.person_pin)))
        ],
      ),
      drawer: Drawer(
        // backgroundColor: Colors.green,
        child: Column(
          children: [
            DrawerHeader(
                child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://img.favpng.com/25/19/20/maine-coon-kitten-horse-png-favpng-L2wsCSdWTLcmm0258fE4gAjL7.jpg'),
            )),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text('Images'),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text('Files'),
              leading: Icon(Icons.file_copy),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 320),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                myGradientButton('Выход'),
                SizedBox(width: 30),
                myGradientButton('Регистрация'),
              ],
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://img.favpng.com/25/19/20/maine-coon-kitten-horse-png-favpng-L2wsCSdWTLcmm0258fE4gAjL7.jpg'),
            ),
          ),
          Text('Текст, текст'),
        ],
      ))),

      body: BottomNavigationBarTwo(),
    );
  }
}

class TabItem {
  String title;
  Icon icon;

  TabItem({this.title, this.icon});
}

final List<TabItem> _tabBar = [
  TabItem(title: 'Home', icon: Icon(Icons.home)),
  TabItem(title: 'Profile', icon: Icon(Icons.person)),
  TabItem(title: 'Images', icon: Icon(Icons.image)),
];

class BottomNavigationBarTwo extends StatefulWidget {   // в этот же класс запихнул и FloatingActionButton из за привязки к этом у Scaffold
  BottomNavigationBarTwo({Key key}) : super(key: key);

  @override
  _BottomNavigationBarTwoState createState() =>
      _BottomNavigationBarTwoState();
}

class _BottomNavigationBarTwoState extends State<BottomNavigationBarTwo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 0;
  BottomNavigationBar bottomNavigationBar;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.lightBlueAccent,
            child: Center(
              child: Text('1'),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Text('2'),
            ),
          ),
          Container(
            color: Colors.greenAccent,
            child: Center(
              child: Text('3'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: [
          for (final item in _tabBar)
            BottomNavigationBarItem(label: item.title, icon: item.icon)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Icon(Icons.credit_card),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Text('Сумма')),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('200 руб.')))
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      child: const Text('Оплатить'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
