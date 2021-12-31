part of screens;

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final  _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imgUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imgUrl': '',
  };

  var _isInit = true;
  var _isLoding = false;

  @override
  void initState(){
    _imageUrlFocusNode.addListener(_upadateImageUrl);
    super.initState();
  }



  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId.isNotEmpty) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title!,
          'description': _editedProduct.description!,
          'price': _editedProduct.price!.toString(),
          'imgUrl': '',
        };
        _imageUrlController.text = _editedProduct.imgUrl!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }



  void dispose(){
    _imageUrlFocusNode.removeListener(_upadateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _upadateImageUrl(){
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }




  void _saveForm(){
    final isValid = _form.currentState!.validate();
    if(!isValid){
      return;
    }
    _form.currentState!.save();

    setState(() {

      _isLoding = true;
    });

    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
      setState(() {
        _isLoding = false;
      });
      Navigator.of(context).pop();
    }
    else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error){
        return showDialog(
          context: context,
          builder: (ctx)=> AlertDialog(
            title: const Text('An error occurred !'),
            content: const Text('something went wrong'),
            actions: [
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoding = false;
        });
        Navigator.of(context).pop();
      });
    }
  }










  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: _saveForm,
              icon: const Icon(Icons.save)
          )
        ],
      ),



      body: _isLoding? const Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _form,

          child: ListView(
            children: <Widget>[

              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imgUrl: _editedProduct.imgUrl,
                      isFav: _editedProduct.isFav
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please provide a title.';
                  }else {
                    return null;
                  }
                },
              ),

              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imgUrl: _editedProduct.imgUrl,
                      isFav: _editedProduct.isFav
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter a price.';
                  }
                  if(double.tryParse(value) == null){
                    return 'Please enter a valid number.';
                  }
                  if(double.parse(value) <= 0){
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
              ),

              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value,
                      price: _editedProduct.price,
                      imgUrl: _editedProduct.imgUrl,
                      isFav: _editedProduct.isFav
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please provide a Description.';
                  }
                  if(value.length < 10){
                    return 'Should be at least 10 char long.';
                  }
                  else {
                    return null;
                  }
                },
              ),


              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8 , right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.grey
                        )
                    ),
                    child: _imageUrlController.text.isEmpty? const Text('Enter URl') : FittedBox(
                      child: Image.network(
                        _imageUrlController.text.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL',),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value){
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imgUrl: value,
                            isFav: _editedProduct.isFav
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              )




            ],
          ),
        ),
      ),




    );
  }
}