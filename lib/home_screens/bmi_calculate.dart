import 'package:flutter/material.dart';

class BMi_Calculate extends StatefulWidget {
  const BMi_Calculate({super.key});

  @override
  State<BMi_Calculate> createState() => _BMi_CalculateState();
}

class _BMi_CalculateState extends State<BMi_Calculate> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  final sizedbox = SizedBox(
    height: 8,
  );
  final formkey = GlobalKey<FormState>();
  double bmiResult = 0.0;
  String resultStatus = '';
  String selectedGender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Calculate Your BMI',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/66492400.jpg'))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Select Gender:",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    DropdownButton<String>(
                      value: selectedGender,
                      items: ['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      style: const TextStyle(
                          color: Color.fromARGB(66, 38, 0, 255)),
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                sizedbox,
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Your weight (kg)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                sizedbox,
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Height (Cm)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, minimumSize: Size(20, 50)),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      calculatebmi();
                    }
                  },
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(
                        color: Colors.white, letterSpacing: 1, fontSize: 18),
                  ),
                ),
                sizedbox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BMI :${bmiResult.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                sizedbox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Result : ${resultStatus}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: bmincolors(bmiResult),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Align children in the center horizontally
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Align children in the center vertically
                  children: [
                    if (bmiResult <= 18.5 ||
                        bmiResult >= 18.5 && bmiResult < 24.9) ...[
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          ''' "Your current weight is within the normal\n range for BMI".''',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          ''' "Your BMI is too high. Please consider\n consulting a healthcare professional. "''',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      )
                    ]
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculatebmi() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      setState(() {
        bmiResult = 0.0;
        resultStatus = "Enter valid weight and height";
      });
      return;
    }
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    if (weight > 0 && height > 0) {
      double heightmeter = height / 100;
      double bmi;
      if (selectedGender == 'Male') {
        bmi = weight / (heightmeter * heightmeter);
      } else {
        bmi = weight / (1.08 * heightmeter * heightmeter);
      }
      setState(() {
        bmiResult = bmi;
        resultStatus = getbmistatus(bmi);
      });
    } else {
      setState(() {
        bmiResult = 0.0;
        resultStatus = 'Invalid input, Enter valid values';
      });
    }
  }

  String getbmistatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  Color bmincolors(double bmi) {
    if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
