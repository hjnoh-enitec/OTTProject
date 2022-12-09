package com.enitec.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;

import javax.transaction.Transactional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ContentRepository;
import com.enitec.vo.Content;
import com.enitec.vo.Image;

@Service
public class ContentService {

	@Autowired
	ContentRepository ctr;

	public ArrayList<Image> getImgList(String middleURL, String requestSet, String page) {
		JSONArray jarr = getJsonArray(middleURL, requestSet, page);
		ArrayList<Image> imgList = getImgArr(jarr);
		Collections.sort(imgList);
		return imgList;
	}
	private ArrayList<Image> getPlayedList(String pfCode){
		
		return null;
	}
	private JSONArray getJsonArray(String middleURL, String resultSet, String page) {
		String apiKey = "638aa1b1cb8fa91819a382dabe206684";
		String BASE_URL = "https://api.themoviedb.org/3";
		String BASE_LANG = "ja";
		String BASE_REGION = "JP";
		try {
			URL url = new URL(BASE_URL + middleURL + "api_key=" + apiKey + "&language=" + BASE_LANG + "&region="
					+ BASE_REGION + "&page=" + page);
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

	public void deleteEveryContent() {
		ctr.deleteAll();
	}

	@Transactional
	public void setContent(String movieURL, String tvURL, String jsonName, String requestPage) {
		JSONArray movie = getJsonArray(movieURL, jsonName, requestPage);
		JSONArray tv = getJsonArray(tvURL, jsonName, requestPage);
		ArrayList<Content> contentArr = getContentArr(movie, false);
		ArrayList<Content> tvArr = getContentArr(tv, true);
		deleteEveryContent();
		saveArrayListInDb(contentArr);
		saveArrayListInDb(tvArr);
	}

	private ArrayList<Image> getImgArr(JSONArray jarr) {
		ArrayList<Image> imgList = new ArrayList<>();
		for (int i = 0; i < jarr.length(); i++) {
			JSONObject jo = jarr.getJSONObject(i);
			Image image = new Image();
			image.setCt_code(Integer.toString(jo.getInt("id")));
			image.setThumbnail(jo.getString("poster_path"));
			image.setPopularity(jo.getInt("popularity"));
			imgList.add(image);
		}
		return imgList;
	}

	private ArrayList<Content> getContentArr(JSONArray jarr, boolean isTv) {
		
		ArrayList<Content> contentArray = new ArrayList<>();
		for (int i = 0; i < jarr.length(); i++) {
			JSONObject jo = jarr.getJSONObject(i);
			Content content = new Content();
			content.setCt_code(Integer.toString(jo.getInt("id")));
			if (!isTv) {
				content.setCt_title(jo.getString("title"));
			} else {
				content.setCt_title(jo.getString("original_name"));
			}
			content.setG_code("28");
			content.setCt_genre("action");
			content.setThumbnail(jo.getString("poster_path"));
			content.setPopularity(jo.getInt("popularity"));
			if(jo.getString("overview").equals(null)) {
				content.setCt_info("dummy");
			}else {
				content.setCt_info(jo.getString("overview"));
			}
			contentArray.add(content);
		}
		return contentArray;
	}

	private void saveArrayListInDb(ArrayList<Content> target) {
		for (int i = 0; i < target.size(); i++) {
			ctr.save(target.get(i));
		}
	}
}
