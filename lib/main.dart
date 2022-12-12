import 'package:flutter/material.dart';
import 'package:redis/Config/ColorConfig.dart';
import 'package:redis/Helpers/shimmer_helper.dart';
import 'package:redis/Screens/CreateEmployee.dart';
import 'package:redis/Services/RedisService.dart';

import 'Model/EmployeeModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<EmployeeModel>>? getDataFromRedisFuture;
  List<EmployeeModel> data = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    RedisService().storedatatoRedis.then((value) {
      setState(() {
        getDataFromRedisFuture = RedisService().getdatafromredis;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Employee Data"), backgroundColor: CUSTOMPRIMARYCOLOR),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEmployee(data: data),
                  )).then((value) {
                setState(() {
                  getDataFromRedisFuture = RedisService().getdatafromredis;
                });
              });
            },
            child: Icon(Icons.add),
            backgroundColor: CUSTOMPRIMARYCOLOR),
        body: FutureBuilder<List<EmployeeModel>>(
          future: getDataFromRedisFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: CUSTOMPRIMARYCOLOR,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(data[index].employee_name[0],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),
                    title: Text(data[index].employee_name),
                    subtitle: Text(
                        'Salary: ' + data[index].employee_salary.toString())),
              );
            } else {
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: ShimmerHelper().buildListShimmer());
            }
          },
        ));
  }
}
