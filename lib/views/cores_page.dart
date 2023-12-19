
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/controllers/cores_controller.dart';
import 'package:sample_project/views/widget/cores_widget.dart';
import 'package:sample_project/views/widget/capsule_widget.dart';

class CoresPage extends ConsumerWidget {
  const CoresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coresState = ref.watch(coresProvider);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        coresState.when(
          data: (cores) {
            return Expanded(child: CoresListView(cores: cores));
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


