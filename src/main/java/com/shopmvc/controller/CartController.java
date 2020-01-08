package com.shopmvc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Order_Account;
import com.shopmvc.entity.Orders_Detail;
import com.shopmvc.entity.Product;
import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;
import com.shopmvc.service.Order_AccountService;
import com.shopmvc.service.Orders_DetailService;
import com.shopmvc.service.ProductService;

@Controller
@RequestMapping(value = "/cart")
public class CartController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private Order_AccountService orderService;
	@Autowired
	private Orders_DetailService orderDetailService;
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	public Account getGuestInfo(HttpSession session) {
		Account guest = (Account) session.getAttribute("guest");
		if(guest == null)
		{
			return new Account();
		}
		return guest;
	}
	
	@PutMapping(value = "/add")
	public void add(HttpServletRequest request, HttpSession session) {
		Integer productId = Integer.valueOf(request.getParameter("product"));
		if(productId != null)
		{
			Optional<Product> productOptional= productService.findById(productId);
			if(productOptional.isPresent())
			{
				Product product = productOptional.get();
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
				if(cartList == null) // if cart list session never be created before
				{
					cartList = new ArrayList<Product>(); // create a reference
				}
				cartList.add(product);
				session.setAttribute("cartList", cartList);
				session.setMaxInactiveInterval(5*60);
			}
		}
	}
	@PutMapping(value = "/remove")
	public void remove(HttpServletRequest request, HttpSession session) {
		String productId = request.getParameter("product");
		if(productId != null)
		{
			ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
			if(cartList != null)
			{
				
				int removeProductIndex = -1;
				for(Product cart : cartList)
				{
					if(cart.getId() == Integer.parseInt(productId))
					{
						removeProductIndex = cartList.indexOf(cart);
						break;
					}
				}
				if(removeProductIndex >= 0 )
				{
					cartList.remove(removeProductIndex);
					session.setAttribute("cartList", cartList);
					session.setMaxInactiveInterval(5*60); // 5 minutes
				}
				System.out.println("hello");
				if(cartList.isEmpty()) // if session productlist doesn't have 1 product
				{
					session.removeAttribute("cartList");
				}
			}
		}
	}
	
	@GetMapping(value = "/checkout")
	public String checkout(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model,RedirectAttributes redirectAttributes) {
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
		Account account = (Account) session.getAttribute("account");
		String accountAddress = "";
		loadBanner(model);
		if(account != null)
		{
			accountAddress = account.getAddress();
		}
		if(cartList != null && account != null && accountAddress != null) // okay
		{
			model.addAttribute("inCase", "account");
			model.addAttribute("account", account);
			return "checkout";
		}
		if(cartList !=null && account != null && accountAddress == null) // in case user doesn't have address
 		{
			redirectAttributes.addFlashAttribute("message", "pls add your address before checkout");
			return "redirect:/account/your-info";
		}
		if(cartList !=null && account == null) // in case guest
		{
			model.addAttribute("inCase", "guest");
			model.addAttribute("account",getGuestInfo(session)); // put guest info into form
			return "checkout";
		}
		return "redirect:/";
	}
	@PostMapping(value = "/doCheckout")
	public String doCheckout(HttpSession session, HttpServletRequest request,RedirectAttributes redirectAttributes,@ModelAttribute("account") Account guest) {
		ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
		Account account = (Account) session.getAttribute("account");
		String email, name, address, phone; // basic information of account or guest(without email) 
		float totalPrice = 0;
		String idSession; // in case for identified a guest
		String message; // send message to cart/history Controller;
		if(cartList != null)
		{
			for(Product cart : cartList) // get totalPrice for order
			{
				totalPrice = totalPrice +cart.getPrice();
			}
			if(account != null){
				// get information of the account
				email = account.getEmail();
				name = account.getName();
				address = account.getAddress();
				phone = account.getPhone();
				idSession = "";
			}
			else { // in case guest
				email = "unknow";
				name = guest.getName();
				address = guest.getAddress();
				phone = guest.getPhone();
				idSession = session.getId();
				session.setAttribute("guest", guest);
			}
			Order_Account order = new Order_Account(); // create an order for put basic info before insert into database
			order.setEmail(email);
			order.setAddress(address);
			order.setName(name);
			order.setPhone(phone);
			order.setPrice(totalPrice);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			order.setDate(format.format(new Date()));
			order.setIdsession(idSession);
			Order_Account insertedOrder = orderService.save(order); // saving and getting that order to getId
			for(Product cart : cartList) // add order_detail by id of oder
			{
				orderDetailService.save(new Orders_Detail(insertedOrder, cart));
			}
			session.removeAttribute("cartList"); // remove cartList just order
			redirectAttributes.addFlashAttribute("message", "Place order successfully!!! The products will be delivered to your address tomorrow!");
			return "redirect:/cart/history";
		}
		return "redirect:/";
	}
	@GetMapping(value = "/history")
	public String history(Model model, @ModelAttribute("message")String message,HttpSession session) {
		loadBanner(model);
		Account account = (Account)session.getAttribute("account");
		ArrayList<Order_Account> orderList = new ArrayList<>();
		if(account != null) // in case account
		{
			orderList = orderService.findByEmailOrderByIdDesc(account.getEmail());
		}
		else // in case guest
		{
			orderList = orderService.findByIdsessionOrderByIdDesc(session.getId());
		}
		model.addAttribute("message", message);
		model.addAttribute("orderList", orderList);
		return "history";
	}
}
