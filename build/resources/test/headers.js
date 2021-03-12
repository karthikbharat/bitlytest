function() {
    var contentType = karate.get('Content_Type')?karate.get('Content_Type'):"application/json"
    var accept = karate.get('accept')?karate.get('accept'):"*/*"


    var Authorization = karate.get('Authorization')?karate.get('Authorization'):'Bearer 48a7fe60034be1eb264102c122d31ea48f4ef04e'
    var headers = {
                  "Content-Type": contentType,
                  "Authorization": Authorization,
                  "Accept": accept,

                  }
    return headers
}