import 'package:flutter/material.dart';
import 'package:no_code_api_connector/no_code_api_connector.dart';

void main() {
  runApp(MaterialApp(
    home: Example(),
  ));
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Map<String, dynamic> productData = {};
  String postResponse = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  //set the fetched data
  Future<void> setData() async {
    Map<String, dynamic> fetchedData = await ApiService().fetchProduct();
    setState(() {
      productData = fetchedData;
    });
  }

  //post the data
  Future<void> postData() async {
    final response = await ApiService().createProduct();
    setState(() {
      postResponse = response.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('no_code_api_connector example')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GET Response:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(productData.toString()),
            const SizedBox(height: 20),
            Text('POST Response:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(postResponse),
            ElevatedButton(
              onPressed: postData,
              child: Text("Create Product (POST)"),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiService {
  //First add all the api configurations you need baseUrl,headers and make instance of ApiConfig class
  final apiConfig = ApiConfig(baseUrl: 'https://api.escuelajs.co/api/v1');

  //Function to fetch data
  Future<Map<String, dynamic>> fetchProduct() async {

    //then make instance of ApiConnector by passing instance of ApiConfig
    final connector = ApiConnector(apiConfig);

    //Then configure each request by
    final requestConfig = RequestConfig(
      method: HttpMethod.get,
      path: '/products/16',
    );

    //use sendRequest method to make request to the api
    Map<String, dynamic> fetchedData = await connector.sendRequest(requestConfig);
    return fetchedData;
  }
  //function to post the product data
  Future<Map<String, dynamic>> createProduct() async {

    final connector = ApiConnector(apiConfig);
    final requestConfig = RequestConfig(
      method: HttpMethod.post,
      path: '/products/',
      //add the data in body that you want to post
      body: {
        "title": "New Test Product",
        "price": 199,
        "description": "This is a test product",
        "categoryId": 1,
        "images": [
          "https://placeimg.com/640/480/any"
        ]
      },
    );

    final response = await connector.sendRequest(requestConfig);
    return response;
  }
}
