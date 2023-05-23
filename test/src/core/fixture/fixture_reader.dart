import 'dart:convert';
import 'dart:io';

String getJsonData(String path) => File('test/$path').readAsStringSync();

T getData<T>(String path) =>
    jsonDecode(File('test/$path').readAsStringSync()) as T;
