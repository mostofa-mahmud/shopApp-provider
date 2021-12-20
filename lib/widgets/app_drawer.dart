part of widgets;

class Appdrawer extends StatelessWidget {
  const Appdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friends'),
            automaticallyImplyLeading: false,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),


          const Divider(),


          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage products'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}