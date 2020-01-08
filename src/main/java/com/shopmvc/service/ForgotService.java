package com.shopmvc.service;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Forgot;
import com.shopmvc.repository.ForgotRepository;

@Service
public class ForgotService {

	@Autowired
	private ForgotRepository forgotRepository;
	
	public Optional<Forgot> findByAccount(Account account) {
		return forgotRepository.findByAccount(account);
	}
	@Transactional
	public Optional<Forgot> save(Forgot forgot){
		forgotRepository.save(forgot.getAccount().getEmail(), forgot.getPathinfo(), forgot.getDate());
		return forgotRepository.findByAccount(forgot.getAccount());
	}
	public Optional<Forgot> findById(String pathInfo) {
		return forgotRepository.findById(pathInfo);
	}
	public void delete(Forgot forgot) {
		forgotRepository.delete(forgot);
	}
}
