import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class OrganizationUnit {
  final int id;
  final String name;
  final int? parentUnitId;
  final String? parentUnitName;
  final int organizationUnitType;
  final String? typeName;
  final String? summary;
  final String? phone;
  final String? email;
  final String? address;
  final String? coverFilePath;

  const OrganizationUnit({
    required this.id,
    required this.name,
    this.parentUnitId,
    this.parentUnitName,
    required this.organizationUnitType,
    this.typeName,
    this.summary,
    this.phone,
    this.email,
    this.address,
    this.coverFilePath,
  });

  factory OrganizationUnit.fromJson(Map<String, dynamic> j) => OrganizationUnit(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        parentUnitId: j['parentUnitId'] as int?,
        parentUnitName: j['parentUnitName'] as String?,
        organizationUnitType: j['organizationUnitType'] as int? ?? 0,
        typeName: j['organizationUnitTypeName'] as String?,
        summary: j['summary'] as String?,
        phone: j['phone'] as String?,
        email: j['email'] as String?,
        address: j['address'] as String?,
        coverFilePath: j['coverFilePath'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);

  bool get isPresidency => organizationUnitType == 1;
  bool get isDeputyMayor => organizationUnitType == 2;
  bool get isCouncil => organizationUnitType == 4 || (typeName?.toLowerCase().contains('meclis') ?? false);
  bool get isCommittee => organizationUnitType == 5 || (typeName?.toLowerCase().contains('encümen') ?? false);
  bool get isDepartment => organizationUnitType == 3;

  /// Try to extract person name from unit name like "Seyfettin YILDIRIM Başkan Yardımcılığı".
  String? get extractedPersonName {
    if (!isDeputyMayor) return null;
    final n = name;
    final lower = n.toLowerCase();
    final idx = lower.indexOf('başkan yardımc');
    if (idx > 0) return n.substring(0, idx).trim();
    return null;
  }
}

class OrganizationAssignment {
  final int id;
  final int organizationUnitId;
  final String organizationUnitName;
  final int organizationPositionId;
  final String organizationPositionName;
  final String fullName;
  final String? titleOverride;
  final String? biography;
  final String? phone;
  final String? email;
  final String? profileFilePath;
  final bool isPrimary;

  const OrganizationAssignment({
    required this.id,
    required this.organizationUnitId,
    required this.organizationUnitName,
    required this.organizationPositionId,
    required this.organizationPositionName,
    required this.fullName,
    this.titleOverride,
    this.biography,
    this.phone,
    this.email,
    this.profileFilePath,
    this.isPrimary = false,
  });

  factory OrganizationAssignment.fromJson(Map<String, dynamic> j) =>
      OrganizationAssignment(
        id: j['id'] as int,
        organizationUnitId: j['organizationUnitId'] as int,
        organizationUnitName: j['organizationUnitName'] as String? ?? '',
        organizationPositionId: j['organizationPositionId'] as int? ?? 0,
        organizationPositionName: j['organizationPositionName'] as String? ?? '',
        fullName: j['fullName'] as String? ?? '',
        titleOverride: j['titleOverride'] as String?,
        biography: j['biography'] as String?,
        phone: j['phone'] as String?,
        email: j['email'] as String?,
        profileFilePath: j['profileFilePath'] as String?,
        isPrimary: j['isPrimary'] as bool? ?? false,
      );

  String get title => (titleOverride?.isNotEmpty ?? false)
      ? titleOverride!
      : organizationPositionName;

  String get profileUrl => ApiConfig.fullFileUrl(profileFilePath);
}

class OrganizationRepository {
  final ApiClient _client;
  OrganizationRepository(this._client);

  Future<List<OrganizationUnit>> fetchUnits() async {
    final raw = await _client.get('/api/public/organization/units');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(OrganizationUnit.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<OrganizationAssignment>> fetchAssignments(int unitId) async {
    final raw = await _client.get('/api/public/organization/units/$unitId/assignments');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(OrganizationAssignment.fromJson)
          .toList();
    }
    return [];
  }

  /// Fetches the primary assignment for each deputy-mayor unit.
  Future<List<OrganizationAssignment>> fetchAllDeputyMayors() async {
    final units = await fetchUnits();
    final deputyUnits = units.where((u) => u.isDeputyMayor).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final result = <OrganizationAssignment>[];
    final futures =
        deputyUnits.map((u) => fetchAssignments(u.id)).toList();
    final all = await Future.wait(futures);
    for (final list in all) {
      // Skip obvious test entries
      final filtered = list.where((a) =>
          !a.fullName.toLowerCase().contains('test') &&
          !a.fullName.toLowerCase().contains('deneme'));
      // Prefer primary assignment if exists
      final primary = filtered.where((a) => a.isPrimary).toList();
      if (primary.isNotEmpty) {
        result.add(primary.first);
      } else if (filtered.isNotEmpty) {
        result.add(filtered.first);
      }
    }
    return result;
  }

  Future<List<OrganizationUnit>> fetchDepartments() async {
    final units = await fetchUnits();
    return units.where((u) => u.isDepartment).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  Future<({OrganizationUnit? unit, List<OrganizationAssignment> assignments})>
      fetchCouncil() async {
    final units = await fetchUnits();
    OrganizationUnit? unit;
    for (final u in units) {
      if (u.isCouncil || u.name.toLowerCase().contains('meclis')) {
        unit = u;
        break;
      }
    }
    if (unit == null) {
      return (unit: null, assignments: <OrganizationAssignment>[]);
    }
    final list = await fetchAssignments(unit.id);
    return (unit: unit, assignments: list);
  }

  Future<({OrganizationUnit? unit, List<OrganizationAssignment> assignments})>
      fetchCommittee() async {
    final units = await fetchUnits();
    OrganizationUnit? unit;
    for (final u in units) {
      if (u.isCommittee || u.name.toLowerCase().contains('encümen')) {
        unit = u;
        break;
      }
    }
    if (unit == null) {
      return (unit: null, assignments: <OrganizationAssignment>[]);
    }
    final list = await fetchAssignments(unit.id);
    return (unit: unit, assignments: list);
  }
}

final organizationRepositoryProvider = Provider<OrganizationRepository>(
    (ref) => OrganizationRepository(ref.read(apiClientProvider)));

final deputyMayorsProvider =
    FutureProvider<List<OrganizationAssignment>>((ref) async {
  return ref.read(organizationRepositoryProvider).fetchAllDeputyMayors();
});

final departmentsProvider =
    FutureProvider<List<OrganizationUnit>>((ref) async {
  return ref.read(organizationRepositoryProvider).fetchDepartments();
});

typedef _UnitWithAssignments = ({
  OrganizationUnit? unit,
  List<OrganizationAssignment> assignments,
});

final councilProvider = FutureProvider<_UnitWithAssignments>((ref) async {
  return ref.read(organizationRepositoryProvider).fetchCouncil();
});

final committeeProvider = FutureProvider<_UnitWithAssignments>((ref) async {
  return ref.read(organizationRepositoryProvider).fetchCommittee();
});

final unitAssignmentsProvider =
    FutureProvider.family<List<OrganizationAssignment>, int>((ref, id) async {
  return ref.read(organizationRepositoryProvider).fetchAssignments(id);
});
