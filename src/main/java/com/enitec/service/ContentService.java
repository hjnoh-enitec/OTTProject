package com.enitec.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.transaction.Transactional;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ContentRepository;
import com.enitec.repository.EpisodeRepository;
import com.enitec.repository.HistoryRepository;
import com.enitec.repository.SeasonRepository;
import com.enitec.vo.Content;
import com.enitec.vo.Episode;
import com.enitec.vo.History;
import com.enitec.vo.Image;
import com.enitec.vo.Season;

@Service
public class ContentService {

	@Autowired
	ContentRepository ctr;
	@Autowired
	SeasonRepository sr;
	@Autowired
	EpisodeRepository er;
	@Autowired
	HistoryRepository hr;

	String apiKey = "638aa1b1cb8fa91819a382dabe206684";
	String BASE_URL = "https://api.themoviedb.org/3";
	String BASE_LANG = "ja";
	String BASE_REGION = "JP";

	public ArrayList<Content> getMovie() {
		return ctr.getMovie();
	}

	public ArrayList<Content> getTv() {
		return ctr.getTv();
	}

	public ArrayList<Image> getImgList(String middleURL, String requestSet, String page) {
		JSONArray jarr = getJsonArray(middleURL, requestSet, page);
		ArrayList<Image> imgList = getImgArr(jarr);
		Collections.sort(imgList);
		return imgList;
	}

	public Content getContent(String ct_code) {
		return ctr.findById(ct_code).orElse(null);
	}

	public ArrayList<History> getPlayedList(String pf_code) {
		ArrayList<History> historyArr = hr.findAllByProfileCode(pf_code);
		String middleURL = "";
		for (int i = 0; i < historyArr.size(); i++) {
			if(historyArr.get(i)==null) {
				continue;
			}
			else if (historyArr.get(i).getCt_code().startsWith("T")) {
				Content content = getContent(historyArr.get(i).getCt_code());
				historyArr.get(i).setImgPath(content.getCt_path_thumbnail());
				historyArr.get(i).setPath(content.getCt_path());
			} else {

				if (historyArr.get(i).getE_number() == -1) {

					middleURL = "/movie/" + historyArr.get(i).getCt_code() + "?";
				} else {
					middleURL = "/tv/" + historyArr.get(i).getCt_code() + "?";
				}
				JSONObject object = getJsonObject(middleURL, "1");
				if (object != null) {
					String base = "https://image.tmdb.org/t/p/w200";
					String fileName = object.get("poster_path").toString();
					
					historyArr.get(i).setImgPath(base+fileName);
				}
				historyArr.get(i).setPath("test.mp4");
			}
		}
		return historyArr;

	}

	private JSONArray getJsonArray(String middleURL, String resultSet, String page) {

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

	private JSONObject getJsonObject(String middleURL, String page) {

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
			JSONObject jsonObject = new JSONObject(output);
			return jsonObject;
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
		ArrayList<Season> seasonArr = getSeasonList(tvArr);
		ArrayList<Episode> episodeArr = getEpisodesList(seasonArr);
		deleteEveryContent();
		saveArrayListInDb(contentArr);
		saveArrayListInDb(tvArr);
		saveSeasonArrayList(seasonArr);
		saveEpisodeArrayList(episodeArr);
	}

	private ArrayList<Episode> getEpisodesList(ArrayList<Season> season) {
		ArrayList<Episode> episodeArr = new ArrayList<>();
		for (int i = 0; i < season.size(); i++) {
			JSONArray jarr = getJsonArray(
					"/tv/" + season.get(i).getCt_code() + "/season/" + season.get(i).getS_number() + "?", "episodes",
					"1");
			for (int j = 0; j < jarr.length(); j++) {
				JSONObject jo = jarr.getJSONObject(j);
				System.out.println(jo.toString());
				Episode episode = new Episode();
				episode.setCt_code(season.get(i).getCt_code());
				episode.setE_code(Integer.toString(jo.getInt("id")));
				episode.setE_name(jo.getString("name"));
				episode.setE_path("path");
				String releaseDate = "2022-11-22";
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				episode.setE_release_Date(LocalDate.parse(releaseDate, formatter));
				episode.setS_code(season.get(i).getS_code());
				episode.setE_number(j + 1);
				episodeArr.add(episode);
			}
		}
		return episodeArr;
	}

	private ArrayList<Season> getSeasonList(ArrayList<Content> tv) {
		ArrayList<Season> seasonArr = new ArrayList<Season>();

		for (int i = 0; i < tv.size(); i++) {
			JSONArray jarr = getJsonArray("/tv/" + tv.get(i).getCt_code() + "?", "seasons", "1");
			for (int j = 0; j < jarr.length(); j++) {
				JSONObject jo = jarr.getJSONObject(j);
				Season season = new Season();
				season.setCt_code(tv.get(i).getCt_code());
				season.setS_code(Integer.toString(jo.getInt("id")));
				season.setS_name(jo.getString("name"));
				season.setS_info(jo.getString("overview"));
				season.setS_number((jo.getInt("season_number")));
				seasonArr.add(season);
			}
		}

		return seasonArr;
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
			String releaseData = "";
			if (!isTv) {
				content.setCt_title(jo.getString("title"));
				releaseData = jo.getString("release_date");
			} else {
				content.setCt_title(jo.getString("original_name"));
				releaseData = jo.getString("first_air_date");
			}
			content.setG_code("28");
			content.setCt_path_thumbnail((jo.getString("poster_path")));
			;
			content.setCt_star((jo.getInt("vote_average")));
			;
			if (jo.getString("overview").equals(null)) {
				content.setCt_info("dummy");
			} else {
				content.setCt_info(jo.getString("overview"));
			}
			String genres = jo.get("genre_ids").toString();
			Pattern pattern = Pattern.compile("\\[(.*?)\\]");
			Matcher matcher = pattern.matcher(genres);
			genres = "";
			while (matcher.find()) {
				genres += matcher.group(1);
			}
			content.setG_code(genres.split(",")[0].trim());
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			content.setCt_release_Date(LocalDate.parse(releaseData, formatter));
			contentArray.add(content);
		}
		return contentArray;
	}

	private void saveArrayListInDb(ArrayList<Content> target) {
		for (int i = 0; i < target.size(); i++) {
			ctr.save(target.get(i));
		}
	}

	private void saveSeasonArrayList(ArrayList<Season> target) {
		for (int i = 0; i < target.size(); i++) {
			sr.save(target.get(i));
		}

	}

	private void saveEpisodeArrayList(ArrayList<Episode> target) {
		for (int i = 0; i < target.size(); i++) {
			er.save(target.get(i));
		}
	}

	
	public List<Content> search(String keyword){
		return ctr.findByCt_titleContaining(keyword);
	}
}
