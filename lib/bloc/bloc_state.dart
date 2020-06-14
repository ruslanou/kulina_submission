import 'package:flutter/foundation.dart';
import 'package:kulina_submission_test/bloc/product_list_event.dart';

abstract class BlocState {}

class Idle extends BlocState {
  final data;
  final ProductListEvent event;
  Idle({this.data, this.event});
}

class Waiting extends BlocState {}

class Success extends BlocState {
  final data;
  final ProductListEvent event;
  Success({@required this.data, @required this.event});
}

class Error extends BlocState {
  final error;
  Error({@required this.error});
}
