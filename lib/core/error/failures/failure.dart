import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const <dynamic>[];

  Failure([properties]);

  @override
  List<Object> get props => properties;
}

class AuthFailure extends Failure {
  final String error;

  AuthFailure({this.error});

}
