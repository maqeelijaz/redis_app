class EmployeeModel {
  // final int id;
  final String employee_name;
  final int employee_salary;
  final int employee_age;

  EmployeeModel(
      {
      // required this.id,
      required this.employee_name,
      required this.employee_salary,
      required this.employee_age});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      // id: json["id"],
      employee_name: json["employee_name"],
      employee_salary: json["employee_salary"],
      employee_age: json["employee_age"]);

  Map<String, dynamic> toJson() => {
        // "id": id,
        "employee_name": employee_name,
        "employee_salary": employee_salary,
        "employee_age": employee_age
      };
}
