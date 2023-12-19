import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/controllers/capsule_controller.dart';
import 'package:sample_project/views/widget/capsule_widget.dart';

class CapsulePage extends ConsumerWidget {
  const CapsulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capsulesState = ref.watch(capsulesProvider);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        capsulesState.when(
          data: (capsules) {
            return Expanded(child: CapsulesListView(capsules: capsules));
          },
          error: (error, stackTrace) {
            print('error: $error\nstackTrace: ${stackTrace.toString()}');
            // todo: show error instead;
            return const Expanded(child: SizedBox.shrink());
          },
          loading: () {
            return const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
            );
          },
        ),

      ],
    );
  }
}


