
import 'dart:convert';

import 'nft_details.dart';

class NfT {
  final String? id;
  final String? contractAddress;
  final String? name;
  final AssetPlatformId? assetPlatformId;
  final String? symbol;
  final NftDetails? details;

  NfT(
      {this.id,
      this.contractAddress,
      this.name,
      this.assetPlatformId,
      this.symbol,
      this.details});

  set details(NftDetails? details) {
    details = details;
  }

  factory NfT.fromRawJson(String str) => NfT.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NfT.fromJson(Map<String, dynamic> json) => NfT(
        id: json["id"],
        contractAddress: json["contract_address"],
        name: json["name"],
        assetPlatformId: assetPlatformIdValues.map[json["asset_platform_id"]]!,
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contract_address": contractAddress,
        "name": name,
        "asset_platform_id": assetPlatformIdValues.reverse[assetPlatformId],
        "symbol": symbol,
      };
}

enum AssetPlatformId {
  ETHEREUM,
  POLYGON_POS,
  OPTIMISTIC_ETHEREUM,
  ARBITRUM_ONE,
  AVALANCHE,
  BINANCE_SMART_CHAIN,
  KLAY_TOKEN,
  SOLANA
}

final assetPlatformIdValues = EnumValues({
  "arbitrum-one": AssetPlatformId.ARBITRUM_ONE,
  "avalanche": AssetPlatformId.AVALANCHE,
  "binance-smart-chain": AssetPlatformId.BINANCE_SMART_CHAIN,
  "ethereum": AssetPlatformId.ETHEREUM,
  "klay-token": AssetPlatformId.KLAY_TOKEN,
  "optimistic-ethereum": AssetPlatformId.OPTIMISTIC_ETHEREUM,
  "polygon-pos": AssetPlatformId.POLYGON_POS,
  "solana": AssetPlatformId.SOLANA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
