import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/model/sku.dart';

class SkuDetailScreen extends StatelessWidget {
  final List<Sku> skuList;

  static Future<void> push(BuildContext context, List<Sku> skuList) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SkuDetailScreen(skuList: skuList),
        ),
      );

  const SkuDetailScreen({required this.skuList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: FutureBuilder<void>(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset('assets/images/success.gif'),
              );
            }
            return ListView.builder(
              itemCount: skuList.length,
              itemBuilder: (context, index) {
                final sku = skuList[index];
                return _SkuWidget(sku);
              },
            );
          },
        ),
      );
}

class _SkuWidget extends StatelessWidget {
  final Sku sku;

  const _SkuWidget(this.sku);

  @override
  Widget build(BuildContext context) {
    final imageUrl = sku.imageUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(sku.name),
          Text(sku.description),
          if (imageUrl != null) Image.network(imageUrl),
        ],
      ),
    );
  }
}
