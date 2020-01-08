package com.shopmvc.controller;

import java.util.ArrayList;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Order_Account;
import com.shopmvc.entity.Orders_Detail;
import com.shopmvc.repository.Order_AccountRepository;
import com.shopmvc.service.Order_AccountService;
import com.shopmvc.service.Orders_DetailService;

@Controller
@RequestMapping(value="/order")
public class OrderController {
	
	@Autowired
	private Order_AccountService order_AccountService;
	
	@Autowired
	private Orders_DetailService order_DetailService;
	
	@GetMapping(value="/{id}")
	public String getOrder(Model model, @PathVariable("id")Integer id, HttpSession session) {
		Account account = (Account) session.getAttribute("account");
		Optional<Order_Account> orderOptional;
		Order_Account order = null;
		ArrayList<Orders_Detail> detailList = null;
		if(account != null && id != null) // in case account
		{
			orderOptional = order_AccountService.findByIdAndEmail(id, account.getEmail());
			if(orderOptional.isPresent()) // if id order and email are match 
			{
				order = orderOptional.get();
				detailList = order_DetailService.findByOrder(order);
			}
		}
		else // in case guest
		{
			orderOptional = order_AccountService.findByIdandIdsession(id, session.getId());
			if(orderOptional.isPresent())
			{
				order = orderOptional.get();
				detailList = order_DetailService.findByOrder(order);
			}
		}
		model.addAttribute("detailList", detailList);
		return "orderdetails";
	}
}
