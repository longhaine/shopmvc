package com.shopmvc.service;
import java.util.Optional;


import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.shopmvc.entity.Account;
import com.shopmvc.repository.AccountRepository;

@Service
public class AccountService {
	
	@Autowired
	private AccountRepository accountRepository;
	
	public Optional<Account> findById(String email) {
		return accountRepository.findById(email);
	}
	public Optional<Account> login(String email, String password){
		Optional<Account> accountOptional = findById(email);
		if(accountOptional.isPresent())
		{
			if(BCrypt.checkpw(password, accountOptional.get().getPassword()))
			{
				return accountOptional;
			}
		}
		return Optional.empty();
	}
	public Account save(Account account) {
		return accountRepository.save(account);
	}
	public boolean register(Account account) {
		Optional<Account> accountOptional = findById(account.getEmail());
		if(!accountOptional.isPresent()) // if account doesn't exist
		{
			account.setPassword(BCrypt.hashpw(account.getPassword(), BCrypt.gensalt(6)));
			save(account);
			return true; // if it's true
		}
		return false;
	}
}
