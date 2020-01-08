package com.shopmvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;

@Controller
@RequestMapping(value ="/blog")
public class BlogController {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	@GetMapping
	public String blog(Model model) {
		loadBanner(model);
		return "blog";
	}
	@GetMapping(value="/single-blog")
	public String singleBlog(Model model) {
		loadBanner(model);
		return "single-blog";
	}
}
