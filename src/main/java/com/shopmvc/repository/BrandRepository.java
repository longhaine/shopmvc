package com.shopmvc.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.shopmvc.entity.Brand;

@Repository
public interface BrandRepository extends CrudRepository<Brand, Integer> {
	
}
