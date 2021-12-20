part of widgets;

class CartItems extends StatelessWidget {
  //const CartItem({Key? key}) : super(key: key);

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItems(this.id,this.productId ,this.title,this.price, this.quantity);

  @override
  Widget build(BuildContext context) {

    return Dismissible(

      direction: DismissDirection.endToStart,
      onDismissed: (direction){

        Provider.of<Cart>(context, listen: false).removeItem(productId);

      },
      confirmDismiss: (direction){
        return showDialog(
            context: context,
            builder: (ctx)=> AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Dou tou wnt to delete item from the cart? '),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(ctx).pop(false);
                    },
                    child: const Text('No')
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(ctx).pop(true);
                    },
                    child: const Text('Yes')
                )
              ],
            )
        );
      },

      key: ValueKey(id),

      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 40,),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),


      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),

        child: Padding(
          padding: const EdgeInsets.all(8),


          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),



        ),
      ),
    );
  }
}