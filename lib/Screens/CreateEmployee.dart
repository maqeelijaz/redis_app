import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redis/Config/ColorConfig.dart';
import 'package:redis/Services/RedisService.dart';
import 'package:redis/Widgets/CustomDialogs.dart';

import '../Model/EmployeeModel.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key, required this.data});
  final List<EmployeeModel> data;
  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final salary = TextEditingController();
  final age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create Emplyee"), backgroundColor: CUSTOMPRIMARYCOLOR),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name')),
            SizedBox(height: 20),
            TextFormField(
                controller: salary,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Salary')),
            SizedBox(height: 20),
            TextFormField(
                controller: age,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Age')),
            SizedBox(height: 20),
            SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CUSTOMPRIMARYCOLOR),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        List<EmployeeModel> temp = widget.data;
                        temp.add(EmployeeModel(
                            employee_name: name.text,
                            employee_salary: int.parse(salary.text),
                            employee_age: int.parse(age.text)));
                        await RedisService().savedatatoredis(temp);
                        CustomDialogs()
                            .successDialog(context, 'Success',
                                'Employee Created Successfully')
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("Save")))
          ]),
        ),
      ),
    );
  }
}
