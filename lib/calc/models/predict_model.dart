class PredictModel {
  double predicted;

  // the 'modelfit' dictionary is the store of regressed coefficient/intercepts that were 
  // modeled via sklearn.LinearRegression.  the scores of the lin regress models are 
  // comparable to the SVM functionality and are much higher than modeling as a neural
  // network.  in addition, linear regression gives the flexibility to load parameters
  // directly and perform a simple fit.

  static final modelfit = const {
       'BRL': const {
         'm': 0.0005751769644229082,
         'b': -21.34807939417304
       },
       'CHF': const {
         'm': -0.00010284659197003397,
         'b': 5.274528640326641
       },
       'CNY': const {
         'm': -0.00027239637038527746,
         'b': 17.994686144216725
       },
       'CZK': const {
         'm': -0.001964771055930891,
         'b': 102.92860906511058
       },
       'HRK': const {
         'm': 0.00026490118529812206,
         'b': -4.973769595612549
       },
       'IDR': const {
         'm': 1.1171836280845377,
         'b': -34857.077168993885
       },
       'INR': const {
         'm': 0.00745245578004,
         'b': -252.52657808791048
       },
       'MXN': const {
         'm': 0.002173309619721407,
         'b': -75.42117365944063
       },
       'NZD': const {
         'm': -0.0001105801429185607,
         'b': 5.970418307078705
       },
       'RON': const {
         'm': 0.00034725691476839043,
         'b': -10.925228336366716
       },
       'RUB': const {
         'm': 0.00910023427229277,
         'b': -333.1409102018868
       },
       'SGD': const {
         'm': -7.522519030348728e-05,
         'b': 4.496009977022573
       },
       'TRL': const {
         'm': 616.9791310068948,
         'b': -21868345.04719412
       },
       'TRY': const {
         'm': 0.0006634996430882456,
         'b': -24.930443356797852
       },
       'ZAR': const {
         'm': 0.0009369452855166964,
         'b': -28.24133798229502
       },
       'CAD': const {
         'm': -3.9922593239608955e-05,
         'b': 2.8320863638573703
       }
     };

  PredictModel({this.predicted});

  factory PredictModel.prediction(String currFrom, String currTo, String thedate) {
    
    final dateformodel = DateTime.parse(thedate);

    final startoftime = DateTime(1899,12,30);
    final numdays = dateformodel.difference(startoftime).inDays;


    double predfrom = 1;
    double predto = 1;

    if (currFrom != 'USD') {
      var currIn = modelfit[currFrom];
      var mIn = currIn['m'];
      var bIn = currIn['b'];
      predfrom = mIn * numdays + bIn;
    }
    
    if (currTo != 'USD') {
      var currOut = modelfit[currTo];
      var mOut = currOut['m'];
      var bOut = currOut['b'];
      predto = mOut * numdays + bOut;
    }
    double exrate = predto / predfrom;
    
    //float predstr = exrate.toStringAsFixed(exrate.truncateToDouble() == exrate ? 0 : 2);

    return PredictModel(
      predicted: exrate
    );
  }

}