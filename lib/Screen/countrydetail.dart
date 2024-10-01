import 'package:flutter/material.dart';
import 'package:flutter_restapis/Screen/homescreen.dart';

class Countrydetail extends StatefulWidget {
  String image, name;
  int total,recovered, deaths,active,critical,todayRecovered,test;

  Countrydetail({super.key,
  required this.image,
  required this.name,
  required this.total,
  required this.recovered,
  required this.deaths,
  required this.active,
  required this.critical,
  required this.todayRecovered,
  required this.test
  });

  @override
  State<Countrydetail> createState() => _CountrydetailState();
}

class _CountrydetailState extends State<Countrydetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text(widget.name,style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                child: Card(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,bottom: 50),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                        ReusableRow(title: 'Total Cases',value: widget.total.toString(),),
                        ReusableRow(title: 'Recovered',value: widget.recovered.toString(),),
                        ReusableRow(title: 'Deaths',value: widget.deaths.toString(),),
                        ReusableRow(title: 'Active',value: widget.active.toString(),),
                        ReusableRow(title: 'Critical',value: widget.critical.toString(),),
                        ReusableRow(title: 'Today Recovered',value: widget.todayRecovered.toString(),),
                        ReusableRow(title: 'Tests',value: widget.test.toString(),),
                      ],
                    ),
                  )
                ),
              ),
               CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          widget.image
                        ),
                      )
            ],
          )
        ],
      ),
    );
  }
}