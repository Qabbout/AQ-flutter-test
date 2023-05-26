import 'package:flutter/material.dart';

import '../Models/nft.dart';
import '../Models/nft_details.dart';
import '../Utitlies/api_service.dart';

final class NFTsScreen extends StatefulWidget {
  const NFTsScreen({super.key});
  @override
  State<NFTsScreen> createState() => _NFTsScreenState();
}

class _NFTsScreenState extends State<NFTsScreen> {
  List<NfT> nftsList = [];
  bool isLoading = false;
  int page = 1;

  final ScrollController _scrollController = ScrollController();

  Future getData() {
    return Future.wait([
      ApiService()
          .getNFTs(UrlBuilder(
              path: 'api/v3/nfts/list',
              queryParameters: {'per_page': '3', 'page': '$page'}))
          .then((value) => {
                setState(() {
                  nftsList = value;
                  isLoading = false;
                }),
                nftsList.asMap().forEach((index, value) async {
                  NftDetails nftDetails = await ApiService().getNFTDetails(
                    UrlBuilder(
                      path: 'api/v3/nfts/${value.id}',
                    ),
                  );
                  setState(() {
                    nftsList[index].details = nftDetails;
                  });
                })
              })
    ]);
  }

  @override
  void initState() {
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          if (page < 20) {
            page++;
            getData();
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Coingecko NFTs'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: nftsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.amber,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[Text(nftsList[index].name ?? "")],
              ),
            ),
          );
        },
      ),
    );
  }
}
