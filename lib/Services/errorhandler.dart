class ErrorHandler {
  Map<int, String> networkErros = {
    200: 'Successful network transfer',
  };

  void networkError(int errorCode, {String task}) {
    print(networkErros[errorCode] + ', while $task');
  }
}
