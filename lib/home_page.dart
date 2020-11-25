import 'package:aguspriohandoko_prakerja_eduka_statistic_covid19/MCountry.dart';
import 'package:aguspriohandoko_prakerja_eduka_statistic_covid19/detail_country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = 'https://covid19.mathdro.id/api/countries';

  Future<List<MCountry>> _getCountry() async{
    final rs = await http.get(api);
    if(rs.statusCode != 200){
      throw Exception("load error");
    }
    
    var dataCountry = json.decode(rs.body);
    //print(tes['countries']);
    List data = dataCountry['countries'];
    return data.map((negara) => MCountry.fromJson(negara)).toList();
  }

  ListView _countryListview(data){
    //print(data.length);
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        return ListNegara(
          id: data[index].iso3,
          title: data[index].name,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child:FutureBuilder(
          future: _getCountry(),
          builder: (context,snapshot){
            //print(snapshot.hasData);
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){
              List<MCountry> data = snapshot.data;
              //return snapshot.data != null ? _countryListview(data) : Center(child: CircularProgressIndicator(), );
              return _countryListview(data);
            }else{
              print(snapshot.hasData);
              return Text("${snapshot.error}");
            }
          },
        )
      ),
    );
  }
}

class ListNegara extends StatelessWidget {
  const ListNegara({Key key, this.title,this.id}) : super(key: key);
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>(DetailCountry(
          id: id,
          name: title,
        ))));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Icon(
                Icons.arrow_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
