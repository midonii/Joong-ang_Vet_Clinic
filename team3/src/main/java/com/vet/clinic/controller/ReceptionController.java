package com.vet.clinic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReceptionController {

	@GetMapping("/reception")
	public String reception() {
		return "reception/reception";
	}
}
