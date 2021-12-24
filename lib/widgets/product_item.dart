part of widgets;

class ProductItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: GridTile(

        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imgUrl!,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(

          leading: IconButton(
            onPressed: (){

              product.toggleFavoriteStatus();


            },
            icon: Icon(product.isFav! ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
          ),

          backgroundColor: Colors.black54,
          title: Text(product.title!, textAlign: TextAlign.center,),
          trailing: IconButton(
            onPressed: (){

              cart.addItem(product.id!, product.price!, product.title!);

              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Added item to the cart !', textAlign: TextAlign.center,),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: (){

                          cart.removeSingleItem(product.id!);

                        }
                    ),
                  )
              );

            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),

        ),
      ),
    );
  }
}