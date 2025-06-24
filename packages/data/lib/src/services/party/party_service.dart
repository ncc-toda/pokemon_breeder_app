import 'dart:developer' as developer;

import 'package:domain/src/features/party/party.dart' as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../local_storage/database.dart';
import '../local_storage/local_database_provider.dart';

part 'party_service.g.dart';

/// パーティ関連のビジネスロジックを提供するサービス。
class PartyService {
  /// パーティサービスを作成する。
  const PartyService(this._database);

  final LocalDatabase _database;

  /// すべてのパーティを取得する。
  Future<List<domain.Party>> getAllParties() async {
    try {
      developer.log('Getting all parties from database', name: 'PartyService');
      final parties = await _database.getAllParties();
      developer.log('Retrieved ${parties.length} parties from database', name: 'PartyService');
      final domainParties = parties.map(_convertToEntity).toList();
      developer.log('Converted to ${domainParties.length} domain parties', name: 'PartyService');
      return domainParties;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to get all parties: $error',
        name: 'PartyService',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// ID でパーティを取得する。
  Future<domain.Party?> getPartyById(int id) async {
    final parties = await _database.getAllParties();
    final party = parties.where((p) => p.id == id).firstOrNull;
    return party != null ? _convertToEntity(party) : null;
  }

  /// 新しいパーティを作成する。
  Future<domain.Party> createParty(String name) async {
    try {
      developer.log('Creating new party: $name', name: 'PartyService');
      final companion = PartiesCompanion.insert(
        name: name,
        pokemonIds: const [],
      );

      final id = await _database.insertParty(companion);
      developer.log('Party created with ID: $id', name: 'PartyService');
      
      final parties = await _database.getAllParties();
      final createdParty = parties.where((p) => p.id == id).first;
      
      final domainParty = _convertToEntity(createdParty);
      developer.log('Party converted to domain entity: ${domainParty.name}', name: 'PartyService');
      return domainParty;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to create party: $error',
        name: 'PartyService',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// パーティを更新する。
  Future<void> updateParty(domain.Party party) async {
    final dbParty = await _database
        .getAllParties()
        .then((parties) => parties.where((p) => p.id == party.id).first);

    final updatedParty = dbParty.copyWith(
      name: party.name,
      pokemonIds: party.pokemonIds.map((id) => id.toString()).toList(),
      updatedAt: party.updatedAt,
    );

    await _database.updateParty(updatedParty);
  }

  /// パーティを削除する。
  Future<void> deleteParty(int id) async {
    await _database.deleteParty(id);
  }

  /// データベースのPartyをドメインのPartyエンティティに変換する。
  domain.Party _convertToEntity(Party partyData) {
    return domain.Party(
      id: partyData.id,
      name: partyData.name,
      pokemonIds: partyData.pokemonIds.map((id) => int.parse(id)).toList(),
      createdAt: partyData.createdAt,
      updatedAt: partyData.updatedAt,
    );
  }
}

/// PartyService の Provider を定義。
@riverpod
PartyService partyService(ref) {
  final database = ref.read(localDatabaseProvider);
  return PartyService(database);
}
