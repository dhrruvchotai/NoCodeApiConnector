import 'dart:convert';

class ResponseHandler{
  //parse response based on the content type
  static dynamic parseResponse(String responseBody, String? contentType){
    if(contentType == null || contentType.contains('application/json')){
      try{
        return jsonDecode(responseBody);
      }
      catch(e){
        return responseBody;
      }
    }
    return responseBody;
  }
}