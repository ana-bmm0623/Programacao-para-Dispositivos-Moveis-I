main() async {
  print('#01 - INÍCIO');

  Future.delayed(Duration(seconds: 5), () => print('#02 - DEMORADO'));
  Future.delayed(Duration(seconds: 1), () => print('#03 - DEMORADO'));
  await minhaFutureFunc();

  print('#06 - FIM');
}

Future<int> minhaFutureFunc() async {
  await Future.delayed(Duration(seconds: 2), () => print('#04 - minhaFutureFunc'));
  Future.microtask(() => print('#05 - Microtask'));

  return 10;
}
