import 'package:sample_project/services/api/capsule_repo.dart';
import 'package:sample_project/services/api/cores_repo.dart';

class HttpRepos {
  static HttpRepos? _instance;

  HttpRepos._internal() {
    _instance = this;
  }

  factory HttpRepos() => _instance ?? HttpRepos._internal();

  //TODO: add all repos here
  static final CapsuleRepo capsuleRepo = CapsuleRepo();
  static final CoresRepo cores = CoresRepo();

}
