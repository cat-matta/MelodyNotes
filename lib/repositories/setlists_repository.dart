import 'package:melodyscore/data/drift_db.dart';

class SetListRepo {
  final AppDb drift;

  SetListRepo(this.drift);

  Future<int> insertSetList(SetListsCompanion setlist){
    return this.drift.insertSetListDb(setlist);
  }

  Future<List<SetList>> getAllSetLists() {
    return this.drift.allSetlistsDb;
  }

  Future deleteSetLists(List<int> listOfIds){
    return this.drift.deleteListofSetListsDB(listOfIds);
  }
}