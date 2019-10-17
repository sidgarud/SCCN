import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ScopePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScopePageState();
  }
}

//All the chart classes------------------
class FuelSetEmission {
  final String month;
  final int emissionValue;
  final charts.Color color;

  FuelSetEmission({this.month, this.emissionValue, Color color})
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class VehicleEmission {
  final DateTime month;
  //Remember : DateTime.january returns int 1!!
  final double vehicleEmissionValue;

  VehicleEmission({this.month, this.vehicleEmissionValue});
}

class ElectricityConsumption {
  String electricityConsumptionType;
  double electricityConsumptionValue;
  final charts.Color color;

  ElectricityConsumption(
      {this.electricityConsumptionType,
      this.electricityConsumptionValue,
      Color color})
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
//--------------------------------------

//All the chart data--------------------
var barDataDGSet = [
  FuelSetEmission(
      month: 'January', emissionValue: 12, color: Colors.lightBlueAccent),
  FuelSetEmission(
      month: 'February', emissionValue: 42, color: Colors.lightBlueAccent),
  FuelSetEmission(
      month: 'March', emissionValue: 30, color: Colors.lightBlueAccent),
];

var barDataLPG = [
  FuelSetEmission(month: 'January', emissionValue: 6, color: Colors.blueAccent),
  FuelSetEmission(
      month: 'February', emissionValue: 22, color: Colors.blueAccent),
  FuelSetEmission(month: 'March', emissionValue: 10, color: Colors.blueAccent),
];

var pieData = [
  ElectricityConsumption(
      electricityConsumptionType: 'Renewable Energy Onsite',
      electricityConsumptionValue: 28,
      color: Colors.indigo),
  //Electricity(electricityConsumption: 'Renewable Wheeled', electricityConsumptionValue: 10),
  ElectricityConsumption(
      electricityConsumptionType: 'Purchased Electricity (kWh)',
      electricityConsumptionValue: 15,
      color: Colors.lightBlueAccent),
];

var lineDataTwoAndThreeWheeler = [
  VehicleEmission(month: DateTime(2019, 1), vehicleEmissionValue: 40),
  VehicleEmission(month: DateTime(2019, 2), vehicleEmissionValue: 55),
  VehicleEmission(month: DateTime(2019, 4), vehicleEmissionValue: 60),
  VehicleEmission(month: DateTime(2019, 6), vehicleEmissionValue: 61),
  VehicleEmission(month: DateTime(2019, 9), vehicleEmissionValue: 70),
];

var lineDataFourWheeler = [
  VehicleEmission(month: DateTime(2019, 2), vehicleEmissionValue: 46),
  VehicleEmission(month: DateTime(2019, 4), vehicleEmissionValue: 45),
  VehicleEmission(month: DateTime(2019, 6), vehicleEmissionValue: 50),
  VehicleEmission(month: DateTime(2019, 7), vehicleEmissionValue: 51),
  VehicleEmission(month: DateTime(2019, 10), vehicleEmissionValue: 60),
];

var lineDataBusAndFreight = [
  VehicleEmission(month: DateTime(2019, 2), vehicleEmissionValue: 24),
  VehicleEmission(month: DateTime(2019, 4), vehicleEmissionValue: 25),
  VehicleEmission(month: DateTime(2019, 6), vehicleEmissionValue: 40),
  VehicleEmission(month: DateTime(2019, 7), vehicleEmissionValue: 31),
  VehicleEmission(month: DateTime(2019, 10), vehicleEmissionValue: 50),
];
//-----------------------

//All the chart series--------------------
var barSeries = [
  charts.Series(
    domainFn: (FuelSetEmission clickData, _) => clickData.month,
    measureFn: (FuelSetEmission clickData, _) => clickData.emissionValue,
    colorFn: (FuelSetEmission clickData, _) => clickData.color,
    id: 'Cumulative DG Set Emissions',
    data: barDataDGSet,
  ),
  charts.Series(
    domainFn: (FuelSetEmission clickData, _) => clickData.month,
    measureFn: (FuelSetEmission clickData, _) => clickData.emissionValue,
    colorFn: (FuelSetEmission clickData, _) => clickData.color,
    id: 'Cumulative LPG Emissions',
    data: barDataLPG,
  ),
];

var pieSeries = [
  charts.Series(
    domainFn: (ElectricityConsumption electricity, _) =>
        electricity.electricityConsumptionType,
    measureFn: (ElectricityConsumption electricity, _) =>
        electricity.electricityConsumptionValue,
    colorFn: (ElectricityConsumption electricity, _) => electricity.color,
    id: 'Electricity Consumption',
    data: pieData,
  ),
];

var lineSeries = [
  charts.Series(
    domainFn: (VehicleEmission v, _) => v.month,
    measureFn: (VehicleEmission v, _) => v.vehicleEmissionValue,
    //colorFn: (Vehicles v, _) => v.color,
    id: '2&3 Wheeler Emissions',
    data: lineDataTwoAndThreeWheeler,
  ),
  charts.Series(
    domainFn: (VehicleEmission v, _) => v.month,
    measureFn: (VehicleEmission v, _) => v.vehicleEmissionValue,
    //colorFn: (Vehicles v, _) => v.color,
    id: '4 Wheeler Emissions',
    data: lineDataFourWheeler,
  ),
  charts.Series(
    domainFn: (VehicleEmission v, _) => v.month,
    measureFn: (VehicleEmission v, _) => v.vehicleEmissionValue,
    //colorFn: (Vehicles v, _) => v.color,
    id: 'Bus and Freight Vehicle Emissions',
    data: lineDataBusAndFreight,
  ),
];

//------------------------------------

//All the chart design------------------------------
var barChart = charts.BarChart(
  barSeries,
  animate: true,
  barGroupingType: charts.BarGroupingType.stacked,
  behaviors: [charts.SeriesLegend(desiredMaxColumns: 1)],
);

var pieChart = charts.PieChart(
  pieSeries,
  animate: true,
  defaultRenderer: charts.ArcRendererConfig(
    arcRendererDecorators: [
      charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
    ],
  ),
  behaviors: [charts.DatumLegend(desiredMaxColumns: 1)],
);

var lineChart = charts.TimeSeriesChart(
  lineSeries,
  animate: true,
  behaviors: [charts.SeriesLegend(desiredMaxColumns: 1)],
);
//----------------------------------------------

//All the chart builders-----------------------
var barChartWidget = Padding(
  padding: EdgeInsets.all(24.0),
  child: Card(
    child: SizedBox(
      height: 300.0,
      child: barChart,
    ),
  ),
);

var pieChartWidget = Padding(
  padding: EdgeInsets.all(24.0),
  child: Card(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 400.0,
          child: pieChart,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text('Purchased Electricity Emissions: ___  ')),
                    Expanded(child: Text('Renewable Energy Emissions: ___')),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  ),
);

var lineChartWidget = Padding(
  padding: EdgeInsets.all(24.0),
  child: Card(
    child: SizedBox(
      height: 400.0,
      child: lineChart,
    ),
  ),
);

//-------------------------------------------------

class _ScopePageState extends State<ScopePage> {
  @override
  void initState() {
    super.initState();
  }

  //List of Widgets for the BottomNavigationBar
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Container(
      //Code for dashboard begins here
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF1B5E20),
          Color(0xFF66BB6A),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          //Insert dashboard Code here
          Container(
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(
                width: 2,
              ),
            ),
            child: Center(
                child: Text('Scope Wise Distribution',
                    style: TextStyle(color: Colors.white, fontSize: 24))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  width: 2,
                ),
              ),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 250,
                        //child: DonutAutoLabelChart.withSampleData(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(
                  width: 2,
                ),
              ),
              child: Center(
                  child: Text(
                'Worst performing scope: Scope 2',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Scope 1",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "35",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        child: Text(
                          "Good",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.green,
                      )
                    ],
                  ),
                  height: 100,
                  width: 127,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Scope 2",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "55",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        child: Text(
                          "Moderate",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.yellow[600],
                      )
                    ],
                  ),
                  height: 100,
                  width: 127,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white30,
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Scope 3",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "45",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        child: Text(
                          "Good",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.green,
                      )
                    ],
                  ),
                  height: 100,
                  width: 127,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    ),
    //Insert Graph Page Code here
    ListView(
      children: <Widget>[barChartWidget, pieChartWidget, lineChartWidget],
    ),
    //Insert Legend Code here
    Container(
      //Code for legend begins here
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF1B5E20),
          Color(0xFF66BB6A),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white30,
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Scope 1',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.yellow,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Direct Green House Gas Emissions',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/newScope1.PNG',
                    width: 240,
                    height: 240,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Direct GHG emissions occur from sources that are owned or controlled by the institution, for example, emissions from cooking gas, combustion in owned or controlled boilers, vehicles, etc.; emissions from chemical, pharmaceutical labs.",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white30,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Scope 2',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Electricity Greenhouse Gas Emissions',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/newScope2.PNG',
                      width: 240,
                      height: 240,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "This scope accounts for GHG emissions from the generation of purchased electricity consumed by a institution. Purchased electricity is defined as electricity that is purchased or otherwise brought into the organizational boundary of the Institute. These emissions physically occur at the facility where electricity is generated.",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white30,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Scope 3',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Other Indirect Greenhouse Gas Emissions',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/newScope3.PNG',
                      width: 240,
                      height: 240,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "This is an optional reporting category that allows for the treatment of all other indirect emissions. These emissions are a consequence of the activities of the Institute, but occur from sources not owned or controlled by the Institute. Some examples of scope 3 activities are extraction and production of purchased materials; transportation of purchased fuels; and use of products and services.",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: Image.asset(
            'assets/sccn_logo.png',
            fit: BoxFit.cover,
            color: Colors.white,
          ),
        ),
        title: Text('Smart Campus Cloud Network'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
              color: Colors.white,
            ),
            title: Text(
              'Graphs',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
            title: Text(
              'Legend',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    ));
  }
}
