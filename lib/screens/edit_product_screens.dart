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
      id: null.toString(),
      title: '',
      description: '',
      price: 0,
      imgUrl: ''
  );





  void initState(){
    _imageUrlFocusNode.addListener((_upadateImageUrl));
    super.initState();
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
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {

      });
    }
  }

  void _saveForm(){
    final isValid = _form.currentState!.validate();
    if(!isValid){
      return;
    }
    _form.currentState!.save();
    print(_editedProduct.id);
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.imgUrl);
    print(_editedProduct.price);
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



      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _form,

          child: ListView(
            children: <Widget>[

              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: null.toString(),
                      title: value.toString(),
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imgUrl: _editedProduct.imgUrl
                  );
                },
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please provide a value';
                  }else {
                    return null;
                  }
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: null.toString(),
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value.toString()),
                      imgUrl: _editedProduct.imgUrl
                  );
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value){
                  _editedProduct = Product(
                      id: null.toString(),
                      title: _editedProduct.title,
                      description: value.toString(),
                      price: _editedProduct.price,
                      imgUrl: _editedProduct.imgUrl
                  );
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
                            id: null.toString(),
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imgUrl: value.toString()
                        );
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