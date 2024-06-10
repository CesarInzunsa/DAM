import 'package:flutter/material.dart';

class NavTabDestination {
  static AppBar getNavTabDestination() {
    return AppBar(
      //backgroundColor: Colors.orange[50],
      toolbarHeight: 0.0,
      bottom: TabBar(
        //indicatorColor: Colors.orange[100],
        //labelColor: Colors.black,
        //unselectedLabelColor: Colors.black54,
        isScrollable: true,
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list),
                SizedBox(width: 8),
                Text('Listar'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.manage_search_outlined),
                SizedBox(width: 8),
                Text('Consultar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
