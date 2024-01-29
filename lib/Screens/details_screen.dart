import 'package:abdullah1/Provider/Cart.dart';
import 'package:abdullah1/Screens/Home.dart';
import 'package:abdullah1/widget/Appbar.dart';
import 'package:abdullah1/widget/Item.dart';
import 'package:abdullah1/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
///////////

// ignore: must_be_immutable
class Details extends StatefulWidget {
  item product;
  Details({required this.product});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  //Details({Key? key}) : super(key: key);
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    final aaa =  Provider.of<Cart?>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('details'),
            backgroundColor:purple,
            actions: [
          Consumer<Cart>(
            builder: (context, aaa, child) {
              return const Padding(
                  padding: EdgeInsets.only(right: 8.0), child: appbar());
            },
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                         padding: EdgeInsets.only(top: 5),
                        height: 350,
                        //color: Colors.blue,
                        child: Image(
                          image: NetworkImage(widget.product.img),
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox (height: 15),
                Row(
                  children: [
                    Expanded(
                      child:
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              children: [
                            Row(

                              children: [
                                Expanded(
                                  child: Text(
                                    '${widget.product.price} \$ ',
                                    style: TextStyle(fontSize:23,color: Colors.red,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: purple,
                                          borderRadius: BorderRadius.circular(7)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('New',
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Row(
                                      children: const [
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 26),
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 26),
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 26),
                                        Icon(Icons.star,
                                            color: Colors.yellow, size: 26),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                  '${widget.product.name} ',
                                  style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox (height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit_location,
                                  size: 26,
                                  color: Colors.red,
                                ),
                                Text(
                                  '${widget.product.location} ',
                                  style: TextStyle(fontSize: 18,color: Colors.black45,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ],),
                          ),




                          ///////////////////////////////

                          SizedBox(width: 15),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Details : ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes. The "male" gametophyte, which produces non-motile sperm, is enclosed within pollen grains; the "female" gametophyte is contained within the ovule. When pollen from the anther of a flower is deposited on the stigma, this is called pollination. Some flowers may self-pollinate, producing seed using pollen from the same flower or a different flower of the same plant, but others have mechanisms to prevent self-pollination and rely on cross-pollination, when pollen is transferred from the anther of one flower to the stigma of another flower on a different individual of the same species.',
                            maxLines: isShowMore ? 3 : null,
                            overflow: TextOverflow.fade,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowMore = !isShowMore;
                                    });
                                  },
                                  child: Text(
                                      isShowMore ? 'Show More' : 'Show Less')),
                            ],
                          ),
                           Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                            Container(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {aaa?.add(Item[  6 ]);},
                                  child: Text(
                                    ' Add Card ',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll( purple),
                                      padding:
                                      MaterialStatePropertyAll(EdgeInsets.all(12)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15))))),
                            ),
                          ],)
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}




/*
Padding(
padding: const EdgeInsets.only(top: 8.0),
child: Expanded(
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('  ${widget.product.price} \$',
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold)),
],
),
),
),
///////////////


 Icon(
                                        Icons.edit_location,
                                        size: 26,
                                        color: Colors.blue,
                                      ),

                                      ////////////////////////




*/