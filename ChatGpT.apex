public class ChatGPT {
  @AuraEnabled
    public static String getChatGPTResult(String searchString){
        
        try{
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +searchString+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';
            System.debug('Query '+searchString+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.openai.com/v1/completions');
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+('sk-########################################'));
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json');
            // Set the body as a JSON object
            request.setBody(reqBody);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            System.debug(response.getBody());
            return response.getbody();

        }catch(Exception ex){
            System.debug('Exception in Catch of Server-Side Controller '+ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
