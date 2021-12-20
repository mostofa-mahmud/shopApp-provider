part of screens;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("your cart"),

      ),
      body: Column(
        children: [

          Card(
            margin: const EdgeInsets.all(15),

            child: Padding(
              padding: const EdgeInsets.all(8),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text('Total',
                    style: TextStyle(fontSize: 20),
                  ),

                  const Spacer(),

                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  const SizedBox(width: 10,),


                  ElevatedButton(
                    onPressed: (){

                      Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);

                      cart.clear();


                    },
                    child: const Text('Order Now', style: TextStyle(color: Colors.purple),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white
                    ),
                  )

                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),

          Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItems(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].title,
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity
                ),
              )
          )
        ],
      ),
    );
  }
}