

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/core/http/http_repos.dart';
import 'package:sample_project/models/capsules_model.dart';

final getCapsulesProvider =
FutureProvider.autoDispose<List<CapsulesModel>>((ref) async {

final response = await  HttpRepos.capsuleRepo.getAllCapsules();
    List<CapsulesModel> capsules = [];
      if(response.success){
      List<dynamic> dataResponse =   response.body;
      dataResponse.forEach((element) {
        CapsulesModel capsulesModel = CapsulesModel.fromJson(element);
        capsules.add(capsulesModel);
      });
      }
return capsules;
});

final capsulesProvider =
FutureProvider.autoDispose<List<CapsulesModel>>((ref) async {
  final capsules = await ref.watch(getCapsulesProvider.future);
  return capsules;
});






