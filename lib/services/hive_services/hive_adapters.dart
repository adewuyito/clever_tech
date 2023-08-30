import 'package:hive/hive.dart';

class BoolListAdapter extends TypeAdapter<List<bool>> {
  @override
  final int typeId = 1;
  @override
  List<bool> read(BinaryReader reader) {
    final length = reader.readByte();
    return List.generate(length, (index) => reader.readBool());
  }

  @override
  void write(BinaryWriter writer, List<bool> obj) {
    writer.writeByte(obj.length);
    for (final bool item in obj) {
      writer.writeBool(item);
    }
  }
}
