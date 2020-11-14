import 'package:flutter/material.dart';
import 'package:hisseler/screens/hisseDetailScreen.dart';
import 'package:hisseler/screens/persistentNavBar.dart';
import 'package:hisseler/services/fetchHisseList.dart';
import 'classes/hisse.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Borsa Hisseleri',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavBar(),
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
  Future fetchHisseList;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  Size screenSize;

  List<Hisse> cacheList = List<Hisse>();

  TextEditingController searchQuery = TextEditingController();
  List<Hisse> queryHisse = List<Hisse>();
  String searchText = "";
  bool isSearching;
  String selectedValue = "";

  _MyHomePageState() {
    searchQuery.addListener(() {
      print("listener çalışıyor");
      if (searchQuery.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          searchText = searchQuery.text;
        });
      }
    });
  }

  handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  handleSearchEnd() {
    setState(() {
      isSearching = false;
      searchQuery.clear();
      queryHisse.removeRange(0, queryHisse.length);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHisseList = fetchHisseListesi();
    isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          GestureDetector(child: Icon(Icons.keyboard_arrow_up)),
        ],
      ),
      body: SafeArea(
        left: true,
        top: true,
        bottom: true,
        right: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Hisse ara",
                    ),
                    textInputAction: TextInputAction.search,
                    textAlign: TextAlign.start,
                    controller: searchQuery,
                    onTap: () {
                      print('onTap');
                      setState(() {
                        handleSearchStart();
                      });
                    },
                    onSubmitted: (value) {
                      print('onSubmitted');
                      handleSearchEnd();
                    },
                    onChanged: (value) {
                      print('onChanged');
                    },
                  ),
                ), // TODO: Search Bar Querying...
                Container(
                  height: screenSize.height,
                  child: isSearching ? buildQueryList() : buildHisseList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildQueryList() {
    if (searchText.isEmpty) {
      return buildHisseList();
    } else {
      for (int i = 0; i < cacheList.length; i++) {
        String hisseKod = cacheList.elementAt(i).kod;
        if (hisseKod.toLowerCase().contains(searchText.toLowerCase())) {
          queryHisse.add(cacheList.elementAt(i));
        }
      }
      queryHisse.forEach((element) {
        print(element.kod);
      });
      return ListView.builder(
          itemCount: queryHisse.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer<bool>(
                transitionType: _transitionType,
                transitionDuration: Duration(seconds: 2),
                closedShape: RoundedRectangleBorder(),
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ListTile(
                    title: Text('${queryHisse[index].kod}'),
                    trailing: GestureDetector(
                        onTap: openContainer, child: Icon(Icons.expand_more)),
                  );
                },
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return HisseDetail(hisse: queryHisse[index]);
                });
          });
    }
  }

  buildHisseList() {
    if (cacheList.isEmpty) {
      return FutureBuilder(
          future: fetchHisseList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var hisse = Hisse.fromJson(snapshot.data, index);
                    cacheList.add(hisse);
                    return OpenContainer<bool>(
                        transitionDuration: Duration(seconds: 2),
                        transitionType: _transitionType,
                        closedShape: RoundedRectangleBorder(),
                        closedBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return ListTile(
                            title: Text('${hisse.kod}'),
                            trailing: GestureDetector(
                                onTap: openContainer,
                                child: Icon(Icons.expand_more)),
                          );
                        },
                        openBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return HisseDetail(hisse: hisse);
                        });
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else {
      return ListView.builder(
          itemCount: cacheList.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer<bool>(
                transitionDuration: Duration(seconds: 2),
                transitionType: _transitionType,
                closedShape: RoundedRectangleBorder(),
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ListTile(
                    title: Text('${cacheList[index].kod}'),
                    trailing: GestureDetector(
                        onTap: openContainer, child: Icon(Icons.expand_more)),
                  );
                },
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return HisseDetail(hisse: cacheList[index]);
                });
          });
    }
  }
}
