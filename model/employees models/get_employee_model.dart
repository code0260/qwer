class GetEmployeeModel {
  int? departmentId;
  String? employeeName;
  GetEmployeeModel({
    this.departmentId,
    this.employeeName,
  });

  GetEmployeeModel copyWith({
    int? departmentId,
    String? employeeName,
  }) {
    return GetEmployeeModel(
      departmentId: departmentId ?? this.departmentId,
      employeeName: employeeName ?? this.employeeName,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'employees_name': employeeName,
      'employees_departments_id': departmentId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
