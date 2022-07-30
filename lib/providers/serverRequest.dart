import 'package:climb_balance/services/serverRequest.dart';
import 'package:riverpod/riverpod.dart';

final serverRequestPrivider = Provider<ServerRequest>((ref) {
  return ServerRequest(ref: ref);
});
