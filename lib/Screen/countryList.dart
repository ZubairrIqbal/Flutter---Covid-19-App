import 'package:flutter/material.dart';
import 'package:flutter_restapis/Screen/countrydetail.dart';
import 'package:flutter_restapis/Services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class Countrylist extends StatefulWidget {
  const Countrylist({super.key});

  @override
  State<Countrylist> createState() => _CountrylistState();
}

class _CountrylistState extends State<Countrylist> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices stateservices = StatesServices();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: textController,
              onChanged: (value) => setState(() {
                
              }),
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: 'Search with country Name',
                hintStyle: const TextStyle(
                  color: Colors.white
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Expanded(child: 
            FutureBuilder(
              future: stateservices.countryApiList(), 
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700, 
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                      children: [
                        ListTile(
                          title: Container(height: 10,width: 89,color: Colors.white,),
                          subtitle: Container(height: 10,width: 89,color: Colors.white,),
                          leading: Container(height: 50,width: 50,color: Colors.white,),
                        )
                      ],
                    )
                      );
                });
                }else{
                  return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    String name = snapshot.data![index]['country'];
                    if(snapshot.data!.isEmpty){
                      return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Countrydetail(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'], 
                              total: snapshot.data![index]['cases'], 
                              recovered: snapshot.data![index]['recovered'], 
                              deaths: snapshot.data![index]['deaths'],  
                              active: snapshot.data![index]['active'],  
                              critical: snapshot.data![index]['critical'], 
                              todayRecovered: snapshot.data![index]['todayRecovered'], 
                              test:snapshot.data![index]['tests'], )));
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country'],style: TextStyle(
                              fontSize: 15,
                              color: Colors.white
                            ),),
                            subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                            ),),
                            leading: Image(height: 50,width: 50, image: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag']
                            )),
                          ),
                        )
                      ],
                    );
                    }else if(name.toLowerCase().contains(textController.text.toLowerCase())){
                       return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Countrydetail(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'], 
                              total: snapshot.data![index]['cases'], 
                              recovered: snapshot.data![index]['recovered'], 
                              deaths: snapshot.data![index]['deaths'],  
                              active: snapshot.data![index]['active'],  
                              critical: snapshot.data![index]['critical'], 
                              todayRecovered: snapshot.data![index]['todayRecovered'], 
                              test:snapshot.data![index]['tests'], )));
                          },
                          child: ListTile(
                            title: Text(snapshot.data![index]['country'],style: TextStyle(
                              fontSize: 15,
                              color: Colors.white
                            ),),
                            subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                            ),),
                            leading: Image(height: 50,width: 50, image: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag']
                            )),
                          ),
                        )
                      ],
                    );
                    }else{
                      return Container();
                    }
                });
                }
              }))
          ],
        ),
      ),
    );
  }
}