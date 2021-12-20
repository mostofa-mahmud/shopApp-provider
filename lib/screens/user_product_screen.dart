part of screens;


class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-products';

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
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),




      drawer: const Appdrawer(),


      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                productsData.items[i].title,
                productsData.items[i].imgUrl,
              ),
              const Divider(),
            ],
          ),
        ),
      ),





    );
  }
}