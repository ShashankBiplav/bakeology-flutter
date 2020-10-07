import 'package:flutter/foundation.dart';

class Chef {
  final String email;
  final String name;
  final String status;
  final String profileImageUrl;
  final List<String> recipes;
  final bool isApproved;

  Chef(
      {@required this.email,
      @required this.name,
      @required this.status,
      @required this.profileImageUrl,
      @required this.recipes,
      @required this.isApproved});
}
