part of 'search_employees_cubit.dart';

sealed class SearchEmployeesState extends Equatable {
  const SearchEmployeesState();

  @override
  List<Object> get props => [];
}

final class SearchEmployeesInitial extends SearchEmployeesState {}

class SearchEmployeesLoading extends SearchEmployeesState {}

class SearchEmployeesFailure extends SearchEmployeesState {
  final String errorMessage;

  const SearchEmployeesFailure(this.errorMessage);
}

class SearchEmployeesSuccess extends SearchEmployeesState {
  final List<EmployeeModel> employees;
  const SearchEmployeesSuccess({
    required this.employees,
  });
}
