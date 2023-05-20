import 'dart:convert';
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
Map<String,dynamic> fixtureJson(String name) => jsonDecode(fixture(name));
