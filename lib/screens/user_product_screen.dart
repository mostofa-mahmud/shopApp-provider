part of screens;


class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context)async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<ProductsProvider>(context);


    return Scaffold(

      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

              Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,arguments: ''
              );

            },
          ),
        ],
      ),




      drawer: const Appdrawer(),


      body: RefreshIndicator(
        onRefresh: ()=> _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  productsData.items[i].id!,
                  productsData.items[i].title!,
                  productsData.items[i].imgUrl!,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),





    );
  }
}