package com.saltlux.mydictionary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.saltlux.mydictionary.security.Auth;
import com.saltlux.mydictionary.security.AuthUser;
import com.saltlux.mydictionary.service.BookmarkListService;
import com.saltlux.mydictionary.service.UserService;
import com.saltlux.mydictionary.vo.BookmarkListVo;
import com.saltlux.mydictionary.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService ;

	@Autowired 
	private BookmarkListService bookmarkListService;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		return "user/join";
	}

	@RequestMapping(value="/join", method=RequestMethod.POST)
	@Transactional
	public String join(UserVo vo) {
		userService.join(vo);
		bookmarkListService.addBmkList(new BookmarkListVo(vo.getUserNo()));
		return "redirect:/user/joinsuccess";
	}

	@RequestMapping("/joinsuccess")
	public String joinsuccess() {
		return "user/joinsuccess";
	}

	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "user/login";
	}

	@Auth
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(@AuthUser UserVo authUser, Model model) { 
		long userNo = authUser.getUserNo();
		UserVo userVo = userService.getUser(userNo);
		model.addAttribute("userVo", userVo);
		return "user/update";
	}
	
	@Auth
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(UserVo vo, @AuthUser UserVo authUser, Model model) {
		long no = authUser.getUserNo();
		vo.setUserNo(no);
		userService.update(vo);
		UserVo userVo = userService.getUser(no);
		authUser.setName(vo.getName());
		authUser.setPassword(vo.getPassword());
		model.addAttribute("userVo", userVo);
		return "redirect:/";
	}
}
