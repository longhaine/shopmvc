package com.shopmvc.service;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Verification;
import com.shopmvc.repository.VerificationRepository;
@Service
public class VerificationService {
	
	@Autowired
	private VerificationRepository verificationRepository;
	
	@Transactional
	public Verification save(Verification verification){
		verificationRepository.save(verification.getAccount().getEmail(), verification.getPathInfo(), verification.getDate());
		return verificationRepository.findByAccount(verification.getAccount());
	}
	
	public Optional<Verification> findById(String pathInfo){
		return verificationRepository.findById(pathInfo);
	}
	
	public void delete(Verification verification) {
		verificationRepository.delete(verification);
	}
	
	public Verification findByAccount(Account account) {
		return verificationRepository.findByAccount(account);
	}
}
