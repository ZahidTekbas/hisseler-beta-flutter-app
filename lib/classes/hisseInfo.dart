import 'package:hisseler/classes/hisse.dart';

class HisseInfo extends Hisse {

  String tarih;

  double alis;
  double satis;

  double acilis;
  double yuksek;
  double dusuk;
  double kapanis;

  double hacimlot;
  double tavan;
  double taban;
  
  double yilyuksek;
  double yildusuk;
  double aydusuk;
  double ayyuksek;
  double haftayuksek;
  double haftadusuk;

  double yuzdedegisim;
  double net;

  int adet;

  int isActive;

  int dbID;

  HisseInfo.fromJson(dynamic json){
    this.tarih = json['data']['hisseYuzeysel']['tarih'];
    this.alis = json['data']['hisseYuzeysel']['alis'];
    this.satis = json['data']['hisseYuzeysel']['satis'];
    this.acilis = json['data']['hisseYuzeysel']['acilis'];
    this.yuksek = json['data']['hisseYuzeysel']['yuksek'];
    this.dusuk = json['data']['hisseYuzeysel']['dusuk'];
    this.kapanis = json['data']['hisseYuzeysel']['kapanis'];
    this.hacimlot = json['data']['hisseYuzeysel']['hacimlot'];
    this.tavan = json['data']['hisseYuzeysel']['tavan'];
    this.taban = json['data']['hisseYuzeysel']['taban'];
  }

  HisseInfo.forPortfolio(HisseInfo hisse, int adet){
    this.kod = hisse.kod;
    this.alis = hisse.alis;
    this.satis = hisse.satis;
    this.tarih = hisse.tarih;
    this.adet = adet;
  }

    // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = dbID;
    }
    map['kod'] = kod;
    map['date'] = tarih;

    map['alis'] = alis.toString();
    map['satis'] = satis.toString();
    
    map['adet'] = adet;
    map['isActive'] = isActive;

    return map;
  }

  // Extract a Note object from a Map object
  HisseInfo.fromMapObject(Map<String, dynamic> map) {
    this.dbID = map['id'];
    this.kod = map['kod'];
    this.tarih = map['date'];

    String alis = map['alis'];
    String satis = map['satis'];

    this.alis = double.parse(alis);
    this.satis = double.parse(satis);

    this.adet = map['adet'];
    this.isActive = map['isActive'];

  
  }

}