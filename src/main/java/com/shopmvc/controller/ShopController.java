package com.shopmvc.controller;

import java.util.ArrayList;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopmvc.entity.Category;
import com.shopmvc.entity.Product;
import com.shopmvc.service.AccountService;
import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;
import com.shopmvc.service.ProductService;

@Controller
@RequestMapping(value = "/shop")
public class ShopController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private AccountService accountService;
	
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	@GetMapping(value ="/{gender}")
	public String shopByGender(@PathVariable("gender")String gender,Model model) {
		if(gender.equals("men") || gender.equals("women"))
		{
			loadBanner(model);
			model.addAttribute("categoryPathVariable", "ALL"); // put Category Path Variable into shop.jsp
			model.addAttribute("String", gender); // put gender into shop.jsp 
			model.addAttribute("productList",productService.findByGender(gender));
			model.addAttribute("categoryListByGender",categoryService.findByGender(gender)); // load category list aside
			return "shop";
		}
		else
		{
			loadBanner(model);
			return "default";
		}
	}
	@GetMapping(value ="/{gender}/{categoryName}")
	public String shopByGenderAndCategory(@PathVariable("gender")String gender,@PathVariable("categoryName")String categoryName,Model model) {
		ArrayList<Category> categoryList = categoryService.findByNameAndGender(categoryName, gender);
		if(!categoryList.isEmpty())
		{
			Category category = categoryList.get(0);
			loadBanner(model);
			model.addAttribute("categoryPathVariable", categoryName); // put Category Path Variable into shop.jsp
			model.addAttribute("String", gender); // put gender into shop.jsp
			model.addAttribute("categoryListByGender",categoryService.findByGender(gender));
			model.addAttribute("productList",productService.findByCategoryAndGender(category,gender));
			return "shop";
		}
		else {
			loadBanner(model);
			return "default";
		}
	}
	
}
