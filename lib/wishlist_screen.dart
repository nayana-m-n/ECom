import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart'as badges;
import 'cart_model.dart';
import 'cart_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Wishlist Products'),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body: Column(
        children: [
          FutureBuilder(future: cart.getWishlistData(),
            builder: (context,AsyncSnapshot<List<Cart>> snapshot){
              if(snapshot.hasData){
                return Expanded(
                    child:ListView.builder(
                        itemCount: snapshot?.data?.length,
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
                                      Image.asset(snapshot.data![index].image.toString(),height: 100,width: 100,),//Accessing Image
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].shirtName.toString(),
                                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(""r"$" + snapshot.data![index].shirtPrice.toString() ,
                                              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 5),
                                            // Align(
                                            //   alignment: Alignment.centerRight,
                                            //   child: InkWell(
                                            //     onTap: (){
                                            //
                                            //     },
                                            //     child: Container(
                                            //       height:35,
                                            //       width:100,
                                            //       decoration:BoxDecoration(
                                            //         color:Colors.green,
                                            //         borderRadius:BorderRadius.circular(5),
                                            //       ),
                                            //       child: const Center(
                                            //         child: Text("Add to cart", style: TextStyle(color: Colors.white),
                                            //
                                            //
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      )

                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                );
              }
              return Text('');
            },)
        ],
      ),
    );
  }
}
