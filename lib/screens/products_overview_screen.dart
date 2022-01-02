part of screens;


enum FilterOption{
  Favorite,
  All,
}


class ProductOverviewScreens extends StatefulWidget {

  @override
  State<ProductOverviewScreens> createState() => _ProductOverviewScreensState();
}

class _ProductOverviewScreensState extends State<ProductOverviewScreens> {
  var _showonlyFavorite = false;
  var _isInit = true;
  var _isLoading = false;


  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {

        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_){
        setState(() {

          _isLoading = false;
        });

      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    //final cart = Provider.of<Cart>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),

        actions: [

          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Only Favorite'), value: FilterOption.Favorite,),
              const PopupMenuItem(child: Text('Show All'), value: FilterOption.All,),

            ],

            onSelected: (FilterOption selectedValue){

              setState(() {

                if(selectedValue == FilterOption.Favorite){
                  _showonlyFavorite = true;
                }
                else{
                  _showonlyFavorite = false;
                }
              });
            },
          ),

          Consumer<Cart>( builder: (_, cart, ch)=> Badge(

            child: ch!,
            value: cart.itemCount.toString(),
            color: Colors.red,
          ),
            child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart)
            ),
          )
        ],
      ),

      drawer: const Appdrawer(),


      body: _isLoading? const Center(child: CircularProgressIndicator(),) : ProductsGrid(_showonlyFavorite),


    );
  }
}