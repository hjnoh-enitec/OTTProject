package com.enitec.service;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@Component
public class FileSaveService {
	@Value("${path.filePath}")
	private String filePathRoot;
	@Value("/img/thumbnail/")
	private String thumbnail;
	@Value("/img/profile/")
	private String profile;
	@Value("/img/baseImage/")
	private String base;
	@Value("basicProfileImage.jpg")
	private String defaultProfileImageName;
	@Value("basicThumbnailImage.jpg")
	private String defaultThumbnailImageName;
	@Transactional
	public boolean uploadFile(MultipartFile uploadFile, String fileName) {
		String profilePath = filePathRoot + profile + fileName;
		String thumbnailPath = filePathRoot + thumbnail + fileName;
		try {
			InputStream in = uploadFile.getInputStream();
			BufferedImage originImage = ImageIO.read(in);
			int type = originImage.getType();
			BufferedImage profileImage = resizeImage(originImage, type, 150, 150);
			BufferedImage thumbnailImage = resizeImage(originImage, type, 25, 25);
			ImageIO.write(profileImage, "jpg", new File(profilePath));
			ImageIO.write(thumbnailImage, "jpg", new File(thumbnailPath));
			in.close();
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Transactional
	private BufferedImage resizeImage(BufferedImage originalImage, int type, int width, int height) {
		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, width, height, null);
		g.dispose();

		return resizedImage;
	}

	public String getFilePathRoot() {
		return filePathRoot;
	}

	public void setFilePathRoot(String filePathRoot) {
		this.filePathRoot = filePathRoot;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getDefaultProfileImageName() {
		return defaultProfileImageName;
	}

	public void setDefaultProfileImageName(String defaultProfileImageName) {
		this.defaultProfileImageName = defaultProfileImageName;
	}

	public String getDefaultThumbnailImageName() {
		return defaultThumbnailImageName;
	}

	public void setDefaultThumbnailImageName(String defaultThumbnailImageName) {
		this.defaultThumbnailImageName = defaultThumbnailImageName;
	}
	
}