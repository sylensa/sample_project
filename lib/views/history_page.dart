
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/controllers/cores_controller.dart';
import 'package:sample_project/controllers/history_controller.dart';
import 'package:sample_project/views/widget/cores_widget.dart';
import 'package:sample_project/views/widget/capsule_widget.dart';
import 'package:sample_project/views/widget/history_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(historyProvider);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        historyState.when(
          data: (histories) {
            return Expanded(child: HistoryListView(histories: histories));
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


