package com.saltlux.mydictionary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.saltlux.mydictionary.dto.JsonResult;
import com.saltlux.mydictionary.service.BoardService;
import com.saltlux.mydictionary.vo.ReplyVo;
import com.saltlux.mydictionary.vo.UserVo;

@RestController

@RequestMapping(value = "/restBoard")

public class RestBoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject

	private BoardService boardService;

	@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult getReplyList(Model model,@RequestParam("bid") int bid) throws Exception {
		List<ReplyVo> list = boardService.getReplyList(bid);
		
		model.addAttribute("replyG", list);
		
		return JsonResult.success(list);
	}

	@RequestMapping(value = "/saveReply", method = RequestMethod.POST)

	public JsonResult saveReply(HttpSession session, @RequestBody ReplyVo replyVO) throws Exception {

		Map<String, Object> result = new HashMap<>();

		try {
			UserVo authUser = (UserVo) session.getAttribute("authUser");
			
			replyVO.setReg_id(authUser.getId());

			boardService.saveReply(replyVO);

			result.put("status", "OK");

		} catch (Exception e) {

			e.printStackTrace();

			result.put("status", "False");

		}

		return JsonResult.success(result);

	}
	
	@RequestMapping(value = "/updateReply", method = { RequestMethod.GET, RequestMethod.POST })

	public JsonResult updateReply(@RequestBody ReplyVo replyVO) throws Exception {

		Map<String, Object> result = new HashMap<>();
		try {
			boardService.updateReply(replyVO);
			result.put("status", "OK");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return JsonResult.success(result);
	}

	@RequestMapping(value = "/deleteReply", method = { RequestMethod.GET, RequestMethod.POST })

	public JsonResult deleteReply(@RequestParam("rid") int rid) throws Exception {

		Map<String, Object> result = new HashMap<>();
		try {
			boardService.deleteReply(rid);
			result.put("status", "OK");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return JsonResult.success(result);
	}

	

}