
import 'package:frontend/services/remote_moderator_services.dart';
import 'package:get/get.dart';

class ModeratorController extends GetxController {
  final remoteServices = const RemoteModeratorService();

  final _apiKey = ''.obs;
  final _isModerator = false.obs;
  

  bool get isModerator => _isModerator.value;
  String get apiKey => _apiKey.value;
  ModeratorController();



  Future<void> login(String login, String password) async {
    var responce = await remoteServices.login(login, password);
    _apiKey.value = responce.body;
    if (_apiKey.value.length != 16){
      _apiKey.value = '';
      _isModerator.value = false;
    } else {
      _isModerator.value = true;
    }

  }

  Future<void> registration(String login, String password) async {
    await remoteServices.registration(login, password, _apiKey.value);
  }
}
