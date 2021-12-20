part of screens;

class ProductDetailScreen extends StatelessWidget {

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context , listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 300,
              width: double.infinity,

              child: Image.network(
                loadedProduct.imgUrl,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10,),

            Text('\$${loadedProduct.price}', style: const TextStyle(color: Colors.grey, fontSize: 20),),

            const SizedBox(height: 10,),

            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                )
            )


          ],
        ),
      ),
    );
  }
}