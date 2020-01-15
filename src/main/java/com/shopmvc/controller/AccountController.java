package com.shopmvc.controller;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopmvc.entity.Account;
import com.shopmvc.entity.Forgot;
import com.shopmvc.entity.Verification;
import com.shopmvc.service.AccountService;
import com.shopmvc.service.BrandService;
import com.shopmvc.service.CategoryService;
import com.shopmvc.service.ForgotService;
import com.shopmvc.service.MailService;
import com.shopmvc.service.VerificationService;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private VerificationService verificationService;
	@Autowired
	private ForgotService forgotService;
	@Autowired
	private MailService mailService;
	
	public void loadBanner(Model model) {
		model.addAttribute("categoryList",categoryService.findAll());
		model.addAttribute("brandList", brandService.findAll());
	}
	
	@GetMapping(value = "/your-info")
	public String yourInfo(HttpSession session, Model model,@ModelAttribute("message")String message) {
		if(session.getAttribute("account") != null)
		{
			loadBanner(model);
			Account account = (Account) session.getAttribute("account");
			model.addAttribute("account", account); // send account to form
			model.addAttribute("message", message); // get message from doYour-info Controller, it can be null
			model.addAttribute("path", "your-info"); // send path to info.jsp to define
			return "info";
		}
		return "redirect:/";
	}
	@PostMapping(value = "/doYour-info")
	public String doYourInfo(@ModelAttribute("account")Account accountForm,Model model,HttpSession session,RedirectAttributes redirectAttributes) {
		if(session.getAttribute("account") != null)
		{
			Account account = (Account)session.getAttribute("account");
			account.setName(accountForm.getName());
			account.setAddress(accountForm.getAddress());
			account.setPhone(accountForm.getPhone());
			session.setAttribute("account", accountService.save(account)); // update session account Information
			redirectAttributes.addFlashAttribute("message", "Your info has been updated !"); // send message to your-info Controller
			return "redirect:/account/your-info"; // redirect to your-info Controller
		}
		return "redirect:/";
	}
	@GetMapping(value = "/change-pass")
	public String changePass(@ModelAttribute("message")String message,Model model,HttpSession session) {
		if(session.getAttribute("account") != null)
		{
			loadBanner(model);
			model.addAttribute("message", message); // get message from doChange-pass Controller, it can be null
			model.addAttribute("path", "change-pass"); // send path to info.jsp to define
			return "info";
		}
		return "redirect:/";
	}
	@PostMapping(value = "/doChange-pass")
	public String doChangePass(HttpSession session, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		if(session.getAttribute("account")!= null)
		{
			Account account = (Account)session.getAttribute("account");
			String currentPasswordParameter = request.getParameter("currentpassword");
			String newPasswordParameter = request.getParameter("newpassword");
			String message;
			if(BCrypt.checkpw(currentPasswordParameter, account.getPassword())) // if password matchs with account
			{
				account.setPassword(BCrypt.hashpw(newPasswordParameter, BCrypt.gensalt(6))); // hash and set new password to account
				session.setAttribute("account", accountService.save(account)); // update session account password
				message = "Your password has been changed !";
			}
			else
			{
				message = "Invalid password";
			}
			redirectAttributes.addFlashAttribute("message",message); // send message to change-pass Controller
			return "redirect:/account/change-pass";  // redirect to change-pass Controller
		}
		return "redirect:/";
	}
	
	@GetMapping(value ="/register")
	public String register(Model model,@ModelAttribute("message")String message,@ModelAttribute("account")Account account) {
		loadBanner(model);
		model.addAttribute("message", message);
		if(account == null)
		{
			account = new Account();
		}
		model.addAttribute("account", account);
		return "register";
	}
	
	@PostMapping(value ="/doRegister")
	public String doRegister(Model model,@ModelAttribute("account")Account account,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if(account.getName().length() >= 1 && account.getEmail().length() >= 1 && account.getPassword().length() >= 1)
		{
			String path = "/account/register/verification/";
			String requestURL = getTheWholeURL(request, path);
			String message = doRegister(account, requestURL);
			account.setPassword("");// reset password in order to pass to register controller
			redirectAttributes.addFlashAttribute("message", message);
			redirectAttributes.addFlashAttribute("account", account);
			return "redirect:/account/register";
		}
		return "redirect:/";
	}
	public String doRegister(Account account, String requestURL) {
		if(accountService.register(account) == true){
			Verification verification = verificationService.save(new Verification(account));
			if(mailService.sendLink(requestURL+verification.getPathInfo(), verification.getAccount().getEmail(),"verification"));
			{
				return "Your account has been successfully created, please check your email for verified link.";
			}
		}
		return "The email-address you entered is already in use.";
	}
	public String getTheWholeURL(HttpServletRequest request,String path) {
		String requestURLShortofPathInfo = String.valueOf(request.getRequestURL());
		return requestURLShortofPathInfo.replace(request.getRequestURI(),request.getContextPath()+path);
	}
	@GetMapping(value="/register/verification/{pathInfo}")
	public String doVerification(Model model,@PathVariable("pathInfo")String pathInfo)
	{
		Optional<Verification> verificationOptional = verificationService.findById(pathInfo);
		String message = "Verification is overdue or verification doesn't exist!!!";
		if(verificationOptional.isPresent())
		{
			Verification verification = verificationOptional.get();
			Account account = verification.getAccount();  // get account from verification
			account.setVerification(1); // set verification for account 
			accountService.save(account); // update account
			verificationService.delete(verification); // delete verification after update
			message = "Verification success !!! ";
			
		}
		model.addAttribute("message", message);
		return "verification";
	}
	@GetMapping(value="/register/get-verification")
	public String getVerfication(Model model,@ModelAttribute("account")Account account,@ModelAttribute("message")String message) {
		if(account == null)
		{
			account = new Account();
		}
		model.addAttribute("message", message);
		model.addAttribute("account", account);
		return "get-verification";
	}
	@PostMapping(value ="/register/doGet-Verification")
	public String doGetVerification(@ModelAttribute("account")Account account,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if(account != null)
		{
			String message = "This email already haven't registered yet!!!";
			Optional<Account> accountOptional = accountService.findById(account.getEmail());
			if(accountOptional.isPresent())
			{
				account = accountOptional.get();
				if(account.getVerification() == 0) // verification = 0 
				{
					Verification verification = verificationService.findByAccount(account);
					String path = "/account/register/verification/";
					String requestURL = getTheWholeURL(request, path);
					if(mailService.sendLink(requestURL+verification.getPathInfo(), verification.getAccount().getEmail(),"verification") == true){
						message = "We've sent you a link, please check your email for verifying your account !";
					}
				}
				else {
					message = "This email already was verified!";
				}
			}
			redirectAttributes.addFlashAttribute("account", account);
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:/account/register/get-verification";
		}
		return "default";
	}
	@GetMapping(value ="/forgot-password")
	public String forgotPassword(Model model, @ModelAttribute("account")Account account,@ModelAttribute("message")String message) {
		loadBanner(model);
		if(account == null)
		{
			account = new Account();
		}
		model.addAttribute("account",account);
		model.addAttribute("message", message);
		return "forgot";
	}
	@PostMapping(value ="/doForgot-Password")
	public String doForgotPassword(@ModelAttribute("account")Account account,RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if(account != null) {
			Optional<Account> accountOptional = accountService.findById(account.getEmail());
			String message = "Account doesn't exist !";
			if(accountOptional.isPresent()){
				account = accountOptional.get();
				Forgot forgot = null;
				String path = "/account/forgot-password/reset-password/";
				String requestURL = getTheWholeURL(request, path);
				Optional<Forgot> forgotOptional = forgotService.findByAccount(account);
				if(forgotOptional.isPresent()){ // if forgot already existed
					forgot = forgotOptional.get();
				}
				else { // if not
					forgot = forgotService.save(new Forgot(account)).get(); // insert another forgot
					System.out.println(forgot.getPathinfo());
				}
				if(mailService.sendLink(requestURL + forgot.getPathinfo(), forgot.getAccount().getEmail(),"reset") == true) {
					message ="We've sent you a link, please check your email for resetting your password!";
				}
			}
			redirectAttributes.addFlashAttribute("account",account);
			redirectAttributes.addFlashAttribute("message", message);
		}
		return "redirect:/account/forgot-password";
	}
	@GetMapping(value ="forgot-password/reset-password/{pathInfo}")
	public String resetPassword(Model model,@PathVariable("pathInfo")String pathInfo) {
		Optional<Forgot> forgotOptional = forgotService.findById(pathInfo);
		if(forgotOptional.isPresent())
		{
			loadBanner(model);
			model.addAttribute("account", new Account());
			model.addAttribute("method", "get");
			model.addAttribute("pathInfo", pathInfo);
			return "reset-password";
		}
		return "default";
	}
	@PostMapping(value ="forgot-password/reset-password/{pathInfo}")
	public String doResetPassword(Model model,@PathVariable("pathInfo")String pathInfo,@ModelAttribute("account")Account account) {
		Optional<Forgot> forgotOptional = forgotService.findById(pathInfo);
		if(forgotOptional.isPresent())
		{
			loadBanner(model);
			String password = account.getPassword(); // get new password
			Forgot forgot = forgotOptional.get();
			account = forgot.getAccount();
			account.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(6))); // set new password
			accountService.save(account); // update account
			forgotService.delete(forgot); // delete forgot
			model.addAttribute("method", "post");
			model.addAttribute("message", "Your password has been changed !");
			return "reset-password";
		}
		return "default";
	}
}
