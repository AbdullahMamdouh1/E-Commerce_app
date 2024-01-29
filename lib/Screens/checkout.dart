import 'package:abdullah1/Provider/Cart.dart';
import 'package:abdullah1/widget/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
///////////////////

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aaa =  Provider.of<Cart?>(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('checkot Screen'),
        actions: [
          const appbar()
        ],
      ),
      body: Column(
        children: [

          Expanded(
            flex: 2,
            child: SizedBox(
            height: 500,
              child: ListView.builder(
                 itemCount:  aaa?.selectedProdcts.length,

                 padding: const EdgeInsets.all(8),
                itemBuilder:(context, index) {
                return  Card(

                  child: ListTile(
                    subtitle: Row(
                      children: [
                        Text( '${aaa?.selectedProdcts[index].price} \$ - ${aaa?.selectedProdcts[index].location}'),

//
                      ],
                    ),
                     leading: CircleAvatar(backgroundImage:  NetworkImage(aaa?.selectedProdcts[index].img)),
                    title: Text( aaa?.selectedProdcts[index].name),
                     trailing: IconButton(onPressed:(){
                       aaa?.delete( aaa.selectedProdcts[index]);

                     }, icon:  const Icon(Icons.remove),
                  ),
                ));
              },),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Column(
              children: [
                ElevatedButton(onPressed:(){},
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                     shape: MaterialStatePropertyAll( RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                  ),
                    child:
                Text('Pay ${aaa?.price} \$',style: const TextStyle(fontSize: 19)),


                ),
              ],
            ),
          ),

        ],
      ),

    );
  }
}
