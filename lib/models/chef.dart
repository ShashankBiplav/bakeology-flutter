import 'package:flutter/foundation.dart';

import './recipe.dart';

class Chef {
  final String id;
  final String email;
  final String name;
  final String status;
  final String profileImageUrl;
  final bool isApproved;
  final List<Recipe> recipes;

  Chef(
      {@required this.recipes,
      @required this.id,
      @required this.email,
      @required this.name,
      @required this.status,
      @required this.profileImageUrl,
      @required this.isApproved});
}
