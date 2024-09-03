import 'package:flutter/material.dart';
import 'package:movie1/Theme/dark_theme.dart';

class Rating extends StatelessWidget {
   Rating({super.key, required this.rating,required this.size});
  double rating;
  double size;
 

  @override
  Widget build(BuildContext context) {
   List<Widget>starList=[];
   int realNumber=rating.floor();
   for(int i=0;i<6;i++)
   {
    if(i<realNumber) {
      starList.add(Icon(Icons.star,color: darkTheme.primaryColor,size: size,));
    } else if(i==realNumber)
    {

    }
    else{
      starList.add(Icon(Icons.star,color:Colors.grey,size: size,));
    }
   }

   return Row(
    children: [
      for(int i=0;i<starList.length;i++)
        starList[i],
    ],
   );
  
  }
}