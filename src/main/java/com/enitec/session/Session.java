package com.enitec.session;

import javax.servlet.http.HttpSession;

public interface Session {
	String LOGIN_CUSTOMER = "c_id";
	
	String SELECT_PROFILE = "profile"; 
	
	String MEMBER_SHIP = "m_code";
	
	String CUSTOMER_PROFILE_LIST ="profileList";
	
	
	public static boolean checkSession(HttpSession session) {
		return session !=null;
	}
	
	public static boolean checkLogin(HttpSession session) {
		return session !=null && session.getAttribute(LOGIN_CUSTOMER) != null;
	}
	public static boolean checkSelectedProfile(HttpSession session) {
		return session !=null && session.getAttribute(SELECT_PROFILE) != null;
	}
	
	public static boolean isNoPayCustomer(HttpSession session) {
		return session != null && ("M0").equals(session.getAttribute("m_code"));
	}
}