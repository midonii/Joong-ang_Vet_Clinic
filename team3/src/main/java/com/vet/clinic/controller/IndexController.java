package com.vet.clinic.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

	@GetMapping("/index")
	public String index(HttpServletRequest request, HttpSession session) {
		System.out.println(session.getAttribute("id"));
		if (session.getAttribute("id") == null) {
			return "user/login";
		}
		return "index";
	}

}
