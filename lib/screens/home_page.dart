import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_newapp/screens/details.dart';
import 'package:firebase_with_newapp/screens/fav.dart';
import 'package:firebase_with_newapp/screens/filter.dart';
import 'package:firebase_with_newapp/screens/post.dart';
import 'package:firebase_with_newapp/screens/profile.dart';
import 'package:firebase_with_newapp/screens/search.dart';
import 'package:firebase_with_newapp/screens/time_line.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int currentIndex =2;

  final List<Widget>listOfScreen=const[
    TimeLine(),
    FavoritScreen(),
    Profile(),
    PostScreen(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      return const SizedBox();
    }
    return Scaffold(
      appBar: AppBar(),
      body:listOfScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex : currentIndex,
        onTap: (index){
          if (index ==2){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostScreen(),),);
         return;
          }setState(()=> currentIndex=index);
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor:Colors.black ,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),
          label: 'home'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),
              label: 'fav'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people_sharp),
              label: 'profile'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.post_add),
              label: 'post'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search_off),
              label: 'search'
          ),


        ],
      ),
    );
  }
}
