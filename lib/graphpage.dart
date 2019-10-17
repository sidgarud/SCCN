import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'alldata.dart';

class GraphPage extends StatefulWidget {
  final Widget child;

  GraphPage({this.child});

  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Electricity, String>> _seriesPieData;
  List<charts.Series<Vehicles, int>> _seriesLineData;

  _generateData() {
    Data data = Data();
    _seriesData.add(
      charts.Series(
        id: 'LPG-Cooking',
        domainFn: (Pollution pollution, _) => pollution.month,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        data: data.data1,
      ),
    );

    _seriesData.add(
      charts.Series(
        id: 'Diesel',
        domainFn: (Pollution pollution, _) => pollution.month,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        data: data.data2,
      ),
    );

    _seriesData.add(
      charts.Series(
        id: 'LPG-lab',
        domainFn: (Pollution pollution, _) => pollution.month,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        data: data.data3,
      ),
    );

    _seriesPieData.add(
      charts.Series(
        id: 'Pollution',
        domainFn: (Electricity e, _) => e.emission,
        measureFn: (Electricity e, _) => e.emissionValue,
        data: data.pieData,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Electricity e, _) =>
            '${e.emission}: ${e.emissionValue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        id: 'Two wheeler',
        data: data.lineData,
        domainFn: (Vehicles v, _) => v.month,
        measureFn: (Vehicles v, _) => v.emissions,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff0277BD)),
        id: 'Three wheeler',
        data: data.lineData1,
        domainFn: (Vehicles v, _) => v.month,
        measureFn: (Vehicles v, _) => v.emissions,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff01579D)),
        id: 'Four wheeler',
        data: data.lineData2,
        domainFn: (Vehicles v, _) => v.month,
        measureFn: (Vehicles v, _) => v.emissions,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Electricity, String>>();
    _seriesLineData = List<charts.Series<Vehicles, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Emission Charts'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Direct Emissions by lpg-cooking, lpg-lab  and diesel (in kg)',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.stacked,
                            behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'CO2 produced by electricity',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: charts.PieChart(
                              _seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 1),
                              defaultRenderer: new charts.ArcRendererConfig(
                                arcRendererDecorators: [
                                  new charts.ArcLabelDecorator(
                                      labelPosition:
                                          charts.ArcLabelPosition.inside)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'CO2 in kg produced by vehicles',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 1),
                              behaviors: [
                                new charts.SeriesLegend(),
                                new charts.ChartTitle('Pollution',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:pie_chart/pie_chart.dart';
//import 'DonutPieChart.dart';
//
//class HomePage extends StatefulWidget {
//  final Widget child;
//
//  HomePage({Key key, this.child}) : super(key: key);
//
//  _HomePageState createState() => _HomePageState();
//}
//
//Map<String, double> dataMap = new Map();
//
//class _HomePageState extends State<HomePage> {
//  List<charts.Series<Pollution, String>> _seriesData;
//  List<charts.Series<Electricity1, String>> _seriesPieData;
//  List<charts.Series<Vehicles, int>> _seriesLineData;
//  List<charts.Series<Electricity, String>> _seriesPieData1;
//
//  TabController _tabController;
//  ScrollController _scrollViewController;
//
//  int _counter = 0;
//
//  _generateData() {
//    var data1 = [
//      new Pollution('June', 3),
//      new Pollution('July', 1),
//      new Pollution('August', 5),
//    ];
//    var data2 = [
//      new Pollution('June', 1),
//      new Pollution('July', 2),
//      new Pollution('August', 4),
//    ];
//
//    var data3 = [
//      new Pollution('June', 5),
//      new Pollution('July', 3),
//      new Pollution('August', 3),
//    ];
//
//    var piedata = [
//      new Electricity1('Renewable Onsite', 8),
//      new Electricity1('Renewable Wheeled', 10),
//      new Electricity1('Purchased Grid', 15),
//    ];
//
//    var piedata1 = [
//      new Electricity('Renewable', 18, Color(0xfffdbe19)),
//      new Electricity('Purchased Grid', 15, Color(0xff990099)),
//    ];
//
//    var linedata = [
//      new Vehicles(2, 56),
//      new Vehicles(4, 55),
//      new Vehicles(6, 60),
//      new Vehicles(8, 61),
//      new Vehicles(10, 70),
//    ];
//    var linedata1 = [
//      new Vehicles(2, 46),
//      new Vehicles(4, 45),
//      new Vehicles(6, 50),
//      new Vehicles(8, 51),
//      new Vehicles(10, 60),
//    ];
//
//    var linedata2 = [
//      new Vehicles(2, 24),
//      new Vehicles(4, 25),
//      new Vehicles(6, 40),
//      new Vehicles(8, 45),
//      new Vehicles(10, 60),
//    ];
//
////    final data = [
////      new LinearSales(0, 100),
////      new LinearSales(1, 75),
////      new LinearSales(2, 25),
////      new LinearSales(3, 5),
////    ];
//
//    _seriesData.add(
//      charts.Series(
//        id: 'LPG-Cooking',
//        domainFn: (Pollution pollution, _) => pollution.place,
//        measureFn: (Pollution pollution, _) => pollution.quantity,
//        data: data1,
//      ),
//    );
//
//    _seriesData.add(
//      charts.Series(
//        id: 'Diesel',
//        domainFn: (Pollution pollution, _) => pollution.place,
//        measureFn: (Pollution pollution, _) => pollution.quantity,
//        data: data2,
//      ),
//    );
//
//    _seriesData.add(
//      charts.Series(
//        id: 'LPG-lab',
//        domainFn: (Pollution pollution, _) => pollution.place,
//        measureFn: (Pollution pollution, _) => pollution.quantity,
//        data: data3,
//      ),
//    );
//
//    _seriesPieData.add(
//      charts.Series(
//        id: 'Pollution',
//        domainFn: (Electricity1 e, _) => e.emission,
//        measureFn: (Electricity1 e, _) => e.emission_value,
//        data: piedata,
//        // Set a label accessor to control the text of the arc label.
//        labelAccessorFn: (Electricity1 e, _) =>
//            '${e.emission}: ${e.emission_value}',
//      ),
//    );
//
//    _seriesPieData1.add(
//      charts.Series(
//        id: 'Pollution',
//        domainFn: (Electricity e, _) => e.emission,
//        measureFn: (Electricity e, _) => e.emission_value,
//        colorFn: (Electricity e, _) =>
//            charts.ColorUtil.fromDartColor(e.colorval),
//        data: piedata1,
//        // Set a label accessor to control the text of the arc label.
//        labelAccessorFn: (Electricity e, _) =>
//            '${e.emission}: ${e.emission_value}',
//      ),
//    );
//
//    _seriesLineData.add(
//      charts.Series(
//        id: 'Two wheeler',
//        data: linedata,
//        domainFn: (Vehicles v, _) => v.month,
//        measureFn: (Vehicles v, _) => v.emissions,
//      ),
//    );
//    _seriesLineData.add(
//      charts.Series(
//        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff0277BD)),
//        id: 'Three wheeler',
//        data: linedata1,
//        domainFn: (Vehicles v, _) => v.month,
//        measureFn: (Vehicles v, _) => v.emissions,
//      ),
//    );
//    _seriesLineData.add(
//      charts.Series(
//        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff01579D)),
//        id: 'Four wheeler',
//        data: linedata2,
//        domainFn: (Vehicles v, _) => v.month,
//        measureFn: (Vehicles v, _) => v.emissions,
//      ),
//    );
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _seriesData = List<charts.Series<Pollution, String>>();
//    _seriesPieData = List<charts.Series<Electricity1, String>>();
//    _seriesLineData = List<charts.Series<Vehicles, int>>();
//    _seriesPieData1 = List<charts.Series<Electricity, String>>();
//    _generateData();
//
//    dataMap.putIfAbsent("Flutter", () => 5);
//    dataMap.putIfAbsent("React", () => 3);
//    dataMap.putIfAbsent("Xamarin", () => 2);
//    dataMap.putIfAbsent("Ionic", () => 2);
//  }
//
//  @override
//  void dispose() {
//    _tabController.dispose();
//    _scrollViewController.dispose();
//    super.dispose();
//  }
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var dpc = DonutPieChart.withSampleData();
//    return MaterialApp(
//      home: Scaffold(
//        body: Center(
//          child: Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                SizedBox(
//                  height: 30.0,
//                  child: Text(
//                    'Direct Emissions by lpg-cooking, lpg-lab  and diesel (in kg)',
//                    style:
//                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                Flexible(
//                  flex: 5,
//                  child: Card(
//                    child: charts.BarChart(
//                      _seriesData,
//                      animate: true,
//                      barGroupingType: charts.BarGroupingType.stacked,
//                      behaviors: [new charts.SeriesLegend()],
//                      animationDuration: Duration(seconds: 1),
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 30.0,
//                  child: Text(
//                    'CO2 produced by electricity',
//                    style:
//                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                Flexible(
//                  flex: 5,
//                  child: Card(
//                    child: Stack(
//                      children: <Widget>[
//                        Container(
//                          //color: Colors.blue,
//                          height: 300.0,
//                          width: 300.0,
//                          child: dpc,
//                        ),
//                        Container(
//                          // color: Colors.blue,
//                          height: 300.0,
//                          width: 300.0,
//                          child: PieChart(
//                            dataMap: dataMap,
//                            showLegends: false,
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 30.0,
//                  child: Text(
//                    'CO2 in kg produced by vehicles',
//                    style:
//                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                  ),
//                ),
//                Flexible(
//                  flex: 5,
//                  child: Card(
//                    child: charts.LineChart(_seriesLineData,
//                        defaultRenderer: new charts.LineRendererConfig(
//                            includeArea: true, stacked: true),
//                        animate: true,
//                        animationDuration: Duration(seconds: 1),
//                        behaviors: [
//                          new charts.SeriesLegend(),
//                          new charts.ChartTitle('Months',
//                              behaviorPosition: charts.BehaviorPosition.bottom,
//                              titleOutsideJustification:
//                                  charts.OutsideJustification.middleDrawArea),
//                        ]),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class Pollution {
//  String place;
//  int quantity;
//
//  Pollution(this.place, this.quantity);
//}
//
//class Vehicles {
//  int month;
//  double emissions;
//
//  Vehicles(this.month, this.emissions);
//}
//
//class Electricity {
//  String emission;
//  double emission_value;
//  Color colorval;
//  Electricity(this.emission, this.emission_value, this.colorval);
//}
//
//class Electricity1 {
//  String emission;
//  double emission_value;
//
//  Electricity1(this.emission, this.emission_value);
//}
