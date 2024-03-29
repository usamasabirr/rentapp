import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rentapp/models/posts_model.dart';

enum SearchMode {
  beforeSearch,
  afterSearch,
}

class SearchPostController extends GetxController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  RxList<PostsModel> postsList = <PostsModel>[].obs;
  TextEditingController searchTextContoller = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  Rx<bool> searchFilterEnabled = false.obs;
  Rx<bool> loading = false.obs;

  Rx<SearchMode> searchMode = SearchMode.beforeSearch.obs;
  String searchItem = '';

  getPosts(String query) async {
    print('search item get Post');
    loading.value = true;
    postsList.clear();
    query = query.toLowerCase();
    print(query.toLowerCase());
    var posts;
    try {
      if (fromController.text != '0' || toController.text != '10000') {
        print('first');
        print('fromController is ${fromController.text}');
        searchFilterEnabled.value = true;
        int from = int.parse(fromController.text);
        int to = int.parse(toController.text);
        posts = await _firebaseFirestore
            .collection('Posts')
            .where('subCategory', isEqualTo: query)
            .where('price', isGreaterThan: from)
            .where('price', isLessThan: to)
            .get();
      } else {
        print('second');
        searchFilterEnabled.value = false;
        posts = await _firebaseFirestore
            .collection('Posts')
            .where('subCategory', isEqualTo: query)
            .where('status', isEqualTo: 'approved')
            .get();
      }

      for (int i = 0; i < posts.docs.length; i++) {
        PostsModel temp = PostsModel.empty();
        temp.id = posts.docs[i]['id'];
        temp.category = posts.docs[i]['category'];
        temp.subCategory = posts.docs[i]['subCategory'];
        temp.price = posts.docs[i]['price'];
        temp.model = posts.docs[i]['model'];
        temp.description = posts.docs[i]['description'];
        temp.imagesUrl = posts.docs[i]['imagesUrl'];
        temp.address = posts.docs[i]['address'];
        temp.lat = posts.docs[i]['lat'];
        temp.lng = posts.docs[i]['lng'];
        temp.userId = posts.docs[i]['userId'];
        temp.favorites = posts.docs[i]['favorites'];
        temp.status = posts.docs[i]['status'];
        temp.startDate = posts.docs[i]['startDate'];
        temp.endDate = posts.docs[i]['endDate'];
        //temp.createdAt = posts.docs[i]['createdAt'];
        postsList.add(temp);
      }
      print('postsList ${postsList[0]}');
    } catch (err) {
      print('getPost error $err');
    }
    loading.value = false;
  }

  setPriceInitialValue() {
    if (fromController.text.isEmpty) {
      fromController.text = '0';
    }
    if (toController.text.isEmpty) {
      toController.text = '10,000';
    }
  }
}
