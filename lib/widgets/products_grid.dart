part of widgets;

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    final products = showFavs? productData.favoriteItems : productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,

      itemBuilder: (ctx, i)=> ChangeNotifierProvider.value(
        value:  products[i],
        child: ProductItem(),
      ),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}