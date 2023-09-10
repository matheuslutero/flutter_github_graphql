import 'package:equatable/equatable.dart';

class Repository extends Equatable {
  final String name;
  final String description;

  const Repository({
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description];
}
