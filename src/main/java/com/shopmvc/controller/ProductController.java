package com.shopmvc.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopmvc.entity.Product;
import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;
import com.shopmvc.service.ProductService;

@Controller
@RequestMapping(value ="/product")
public class ProductController {

	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private ProductService productService;
	
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	
	@GetMapping(value ="/{id}")
	public String product(Model model,@PathVariable("id")String id) {
		loadBanner(model);
		Optional<Product> productOp = productService.findById(Integer.parseInt(id));
		if(productOp.isPresent())
		{
			model.addAttribute("product", productOp.get());
			return "product";
		}
		return "default";
	}
}
