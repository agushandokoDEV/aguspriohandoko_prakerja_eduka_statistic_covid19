import 'package:aguspriohandoko_prakerja_eduka_statistic_covid19/MStatByCountry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;


class Grafik extends StatefulWidget {
  @override
  _GrafikState createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  
   _createDataStatic(id) async{
    var api = 'https://covid19.mathdro.id/api/countries/'+id;
    final rs = await http.get(api);
    if(rs.statusCode != 200){
      throw Exception("load error");
    }
    var dataCountry = json.decode(rs.body);
    
  }

  @override
  void initState() { 
    super.initState();
    print(_createDataStatic("IDN"));
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      new MStatByCountry("Confirmed",45490),
      new MStatByCountry("Recovered",36145),
      new MStatByCountry("Deaths",1725),
    ];
    var series = [
      charts.Series(
        domainFn: (MStatByCountry mdata,_)=>mdata.label,
        measureFn: (MStatByCountry mdata,_)=>mdata.total,
        id: 'Covid19',
        data: data
      )
    ];

    var grafik = charts.BarChart(series);
    return Scaffold(
      appBar: AppBar(
        title: Text("name"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: grafik,
            )
          ],
        )
      )
    );
  }
}

class DetailCountry extends StatelessWidget {
  const DetailCountry({Key key,this.id,this.name}) : super(key: key);
  final String name;
  final String id;
  //final List<charts.Series> seriesList;
  //final bool animate;

 

  
  @override
  Widget build(BuildContext context) {
    return Grafik();
  }
}