import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part '../../../../features/_auth/domain/logic/credentials_manager/private.dart';

abstract final class SessionManager {
  static final _SessionVanilla _vanilla = _SessionVanilla(null);

  static void createSession(Session session) => _vanilla.createData(session);

  static Session? get session => _vanilla.readData;

  static Session get requireSession => session!;

  static void deleteSession() => _vanilla.deleteData();
}
