package com.enitec.service;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileSaveService {
	
	//public String root = "C:/LeeTJ/WorkSpace_lee_Spring/OTTProject/src/main/resources/static";
	public String root = "C:/SimYeonghwan/eclipse_yhsim/Clone/OTTProject/src/main/resources/static";
	//public String root = "C:/Users/ENITEC/Desktop/OTTProject/OTTProject/src/main/resources/static";

	public String thumbnail = "/img/thumbnail/";
	public String profile = "/img/profile/";
	public String base = "/img/baseImage/";
	public String defaultProfileImageName = "basicProfileImage.jpg";
	public String defaultThumbnailImageName = "basicThumbnailImage.jpg";
	
	public boolean uploadFile(MultipartFile uploadFile, String fileName) {
		String profilePath = root+profile + fileName;
		String thumbnailPath = root + thumbnail + fileName;
		try {
				InputStream in = uploadFile.getInputStream();
				BufferedImage originImage = ImageIO.read(in);
				int type = originImage.getType();
				BufferedImage profileImage = resizeImage(originImage,type,150,150);
				BufferedImage thumbnailImage = resizeImage(originImage,type,25,25);
				ImageIO.write(profileImage, "jpg", new File(profilePath));
				ImageIO.write(thumbnailImage, "jpg", new File(thumbnailPath));
				in.close();
		}
		catch(Exception e) {
			return false;
		}
		return true;
	}
	private BufferedImage resizeImage(BufferedImage originalImage, int type,int width,int height) {
		BufferedImage resizedImage = new BufferedImage(width,height,type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage,0,0,width,height,null);
		g.dispose();
		
		return resizedImage;
	}
}