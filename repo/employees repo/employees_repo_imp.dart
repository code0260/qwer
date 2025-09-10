import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_insert_date_steps.dart';
import 'package:almonazim/data/data%20source/repo/employees%20repo/employees_repo.dart';
import 'package:almonazim/data/model/employees%20models/add_employee_model.dart';
import 'package:almonazim/data/model/employees%20models/edit_employee_model.dart';
import 'package:almonazim/data/model/employees%20models/employee_model.dart';
import 'package:almonazim/data/model/employees%20models/employees_departments_model.dart';
import 'package:almonazim/data/model/employees%20models/get_employee_model.dart';
import 'package:dartz/dartz.dart';

class EmployeesRepoImpl implements EmployeesRepo {
  final ApiService apiService;
  EmployeesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<EmployeesDepartmentsModel>>>
      getEmployeesDepartments() async {
    if (employeesDepartments.isEmpty) {
      final result = await apiService.get(
        url: AppLinks.getEmployeesDepartmentsLink,
      );

      return result.fold(
        (failure) => left(failure),
        (response) {
          for (final department in response["data"]) {
            employeesDepartments
                .add(EmployeesDepartmentsModel.fromJson(department));
          }
          return right(employeesDepartments);
        },
      );
    }
    return right(employeesDepartments);
  }

  @override
  Future<Either<Failure, List<EmployeesDepartmentsModel>>>
      refreshEmployeesDepartments() async {
    final result = await apiService.get(
      url: AppLinks.getEmployeesDepartmentsLink,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        employeesDepartments.clear();
        for (final department in response["data"]) {
          employeesDepartments
              .add(EmployeesDepartmentsModel.fromJson(department));
        }
        return right(employeesDepartments);
      },
    );
  }

  @override
  Future<Either<Failure, List<EmployeeModel>>> getEmployees(
      GetEmployeeModel getEmployeeModel) async {
    final result = await apiService.post(
        url: AppLinks.getEmployeesLink,
        formDataIsEnabled: false,
        data: getEmployeeModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<EmployeeModel> employees = [];
        for (final employee in response["data"]) {
          employees.add(EmployeeModel.fromJson(employee));
        }
        return right(employees);
      },
    );
  }

  @override
  Future<Either<Failure, void>> addEmployee(
      AddEmployeeModel addEmployeeModel) async {
    final result = await apiService.post(
        url: AppLinks.addEmployeeLink,
        formDataIsEnabled: false,
        data: addEmployeeModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> editEmployee(
      EditEmployeeModel editEmployeeModel) async {
    final result = await apiService.post(
        url: AppLinks.editEmployeeDataLink,
        formDataIsEnabled: false,
        data: editEmployeeModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> addEmployeeDepartment(
      String departmentName) async {
    final result = await apiService.post(
        url: AppLinks.addEmployeeDepartmentLink,
        data: {"department": departmentName});

    return result.fold(
      (failure) => left(failure),
      (response) => right(null),
    );
  }

  @override
  Future<Either<Failure, void>> importEmployees(String filePath) async {
    final result = await apiService.uploadFile(
        url: AppLinks.importEmployeesLink,
        requestName: "employees_excel_file",
        filePath: filePath);

    return result.fold(
      (failure) => left(failure),
      (response) {
        StoreInsertDateSteps.addStep("12");
        return right(null);
      },
    );
  }
}
