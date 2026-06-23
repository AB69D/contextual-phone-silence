import 'package:equatable/equatable.dart';

class VipContact extends Equatable {
  const VipContact({
    this.id,
    required this.contactId,
    required this.name,
    this.phoneNumbers = const [],
  });

  final int? id;
  final String contactId;
  final String name;
  final List<String> phoneNumbers;

  @override
  List<Object?> get props => [contactId];
}
