//This is the class that contains configuration of the individual requests.

//all the datatype is combined into one
enum HttpMethod{
  get,
  post,
  put,
  patch,
  delete
}
class RequestConfig{
  //Type of http method
  final HttpMethod method;
  //this path is the endpoint path which will be appended to the base url
  final String path;
  //query parameters
  final Map<String,dynamic>? queryParams;
  //only the specific headers for this request
  final Map<String,String> headers;

  //request body
  final dynamic body;
  //select whether to use auth for this request or not
  final bool useAuth;

  RequestConfig({
    required this.method,
    required this.path,
    this.queryParams,
    this.headers,
    this.body,
    this.useAuth = true
})

}