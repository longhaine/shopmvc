package com.shopmvc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopmvc.entity.Order_Account;
import com.shopmvc.entity.Orders_Detail;
import com.shopmvc.repository.Orders_DetailRepository;

@Service
public class Orders_DetailService {
	
	@Autowired
	private Orders_DetailRepository orders_DetailRepository;
	
	public ArrayList<Orders_Detail> findByOrder(Order_Account order){
		return orders_DetailRepository.findByOrder(order);
	}
	public void save(Orders_Detail order_detail)
	{
		orders_DetailRepository.save(order_detail);
	}
}
