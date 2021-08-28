
import 'dart:async';

String validateMobile(String value) {
    if (value.trim().isEmpty) {
      return 'Hãy nhập số điện thoại của bạn';
    }
    // Check if the entered email has the right format
    if (!RegExp(
            r'(^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$)')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
   return null;
  }

class MyBloc {
  int counter = 0;
  StreamController _counterController = new StreamController<int>.broadcast();
  Stream get counterStream =>
      _counterController.stream.transform(_counterTransformer);

  var _counterTransformer =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data += 10;
    sink.add(data);
  });

  void increment() {
    counter += 1;
    _counterController.sink.add(counter);
  }

  void dispose() {
    _counterController.close();
  }
}
