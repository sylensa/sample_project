

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/core/http/http_repos.dart';
import 'package:sample_project/models/cores_model.dart';

final getCoresProvider =
FutureProvider.autoDispose<List<CoresModel>>((ref) async {

  final response = await  HttpRepos.cores.getAllCores();
  List<CoresModel> cores = [];
  if(response.success){
    List<dynamic> dataResponse =   response.body;
    dataResponse.forEach((element) {
      CoresModel coresModel = CoresModel.fromJson(element);
      cores.add(coresModel);
    });
  }
  return cores;
});

final coresProvider =
FutureProvider.autoDispose<List<CoresModel>>((ref) async {
  final cores = await ref.watch(getCoresProvider.future);
  return cores;
});






