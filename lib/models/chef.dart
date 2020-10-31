import 'package:flutter/foundation.dart';

class Chef {
  final String id;
  final String email;
  final String name;
  final String status;
  final String profileImageUrl;
  final bool isApproved;

  Chef(
      {
        @required this.id,
        @required this.email,
      @required this.name,
      @required this.status,
      @required this.profileImageUrl,
      @required this.isApproved});
}
