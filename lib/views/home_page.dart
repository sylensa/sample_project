import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/controllers/capsule_controller.dart';
import 'package:sample_project/views/capsules_page.dart';
import 'package:sample_project/views/cores_page.dart';
import 'package:sample_project/views/widget/capsule_widget.dart';
import 'package:sample_project/views/widget/tab_bar_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Capsules"),elevation: 1,),
      body: TabControlWidget(
        currentPageNumber: 0,

        variant: 'square',
        tabs:  ['Capsules', 'Cores'],
        tabPages: [
          CapsulePage(),
          CoresPage(),
        ],
      ),
    );
  }
}


