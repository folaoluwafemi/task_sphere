import 'package:appwrite/models.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'private.dart';

abstract final class SessionManager {
  static final _SessionVanilla _vanilla = _SessionVanilla(null);

  static void createSession(Session session) => _vanilla.createData(session);

  static Session? get session => _vanilla.readData;

  static Session get requireSession => session!;

  static void deleteSession() => _vanilla.deleteData();
}
