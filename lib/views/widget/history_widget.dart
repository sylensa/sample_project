import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/models/capsules_model.dart';
import 'package:sample_project/models/cores_model.dart';
import 'package:sample_project/models/history_model.dart';

class HistoryListView extends ConsumerWidget {
  const HistoryListView({
    Key? key,
    required this.histories,
  }) : super(key: key);
  final List<HistoryModel> histories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        return Column(
          children: [
            HistoryItem(historyModel:history ,),
            SizedBox(height: 10,)

          ],
        );
      },
    );
  }
}


class HistoryItem extends StatefulWidget {
  HistoryModel historyModel;
  HistoryItem({Key? key,required this.historyModel}) : super(key: key);

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.historyModel.title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color:  Colors.black,
                              backgroundColor: Colors.transparent),
                        ),

                        Text(
                          widget.historyModel.details ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.blue,
                    size: 22,
                  ),
                ],
              )),
        ),
      ),
    );
  }

}