import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Converter(),
      );
  }
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  double _userInput;
  String _convertedMeasure;
  String errorMessage;
  String _startValue;
  var fromUnits = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'ounces'
  ];

  final Map<String,int> measuresMap ={
    'Meters':0,
    'Kilometers':1,
    'Grams':2,
    'Kilograms':3,
    'Feet':4,
    'Miles':5,
    'Pounds':6,
    'ounces':7
  };

  dynamic formulas ={

    '0':[1,0.001,0,0,3.280,0.0006213,0],
    '1':[1000,1,0,0,3280.84,0,6213,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220,0.03],
    '3':[0,0,1000,1,0,0,2.2046,35.274],
    '4':[0.0348,0.00030,0,0,1,0.000189],
    '5':[1609.34,1.60934,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,3.28084,0,0.1]
  };


  void converter (double value,String from,String to)
  {

    int nFrom=measuresMap[from];
    int nTo=measuresMap[to];
    var multiplier=formulas[nFrom.toString()][nTo];
    var result=value * multiplier;

    if(result==0)
    {
      errorMessage='Cannot Performed This Conversion';
    }
    else
    {
      errorMessage='${_userInput.toString()} $_startValue are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      errorMessage=errorMessage;
    });

  }


  void initState() {
    _userInput = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text('Value',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 40,color: Colors.blue),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: TextField(
                    style: TextStyle(fontSize: 20,color:Colors.blue),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Enter Your Value',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (text){
                      var input=double.tryParse(text);
                      if(input!=null)
                      {
                        setState(() {
                          _userInput=input;
                        });
                      }
                    },

                  ),
                ),
                SizedBox(height: 10,),
                Text('From',style: TextStyle(fontSize: 20,color: Colors.grey),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.blue),),
                        dropdownColor: Colors.grey,
                        isExpanded: true,style: TextStyle(
                          fontSize: 20,color: Colors.blue
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(

                          value: value,
                          child: Text(value),);
                      } ).toList(),
                        onChanged: (String value){
                          setState(() {

                            _startValue=value;

                          });
                        },
                        value: _startValue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text('To',style: TextStyle(fontSize: 20,color: Colors.grey),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(

                        hint: Text('Choose Your Unit',style: TextStyle(color: Colors.blue),),

                        dropdownColor: Colors.grey,
                        isExpanded: true,style: TextStyle(
                          fontSize: 20,color: Colors.blue
                      ),   items: fromUnits.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),);
                      } ).toList(),
                        onChanged: (String value){
                          setState(() {

                            _convertedMeasure=value;

                          });
                        },
                        value: _convertedMeasure,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FlatButton(
                    onPressed: (){
                      if(_startValue.isEmpty || _convertedMeasure.isEmpty || _userInput==0)
                        return;
                      else {
                        converter(_userInput, _startValue, _convertedMeasure);
                      }
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('Convert',style: TextStyle(fontSize: 30,color: Colors.white),),

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((errorMessage==null)?'':errorMessage
                    ,
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300, color:Colors.blue),),
                )
              ],
            ),
          ),
        ),
      ),);

  }
}
