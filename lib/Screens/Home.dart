import 'package:abdullah1/Provider/Cart.dart';
import 'package:abdullah1/Screens/details_screen.dart';
import 'package:abdullah1/widget/Appbar.dart';
import 'package:abdullah1/widget/Item.dart';
import 'package:abdullah1/widget/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class Home extends StatelessWidget {





  const Home({Key? key, }) : super(key: key);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image2.jpg'))),
                    currentAccountPicture: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/image1.jpg')),
                    accountName: Text('Abdullah Mamdouh'),
                    accountEmail: Text('abdullah240@gmaile.com')),
                const ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home,color: purple),
                ),
                const ListTile(
                  title: Text('My Products'),
                  leading: Icon(Icons.shopping_cart_checkout,color: purple),
                ),
                const ListTile(
                  title: Text(' About'),
                  leading: Icon(Icons.help,color: purple),
                ),
                ListTile(
                  title: const Text(' Logout'),
                  leading: const Icon(Icons.exit_to_app,color: purple),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },

                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Developed by Abdullah Mamdouh @ 2023',
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Home'),
          backgroundColor: purple,actions: [
        Consumer<Cart>(
          builder: (context, aaa, child) {
            return const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: appbar(),
            );
          },
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0,),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 14,
                mainAxisSpacing: 15),
            itemCount: Item.length,
            padding: const EdgeInsets. only(top:  10,bottom: 15),
            itemBuilder: (BuildContext context,  index) {










              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(product: Item[index],),

                    ),

                  );
                },
                child: Card(
                  shadowColor: Colors.blue.shade400 ,
                  elevation:5,
                  shape:   RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),

                  ),
                  child: GridTile(

                    footer: GridTileBar(


                      backgroundColor: Colors.white70,
                      trailing: Consumer<Cart>(
                        builder: (context, aaa, child) {
                          return IconButton(
                              onPressed: () {
                                aaa.add(Item[ index]);
                              },
                              icon:   const CircleAvatar(
                                backgroundColor: purple,
                                radius: 15,
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ));
                        },
                      ),
                      leading: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('${Item[index].name}',style: const TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black45 )),
                          ),
                          const SizedBox (height: 3),
                          Text('${Item[index].price} \$',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),

                        ],
                      ),
                      title: const Text(''),

                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                            image: NetworkImage(
                              Item[index].img,
                            ),
                            fit: BoxFit.fill)),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
