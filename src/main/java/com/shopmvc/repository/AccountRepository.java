package com.shopmvc.repository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.shopmvc.entity.Account;
import java.lang.String;
@Repository
public interface AccountRepository extends CrudRepository<Account, String> {
	
}
