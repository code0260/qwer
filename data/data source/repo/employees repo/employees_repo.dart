import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/employees%20models/add_employee_model.dart';
import 'package:almonazim/data/model/employees%20models/edit_employee_model.dart';
import 'package:almonazim/data/model/employees%20models/employee_model.dart';
import 'package:almonazim/data/model/employees%20models/employees_departments_model.dart';
import 'package:almonazim/data/model/employees%20models/get_employee_model.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeesRepo {
  //$ get
  Future<Either<Failure, List<EmployeesDepartmentsModel>>>
      getEmployeesDepartments();

  Future<Either<Failure, List<EmployeesDepartmentsModel>>>
      refreshEmployeesDepartments();
  Future<Either<Failure, List<EmployeeModel>>> getEmployees(
      GetEmployeeModel getEmployeeModel);
  //$ add
  Future<Either<Failure, void>> addEmployee(AddEmployeeModel addEmployeeModel);
  Future<Either<Failure, void>> addEmployeeDepartment(String departmentName);
  Future<Either<Failure, void>> importEmployees(String filePath);
  //$ edit
  Future<Either<Failure, void>> editEmployee(
      EditEmployeeModel editEmployeeModel);
}
