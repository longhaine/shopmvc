package com.shopmvc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.shopmvc.entity.Brand;
import com.shopmvc.repository.BrandRepository;

@Service
public class BrandService {
	
	@Autowired
	private BrandRepository brandRepository;
	
	@Cacheable("brandFindAll")
	public ArrayList<Brand> findAll(){
		ArrayList<Brand> list = new ArrayList<Brand>();
		for(Brand brand : brandRepository.findAll())
		{
			list.add(brand);
		}
		return list;
	}
}
