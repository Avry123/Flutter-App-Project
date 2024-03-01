import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: DataList(),
  ));
}

class DataList extends StatefulWidget {
  const DataList({Key? key}) : super(key: key);

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  late Future<Map<String, dynamic>> apiData;

  @override
  void initState() {
    super.initState();
    apiData = fetchData();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse("https://www.jsonkeeper.com/b/W694"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color stuff = Color(0xFF40A2E3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Record List'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data has been successfully fetched, you can now use the data
            Map<String, dynamic> data = snapshot.data!;
            List<dynamic> records = data['data']['Records'];

            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                var projectData = records[index];

                DateTime startDate = DateFormat("dd/MM/yyyy").parse(projectData['startDate']);
                DateTime endDate = DateFormat("dd/MM/yyyy").parse(projectData['endDate']);

                int remainingDays = endDate.difference(startDate).inDays;

                return Container(
                  width: double.infinity,
                  height: 450,
                  color: stuff,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(projectData['mainImageURL']),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 160.0,
                        left: 10.0,
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Card(
                            elevation: 8.0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    projectData['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    projectData['shortDescription'],
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160.0,
                        right: 10.0,
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          margin: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue, // Use a variable if needed
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '100%',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 280.0,
                        left: 10.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.99,
                          child: Card(
                            elevation: 0.0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Rs ${projectData['collectedValue']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Rs ${projectData['totalValue']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            '$remainingDays',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(1.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Pledge'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Funded',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Goals',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Ends In',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(''),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
