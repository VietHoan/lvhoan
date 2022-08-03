import 'package:get_storage/get_storage.dart';

abstract class Constant {
  static final String API_KEY = GetStorage().read('key_value');
}
