import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/models/capsules_model.dart';

class CapsulesListView extends ConsumerWidget {
  const CapsulesListView({
    Key? key,
    required this.capsules,
  }) : super(key: key);
  final List<CapsulesModel> capsules;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: capsules.length,
      itemBuilder: (context, index) {
        final capsule = capsules[index];
        return Column(
          children: [
            CapsuleHomeItem(capsuleModel:capsule ,),
            SizedBox(height: 10,)

          ],
        );
      },
    );
  }
}

class CapsuleHomeItem extends StatefulWidget {
  CapsulesModel capsuleModel;
  CapsuleHomeItem({Key? key,required this.capsuleModel}) : super(key: key);

  @override
  State<CapsuleHomeItem> createState() => _CapsuleHomeItemState();
}

class _CapsuleHomeItemState extends State<CapsuleHomeItem> {
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
                          "${widget.capsuleModel.capsuleSerial}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color:  Colors.black,
                              backgroundColor: Colors.transparent),
                        ),

                        Text(
                          widget.capsuleModel.details ?? "",
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
