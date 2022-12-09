package com.enitec.vo;

import lombok.Data;

@Data
public class Image implements Comparable<Image>{
	private String thumbnail;
	private String ct_code;
	private int popularity;
	
	@Override
	public int compareTo(Image o) {
		return o.getPopularity()-getPopularity();
	}
}
