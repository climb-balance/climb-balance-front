import 'package:climb_balance/services/server_request.dart';
import 'package:riverpod/riverpod.dart';

final serverRequestPrivider = Provider<ServerRequest>((ref) {
  return ServerRequest();
});
