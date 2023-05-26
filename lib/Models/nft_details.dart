import 'dart:convert';

class NftDetails {
  final String? id;
  final String? contractAddress;
  final String? assetPlatformId;
  final String? name;
  final String? symbol;
  final Image? image;
  final String? description;
  final String? nativeCurrency;
  final FloorPrice? floorPrice;
  final FloorPrice? marketCap;
  final FloorPrice? volume24H;
  final double? floorPriceInUsd24HPercentageChange;
  final int? numberOfUniqueAddresses;
  final double? numberOfUniqueAddresses24HPercentageChange;
  final double? volumeInUsd24HPercentageChange;
  final int? totalSupply;
  final Links? links;

  NftDetails({
    this.id,
    this.contractAddress,
    this.assetPlatformId,
    this.name,
    this.symbol,
    this.image,
    this.description,
    this.nativeCurrency,
    this.floorPrice,
    this.marketCap,
    this.volume24H,
    this.floorPriceInUsd24HPercentageChange,
    this.numberOfUniqueAddresses,
    this.numberOfUniqueAddresses24HPercentageChange,
    this.volumeInUsd24HPercentageChange,
    this.totalSupply,
    this.links,
  });

  factory NftDetails.fromRawJson(String str) =>
      NftDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NftDetails.fromJson(Map<String, dynamic> json) => NftDetails(
        id: json["id"],
        contractAddress: json["contract_address"],
        assetPlatformId: json["asset_platform_id"],
        name: json["name"],
        symbol: json["symbol"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        description: json["description"],
        nativeCurrency: json["native_currency"],
        floorPrice: json["floor_price"] == null
            ? null
            : FloorPrice.fromJson(json["floor_price"]),
        marketCap: json["market_cap"] == null
            ? null
            : FloorPrice.fromJson(json["market_cap"]),
        volume24H: json["volume_24h"] == null
            ? null
            : FloorPrice.fromJson(json["volume_24h"]),
        floorPriceInUsd24HPercentageChange:
            json["floor_price_in_usd_24h_percentage_change"]?.toDouble(),
        numberOfUniqueAddresses: json["number_of_unique_addresses"],
        numberOfUniqueAddresses24HPercentageChange:
            json["number_of_unique_addresses_24h_percentage_change"]
                ?.toDouble(),
        volumeInUsd24HPercentageChange:
            json["volume_in_usd_24h_percentage_change"]?.toDouble(),
        totalSupply: json["total_supply"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contract_address": contractAddress,
        "asset_platform_id": assetPlatformId,
        "name": name,
        "symbol": symbol,
        "image": image?.toJson(),
        "description": description,
        "native_currency": nativeCurrency,
        "floor_price": floorPrice?.toJson(),
        "market_cap": marketCap?.toJson(),
        "volume_24h": volume24H?.toJson(),
        "floor_price_in_usd_24h_percentage_change":
            floorPriceInUsd24HPercentageChange,
        "number_of_unique_addresses": numberOfUniqueAddresses,
        "number_of_unique_addresses_24h_percentage_change":
            numberOfUniqueAddresses24HPercentageChange,
        "volume_in_usd_24h_percentage_change": volumeInUsd24HPercentageChange,
        "total_supply": totalSupply,
        "links": links?.toJson(),
      };
}

class FloorPrice {
  final double? nativeCurrency;
  final double? usd;

  FloorPrice({
    this.nativeCurrency,
    this.usd,
  });

  factory FloorPrice.fromRawJson(String str) =>
      FloorPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FloorPrice.fromJson(Map<String, dynamic> json) => FloorPrice(
        nativeCurrency: json["native_currency"]?.toDouble(),
        usd: json["usd"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "native_currency": nativeCurrency,
        "usd": usd,
      };
}

class Image {
  final String? small;

  Image({
    this.small,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        small: json["small"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
      };
}

class Links {
  final String? homepage;
  final String? twitter;
  final String? discord;

  Links({
    this.homepage,
    this.twitter,
    this.discord,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        homepage: json["homepage"],
        twitter: json["twitter"],
        discord: json["discord"],
      );

  Map<String, dynamic> toJson() => {
        "homepage": homepage,
        "twitter": twitter,
        "discord": discord,
      };
}
