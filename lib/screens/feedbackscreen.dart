import 'package:flutter/material.dart';

class FeedBack_Screen extends StatefulWidget {
  const FeedBack_Screen({super.key});

  @override
  State<FeedBack_Screen> createState() => _FeedBack_ScreenState();
}

class _FeedBack_ScreenState extends State<FeedBack_Screen> {
  DateTime? selectedDate;
  var FeedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            title: Text(
              '30 days Challenge',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
            centerTitle: true,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(20),
                  elevation: 10,
                  child: Container(
                    height: 350,
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024),
                      onDateChanged: (date) {
                        setState(() {
                          selectedDate = date;
                          FeedbackController.text = formatDate(selectedDate!);
                        });
                        print('selected Date: $selectedDate');
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'FeedBack',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
                TextField(
                  controller: FeedbackController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Write Your FeedBack'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue)),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemCount: FeedbackController.text.length,
                  itemBuilder: (Context, index) {
                    return Container(
                      decoration: BoxDecoration(color: Colors.blue),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day} :';
  }
}
