package com.enitec.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.enitec.vo.Image;

@Service
public class ContentService {

	public ArrayList<Image> getImgList(String middleURL, String requestSet, String page) {
		JSONArray jarr = getJsonArray(middleURL, requestSet,page);
		ArrayList<Image> imgList = getImgArr(jarr);
		return imgList;
	}

	private JSONArray getJsonArray(String middleURL, String resultSet, String page) {
		String apiKey = "638aa1b1cb8fa91819a382dabe206684";
		String BASE_URL = "https://api.themoviedb.org/3";
		String BASE_LANG = "ja";
		String BASE_REGION = "JP";
		try {
			URL url = new URL(
					BASE_URL + middleURL + "api_key=" + apiKey + "&language=" + BASE_LANG + "&region=" + BASE_REGION+"&page="+page);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			System.out.println(url);
			con.setDoOutput(true);
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json");
			BufferedReader br = new BufferedReader(new InputStreamReader((con.getInputStream())));
			String outputTmp;
			String output = "";
			while ((outputTmp = br.readLine()) != null) {
				output += outputTmp;
			}
			JSONArray jsonArray = new JSONObject(output).getJSONArray(resultSet);

			return jsonArray;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private ArrayList<Image> getImgArr(JSONArray jarr) {
		ArrayList<Image> imgList = new ArrayList<>();
		for (int i = 0; i < jarr.length(); i++) {
			JSONObject jo = jarr.getJSONObject(i);
			Image image = new Image();
			image.setCt_code(jo.getString("poster_path"));
			image.setImgPath(jo.getString("poster_path"));
			imgList.add(image);
		}
		return imgList;
	}
}
