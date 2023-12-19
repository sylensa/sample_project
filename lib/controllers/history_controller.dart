import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/core/http/http_repos.dart';
import 'package:sample_project/models/history_model.dart';

final getHistoryProvider =
FutureProvider.autoDispose<List<HistoryModel>>((ref) async {

  final response = await  HttpRepos.historyRepo.getAllHistories();
  List<HistoryModel> histories = [];
  if(response.success){
    List<dynamic> dataResponse =   response.body;
    dataResponse.forEach((element) {
      HistoryModel historyModel = HistoryModel.fromJson(element);
      histories.add(historyModel);
    });
  }
  return histories;
});

final historyProvider =
FutureProvider.autoDispose<List<HistoryModel>>((ref) async {
  final history = await ref.watch(getHistoryProvider.future);
  return history;
});






