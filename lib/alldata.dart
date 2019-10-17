class Data {
  var data1 = [
    Pollution(month: 'June', quantity: 3),
    Pollution(month: 'July', quantity: 1),
    Pollution(month: 'August', quantity: 5),
  ];
  var data2 = [
    Pollution(month: 'June', quantity: 1),
    Pollution(month: 'July', quantity: 2),
    Pollution(month: 'August', quantity: 4),
  ];

  var data3 = [
    Pollution(month: 'June', quantity: 5),
    Pollution(month: 'July', quantity: 3),
    Pollution(month: 'August', quantity: 3),
  ];
  var pieData = [
    Electricity(emission: 'Renewable Onsite', emissionValue: 8),
    Electricity(emission: 'Renewable Wheeled', emissionValue: 10),
    Electricity(emission: 'Purchased Grid', emissionValue: 15),
  ];

  var lineData = [
    Vehicles(month: 1, emissions: 56),
    Vehicles(month: 2, emissions: 55),
    Vehicles(month: 3, emissions: 60),
    Vehicles(month: 4, emissions: 61),
    Vehicles(month: 5, emissions: 70),
  ];
  var lineData1 = [
    Vehicles(month: 1, emissions: 46),
    Vehicles(month: 2, emissions: 45),
    Vehicles(month: 3, emissions: 50),
    Vehicles(month: 4, emissions: 51),
    Vehicles(month: 5, emissions: 60),
  ];

  var lineData2 = [
    Vehicles(month: 1, emissions: 24),
    Vehicles(month: 2, emissions: 25),
    Vehicles(month: 3, emissions: 40),
    Vehicles(month: 4, emissions: 45),
    Vehicles(month: 5, emissions: 60),
  ];
}

class Pollution {
  String month;
  int quantity;

  Pollution({this.month, this.quantity});
}

class Vehicles {
  int month;
  double emissions;

  Vehicles({this.month, this.emissions});
}

class Electricity {
  String emission;
  double emissionValue;
  Electricity({this.emission, this.emissionValue});
}
