package org.busro.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/error/")
public class ErrorController {

	@GetMapping("/404")
	public void error404() {
		log.info("404 페이지 진입");
	}
	@GetMapping("/500")
	public void error500() {
		log.info("500 페이지 진입");
	}
}
