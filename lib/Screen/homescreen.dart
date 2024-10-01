import 'package:flutter/material.dart';
import 'package:flutter_restapis/Modals/WorldStatesModal.dart';
import 'package:flutter_restapis/Services/states_services.dart';
import 'package:flutter_restapis/Screen/countryList.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  // color code
  final _colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecord(),
                  builder: (context, AsyncSnapshot<WorldStatesModal> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recoverd": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: _colorList,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                                legendTextStyle:
                                    TextStyle(color: Colors.white)),
                                    chartValuesOptions: const ChartValuesOptions(
                                      showChartValuesInPercentage: true
                                    ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          Card(
                            color:  Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableRow(title: 'Total', value:snapshot.data!.cases.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                ),
                                ReusableRow(title: 'Recoverd', value: snapshot.data!.recovered.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                                ReusableRow(title: 'Tests', value: snapshot.data!.tests.toString()),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Countrylist()));
                            },
                            child: Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text('Check country Data',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        )
      ],
    );
  }
}
