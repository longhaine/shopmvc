package com.shopmvc.controller;

import java.util.ArrayList;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Category;
import com.shopmvc.entity.Product;
import com.shopmvc.service.AccountService;
import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;
import com.shopmvc.service.ProductService;

@Controller
public class Index {

	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private AccountService accountService;
	
	
	@GetMapping(value = "/")
	public String index(Model model) {
		loadBanner(model);
		model.addAttribute("productList", productService.findPopularProduct()); // load 5 popular products
		return "index";
	}
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	@GetMapping(value ="/login")
	public String login(Model model, HttpSession session,@ModelAttribute("message") String message) {
		if(session.getAttribute("account") == null)
		{
			loadBanner(model);
			model.addAttribute("message",message); // get message from doLogin Controller, message can be null
			model.addAttribute("account",new Account()); // put account into form
			return "login";
		}
		return "redirect:/";
	}
	@PostMapping(value ="/doLogin")
	public String doLogin(HttpSession session,@ModelAttribute("account") Account account,Model model,RedirectAttributes redirectAttributes) {
		Optional<Account> accountOp = accountService.login(account.getEmail(), account.getPassword());
		if(accountOp.isPresent()){
			account = accountOp.get();
			if(account.getVerification() == 0) {
				redirectAttributes.addFlashAttribute("message", "Your account wasn't verified");
				return "redirect:/login";
			}
			session.removeAttribute("guest"); // delete guest info 
			session.setAttribute("account", account);
			return "redirect:/";
		}
		else {
			redirectAttributes.addFlashAttribute("message", "invalid email or password"); // send message to login Controller
			return "redirect:/login";
		}
	}
	@PostMapping(value ="/doLogout")
	public String doLogout(HttpSession session) {
		session.removeAttribute("account"); // remove account from session
		return "redirect:/";
	}
	@GetMapping(value="/contact")
	public String contact(Model model) {
		loadBanner(model);
		return "contact";
	}
	@GetMapping(value ="/search")
	public String search(Model model,HttpServletRequest request) {
		loadBanner(model);
		String query = request.getParameter("q");
		Optional<String> categoryName = Optional.ofNullable(request.getParameter("category"));
		ArrayList<Product> productList = null;
		if(categoryName.isPresent()) {
			productList = productService.findByNameAndCategory(query, categoryName.get());
		}
		else {
			productList = productService.findByName(query);
		}
		model.addAttribute("productList", productList);
		return "search";
	}
}
