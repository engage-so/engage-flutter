import 'package:flutter_test/flutter_test.dart';

import 'package:engage/engage.dart';

void main() {
  test('adds one to input values', () {
    Engage.init('publicKey');
    Engage.identify('myid', {
      'first_name': 'Engage'
    });
  });
}
