import 'package:flutter/foundation.dart';
import 'package:test/test.dart';

typedef StateBuilder<S> = ValueNotifier<S> Function();
typedef Act<C> = Future<void> Function(C controller);
typedef Verify = Future<void> Function();

Future<void> notifierTest<C extends ValueNotifier<S>, S>(
  String description, {
  required C Function() createController,
  required VoidCallback setUp,
  required S Function() seed,
  required Act<C> act,
  required List<S> Function() expectedValues,
  VoidCallback? verify,
}) async {
  test(description, () async {
    // Create the controller
    final controller = createController()..value = seed();

    // Perform any setup actions
    setUp();

    // Capture state changes
    final states = <S>[];
    controller.addListener(() => states.add(controller.value));

    // Perform the action on the controller
    await act(controller);

    // Check the expected states
    final expected = expectedValues();
    expect(
      states.length,
      expected.length,
      reason: 'Number of state changes should match expected values',
    );
    for (final (i, _) in expected.indexed) {
      expect(states[i], expected[i]);
    }

    // Perform any additional verifications
    verify?.call();

    // Clean up
    controller.dispose();
  });
}
