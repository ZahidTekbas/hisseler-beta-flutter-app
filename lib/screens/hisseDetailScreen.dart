import 'package:flutter/material.dart';
import 'package:hisseler/classes/hisseInfo.dart';
import 'package:hisseler/constants/constants.dart';
import 'package:hisseler/database/databaseHelper.dart';
import 'package:hisseler/services/fetchHisse.dart';
import 'package:hisseler/classes/hisse.dart';
import 'package:hisseler/widgets/hisseContainer.dart';

class HisseDetail extends StatefulWidget {
  final Hisse hisse;

  HisseDetail({this.hisse});
  @override
  _HisseDetailState createState() => _HisseDetailState();
}

class _HisseDetailState extends State<HisseDetail> {
  Future fetchHisseInfo;
  Size screenSize;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchHisseInfo = fetchHisse(widget.hisse.kod);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey, title: Text('${widget.hisse.kod}')),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        top: true,
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchHisseInfo,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print('Hisse Detayları Alındı');
                  HisseInfo hisse = HisseInfo.fromJson(snapshot.data);

                  return Column(
                    children: [
                      SizedBox(height: 10.0),
                      Text('${hisse.tarih}'),
                      SizedBox(height: 10.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HisseContainer(
                              widthPayda: 2.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Alış Fiyatı',
                                    style: titleTextStyle,
                                  ),
                                  Container(height: 1, color: Colors.grey[200]),
                                  Text('${hisse.alis}',
                                      style: descriptionTextStyle)
                                ],
                              ),
                            ),
                            SizedBox(height: screenSize.height / 5),
                            HisseContainer(
                              widthPayda: 2.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Satış Fiyatı', style: titleTextStyle),
                                  Container(height: 1, color: Colors.grey[200]),
                                  Text('${hisse.satis}',
                                      style: descriptionTextStyle)
                                ],
                              ),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HisseContainer(
                            widthPayda: 4.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Açılış', style: titleTextStyle),
                                Container(height: 1, color: Colors.grey[200]),
                                Text('${hisse.acilis}',
                                    style: descriptionTextStyle)
                              ],
                            ),
                          ),
                          HisseContainer(
                            widthPayda: 4.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Kapanış', style: titleTextStyle),
                                Container(height: 1, color: Colors.grey[200]),
                                Text('${hisse.kapanis}',
                                    style: descriptionTextStyle)
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height / 9),
                          HisseContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Yüksek', style: titleTextStyle),
                                Container(height: 1, color: Colors.grey[200]),
                                Text('${hisse.yuksek}',
                                    style: descriptionTextStyle)
                              ],
                            ),
                            widthPayda: 4.5,
                          ),
                          HisseContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Düşük', style: titleTextStyle),
                                Container(height: 1, color: Colors.grey[200]),
                                Text('${hisse.dusuk}',
                                    style: descriptionTextStyle)
                              ],
                            ),
                            widthPayda: 4.5,
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
