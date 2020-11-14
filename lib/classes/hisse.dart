class Hisse {
  String id;
  String kod;
  String ad;
  String tip;

  Hisse({this.id,this.kod,this.ad,this.tip}); 

  factory Hisse.fromJson(dynamic json, int index){
    var id = json['data'][index]['id'].toString();
    var kod = json['data'][index]['kod'];
    var ad = json['data'][index]['ad'];
    var tip = json['data'][index]['tip'];

    return Hisse(
      id : id,
      kod : kod,
      ad : ad,
      tip : tip
    );
  }
}