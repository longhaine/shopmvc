package com.shopmvc.repository;

import javax.persistence.QueryHint;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.shopmvc.entity.Brand;

@Repository
public interface BrandRepository extends CrudRepository<Brand, Integer> {
}
