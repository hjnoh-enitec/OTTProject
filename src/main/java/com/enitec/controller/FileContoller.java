package com.enitec.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class FileContoller {

	private String filePath = "/image";
	
	public boolean uploadFile(List<MultipartFile> uploadFiles) {
		try {
			for(MultipartFile file : uploadFiles) {
				file.transferTo(new File(file.getOriginalFilename()));
			}
		}catch(IOException e){
			return false;
		}
		return true;
	}
}
