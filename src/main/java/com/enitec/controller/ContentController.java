package com.enitec.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/content")
public class ContentController {

	@GetMapping("/main")
	public String moveToContentPage(Model model) {
		try {
			String apiKey = "638aa1b1cb8fa91819a382dabe206684";
			String BASE_URL = "https://api.themoviedb.org/3";
			String BASE_LANG = "jp";
			String BASE_REGION = "JP";
			String page = "1";
			String genre = "action";

			URL url = new URL(BASE_URL + "/movie/popular?genre="+genre+"&api_key=" + apiKey + "&language=" + BASE_LANG + "&region="
					+ BASE_REGION);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setDoOutput(true);
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json");
			BufferedReader br = new BufferedReader(new InputStreamReader((con.getInputStream())));
			String outputTmp;
			String output = "";
			while ((outputTmp = br.readLine()) != null) {
				output += outputTmp;
			}
			System.out.println(output);
			JSONArray jsonArray = new JSONObject(output).getJSONArray("results");
			model.addAttribute("jsonArray", jsonArray);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "content/content";
	}
	@GetMapping("/test")
	public String test() {
		System.out.println("hey");
		return "content/contentTest";
	}

}
