package com.shopmvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;

@Controller
public class DefaultController implements ErrorController {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	
	
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	
	@RequestMapping(value = "/error")
	public String error(Model model){
		loadBanner(model);
		return "default";
	}
	
	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return "/error";
	}

}
