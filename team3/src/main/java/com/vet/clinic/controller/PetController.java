package com.vet.clinic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;

@Controller
public class PetController {
	
	@GetMapping("petdetail")
	public ModelAndView petdetail() {
		ModelAndView mv = new ModelAndView("client/petdetail");
		
		
		return mv;
	}

}
