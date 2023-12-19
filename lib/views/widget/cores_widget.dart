import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/models/capsules_model.dart';
import 'package:sample_project/models/cores_model.dart';

class CoresListView extends ConsumerWidget {
  const CoresListView({
    Key? key,
    required this.cores,
  }) : super(key: key);
  final List<CoresModel> cores;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: cores.length,
      itemBuilder: (context, index) {
        final core = cores[index];
        return Column(
          children: [
            CoresItem(coresModel:core ,),
            SizedBox(height: 10,)

          ],
        );
      },
    );
  }
}


class CoresItem extends StatefulWidget {
  CoresModel coresModel;
  CoresItem({Key? key,required this.coresModel}) : super(key: key);

  @override
  State<CoresItem> createState() => _CoresItemState();
}

class _CoresItemState extends State<CoresItem> {
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
                          "${widget.coresModel.coreSerial}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color:  Colors.black,
                              backgroundColor: Colors.transparent),
                        ),

                        Text(
                          widget.coresModel.details ?? "",
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