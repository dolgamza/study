package kr.co.dw;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Map {
	public static void main(String[] args) throws JSONException {
        try {
 
            String location = "경기도 수원시 장안구";
 
            String addr = "https://dapi.kakao.com/v2/local/search/address.json";
 
            String apiKey = "KakaoAK { 6daf71129d088b25834fa76342022b12 }";
 
            location = URLEncoder.encode(location, "UTF-8");
 
            String query = "query=" + location;
            
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(addr);
            stringBuffer.append("?");
            stringBuffer.append(query);
            
            System.out.println("stringBuffer.toString() "+ stringBuffer.toString());
            
            URL url = new URL(stringBuffer.toString());
            
            URLConnection conn = url.openConnection();
            
            conn.setRequestProperty("Authorization", apiKey);
            
            BufferedReader rd = null;
            
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            StringBuffer docJson = new StringBuffer();
            
            String line;
            
            while((line=rd.readLine())!=null){
                docJson.append(line);
            }
            
            if(0<docJson.toString().length()){
                System.out.println("docJson    :"+docJson.toString());
                
            }
            
            rd.close();
            
            JSONObject jsonObject = new JSONObject(docJson.toString());
            
            JSONArray jsonArray= (JSONArray) jsonObject.get("documents");
            
            JSONObject tempObj = (JSONObject) jsonArray.get(0);
                
            System.out.println("latitude : " + tempObj.getDouble("y"));
            System.out.println("longitude : " + tempObj.getDouble("x"));
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
    }

}
