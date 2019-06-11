import 'dart:async';
import 'dart:io';

import 'package:angel_migration/angel_migration.dart';
import 'package:angel_model/angel_model.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_orm/src/query.dart';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:postgres/postgres.dart';
import 'package:test_angel/model.dart';

main() async {

  var executor = new PostgreSqlExecutorPool(Platform.numberOfProcessors, () {
    return new PostgreSQLConnection('localhost', 5432, 'angel_orm_test', username: 'postgres', password: 'selfgoal');
  });
  var query = AuthorQuery()
     ..where.name.like('J.K%');
     

  var author = await query.getOne(executor);
  print(author.toJson());
  var toInsert = AuthorQuery();
  toInsert.values.name = 'Vadim Tsushko22';
  await toInsert.insert(executor);
  var all = AuthorQuery();
  var authors = await all.get(executor);
  print(authors);
  await executor.close();
}

