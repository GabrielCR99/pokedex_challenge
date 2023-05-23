import 'dart:io';

import 'package:test/test.dart';

import 'fixture_reader.dart';

void main() {
  test('Should return a json', () {
    final json = getJsonData('src/core/fixture/fixture_reader_test.json');

    expect(
      json,
      allOf([
        isNotNull,
        isNotEmpty,
      ]),
    );
  });

  test('Should return Map<String, dynamic>', () {
    //Arrange

    //Act
    final data = getData<Map<String, dynamic>>(
      'src/core/fixture/fixture_reader_test.json',
    );

    //Assert

    expect(
      data,
      allOf([
        isNotNull,
        isA<Map<String, dynamic>>(),
      ]),
    );

    expect(data['id'], 1);
  });

  test('Should return List', () {
    //Arrange

    //Act
    final data =
        getData<List<Object?>>('src/core/fixture/fixture_reader_list_test.json')
            .cast<Map<String, dynamic>>();

    expect(data, isA<List<Map<String, dynamic>>>());
    expect(data.isNotEmpty, isTrue);
    expect(data, isNotEmpty);
    expect(data.length, 2);
    expect(data.first['id'], 1);
  });

  test('Should return FileSystemException if File is not found', () {
    //Arrange

    //Act
    const call = getData;

    //Assert
    expect(() => call<void>('error.json'), throwsA(isA<FileSystemException>()));
  });
}
