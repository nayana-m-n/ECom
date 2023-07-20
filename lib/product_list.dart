import 'package:cart_app/cart_model.dart';
import 'package:cart_app/cart_provider.dart';
import 'package:cart_app/cart_screen.dart';
import 'package:cart_app/db_helper.dart';
import 'package:cart_app/wishlist_screen.dart';
import 'package:flutter/material.dart' ;
import 'package:badges/badges.dart'as badges;
import 'package:provider/provider.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper ? dbHelper = DBHelper();//calling DEHlper
  List<bool> wish = [false,false,false,false];
  List<String> shirtName =['CELIO','HIGHLANDER','DUKE','BEWAKOOF',];
  List<int> price =[500,1200,1300,1800,];
  List<String> shirtImages =['assets/t1.jpeg','assets/t2.jpeg','assets/t3.jpeg','assets/t4.jpeg',];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return  Scaffold(
      appBar:  AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions:   [

         Row(
           children: [
             InkWell(
               onTap:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>WishlistScreen()));
               },
               child: Center(
                 child: Icon(Icons.favorite_border_outlined),
               ),
             ),

             //WishList
             const SizedBox(width: 20.0),
             InkWell(
               onTap:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
               },
               child: Center(
                 child: badges.Badge(
                   badgeContent: Consumer<CartProvider>(
                     builder: (context,value,child){
                       return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),
                       );

                     },
                   ),
                   badgeAnimation: badges.BadgeAnimation.rotation(
                       animationDuration: Duration(seconds: 1)
                   ) ,
                   child: Icon(Icons.shopping_bag_outlined),
                 ),
               ),
             ),

           ],
         ),

          SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: shirtName.length,
                itemBuilder:(context,index){
            return  Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(shirtImages[index].toString(),height: 100,width: 100,),//Accessing Image
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shirtName[index].toString(),
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(""r"$" + price[index].toString() ,
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),



                               InkWell(
                                onTap: (){
                                  dbHelper!.insertWishlist(
                                      Cart(id: index,
                                          shirtId: index.toString(),
                                          shirtName: shirtName[index].toString(),
                                          shirtPrice: price[index],
                                          image: shirtImages[index].toString())
                                  ).then((value) => wish[index] =!wish[index]);
                                },
                                child: Icon(Icons.favorite_border_outlined,
                                color:wish[index]?Colors.red : Colors.black),
                              ),



                              const SizedBox(height: 5),

                              //Add to cart
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: (){
                                    dbHelper!.insert(
                                      Cart(id: index,
                                          shirtId: index.toString(),
                                          shirtName: shirtName[index].toString(),
                                          shirtPrice: price[index],
                                          image: shirtImages[index].toString())
                                    ).then((value){
                                        print('Product is Add to cart');
                                        cart.addCounter();
                                    }).onError((error, stackTrace){
                                      print(error.toString());
                                    });
                                  },
                                  child: Container(
                                    height:35,
                                    width:100,
                                    decoration:BoxDecoration(
                                      color:Colors.green,
                                      borderRadius:BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text("Add to cart", style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )

                      ],
                    )
                  ],
                ),
              ),
            );
          }),
          ),
        ],
      ),
    );
  }
}
