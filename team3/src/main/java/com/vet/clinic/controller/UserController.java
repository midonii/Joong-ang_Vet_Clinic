package com.vet.clinic.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.StaffDTO;
import com.vet.clinic.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
// 로그인
	@GetMapping("/login")
	public String login(HttpSession session) {
		//System.out.println(session.getAttribute("id"));
		if (session.getAttribute("id") != null) {
			return "index";
		}
		return "/user/login";
	}

	@ResponseBody
	@PostMapping("/login")
	public String login(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		StaffDTO staffDTO = new StaffDTO();
		staffDTO.setStaff_id((String) map.get("id"));
		staffDTO.setStaff_email((String) map.get("email"));
		staffDTO.setStaff_pw((String) map.get("pw"));
		
		StaffDTO result = userService.login(staffDTO);	
		
		JSONObject json = new JSONObject();
		
		if(result.getCount() == 1) {
			
			/* 로그인시도 보류
			staffDTO.setStaff_logintry(0);
			userService.logintry(staffDTO);
			*/
			
			json.put("result", 1);
			
			// 세션만들기
			HttpSession session = request.getSession();
			session.setAttribute("id", staffDTO.getStaff_id());
			session.setAttribute("email", staffDTO.getStaff_email());
			session.setAttribute("username", result.getStaff_name());
			session.setAttribute("staff_grade", result.getStaff_grade());
			
		} else {
			json.put("result", 0);
		}
		return json.toString();
	}

// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
// 비밀번호찾기
	@GetMapping("/findPW")
	public String findPW() {
		return "user/findPW";
	}
	
	@ResponseBody
	@PostMapping("/findPW")
	public String findPW(@RequestParam ("email") String email) {
		
		JSONObject json = new JSONObject();

		// step1) 입력한 email이 DB에 있는지 확인
		System.out.println("사용자가 입력한 email : " + email);
		int result = userService.findEmail(email);	// email DB에 있는지 확인하고 있다면 해당 email의 회원번호 반환.
		//System.out.println("result : " + result);
		
		// email이 DB에 있다면
		if(result == 1) {
			json.put("result", result);
			
			// step2) 인증번호는 6자리숫자로 자바가 만들어서
			int tempnum = (int) ( Math.random() * 900000 ) + 100000 ;
			System.out.println("인증번호 : " + tempnum);
			
			
			// step3) 인증번호를 DB의 tempnum에 저장
			StaffDTO temp = new StaffDTO();
			temp.setStaff_tempnum(tempnum);
			temp.setStaff_email(email);
			userService.saveTempnum(temp);
			
			/*
			// step4) 입력한 email로 발송
			String title = "[midong's web] 인증번호 발송";
			
			
			String msg = "인증번호를 발송합니다. 인증번호는 [ " + tempnum + " ]입니다.";
			Email.simpleMail(email, "관리자", title, msg);
			
			/* StringBuilder 사용하여 내용입력
			StringBuilder sb = new StringBuilder();
			sb.append("<html><body><h1> 홈페이지에서 아래 임시 비밀번호를 입력하세요. </h1>");
			sb.append("<h2> 임시 비밀번호 : " +temppw + "</h2></body></html>");
			Email.htmlTagMail(email, "고객님", title, sb.toString());
			 */
		
		} else {
			json.put("result", 0);
		}
		
		return json.toString();
	}
	
	// 인증번호확인
	@ResponseBody
	@PostMapping("/checkTempnum")
	public String checkTempnum(@RequestParam Map<String, String> map) {
		
		// 사용자가 입력한 인증번호 확인
		String email = map.get("fixEmail");
		String userTempnum = map.get("userTempnum");
		System.out.println("사용자가 입력한 이메일 : " + email + "\n || 사용자가 입력한 인증번호 : " + userTempnum);
		
		// DB로 userTemppw 보내서 해당이메일 사용자의 temppw와 비교하여 result값 출력
		StaffDTO check = new StaffDTO();
		check.setStaff_email(email);
		check.setStaff_tempnum(Integer.parseInt(userTempnum));

		JSONObject json = new JSONObject();
		
		int result = userService.checkTempnum(check);
		System.out.println("인증번호 확인 결과 : " + result); // 비교결과 : 1
		
		// ajax 보내기
		if(result == 1) {
		// 인증번호가 옳다면
			json.put("result", result);
			
		} else { // 인증번호가 옳지 않다면
			json.put("result", 0);
		}
		
		return json.toString();
	}
	
	// 새 비밀번호 확인 및 DB pw 변경저장
	@ResponseBody
	@PostMapping("/newpwSet")
	public String newpwSet(@RequestParam Map<String, String> map) {
		
		String fixEmail = map.get("fixEmail");
		String newPw = map.get("newPw");
		System.out.println("사용자이메일 : "+ fixEmail + " || 받아온 새 비밀번호 : " + newPw);
		
		StaffDTO newpwSet = new StaffDTO();
		newpwSet.setStaff_pw(newPw);
		newpwSet.setStaff_email(fixEmail);
		
		// DB로 보내 비밀번호 새로 저장 & 저장된 tempnum 삭제(null)
		int result = userService.newpwSet(newpwSet);
		System.out.println("새비밀번호 저장결과 : " + result);
		
		JSONObject json = new JSONObject();
		
		if(result == 1 ) {
		// 변경된비밀번호 저장 및 인증번호 삭제 완료시
			json.put("result", result); 
		} else { // 실패시
			json.put("result", 0);
		}
		
		return json.toString();
	}
	
	
// 회원가입
	@GetMapping("/join")
	public String join() {
		return "user/join";
	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam(value="id") String id) {
		int result = userService.idCheck(id);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/emailCheck")
	public String emailCheck(@RequestParam(value="email") String email) {
		int result = userService.emailCheck(email);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/join")
	public String join(@RequestParam Map<String, String> map) {
		
		String id = map.get("id");
		String name = map.get("name");
		String pw = map.get("pw");
		String repw = map.get("repw");
		String tel = map.get("tel");
		String birth = map.get("birth");
		String email = map.get("email");
		String address = map.get("address");
		String detailAddr = map.get("detailAddr");
		String extraAddr = map.get("extraAddr");
		String addr = address + detailAddr + extraAddr;
		String grade = map.get("grade");
		System.out.println(addr);
		//System.out.println(address + detailAddr + extraAddr);
		System.out.println(id+" / "+name+" / "+pw+" / "+tel+" / "+birth+" / "+email+" / "+addr+" / "+grade);
		
		StaffDTO joinDTO = new StaffDTO(id, pw, name, birth, tel, email, addr, grade);
		
		int result = userService.join(joinDTO);
		
		JSONObject joinresult = new JSONObject();
		joinresult.put("joinresult", result );
		
		return joinresult.toString();
	}
	

// 프로필
	@GetMapping("/profile={id}")
	public ModelAndView profile(@PathVariable("id") String id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println(session.getAttribute("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		if(session.getAttribute("id") != null) {
			map.put("sessionID", session.getAttribute("id"));
		}
		
		Map<String, Object> select = userService.profile(map);
		//System.out.println(select);
		
		mv.addObject("profile", select);
		mv.setViewName("user/profile");
		return mv;
	}
	
	@PostMapping("/profile={id}")
	public String profile(HttpSession session) {
		return "redirect:/profile="+session.getAttribute("id");
	}
	
// 프로필수정
	
	@ResponseBody
	@PostMapping("/profilePwCheck")
	public String profilePwCheck(@RequestParam(value="pw") String pw, HttpSession session) {
		//System.out.println(pw);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sessionID", session.getAttribute("id"));
		map.put("pw", pw);
		
		int pwResult = userService.pwCheck(map);
		//System.out.println(pwResult);
		
		JSONObject json = new JSONObject();
		json.put("result", pwResult);
		
		return json.toString();
	}
	
	@GetMapping("/editProfile")
	public ModelAndView editProfile(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//System.out.println(session.getAttribute("id"));
		//System.out.println(session.getAttribute("pw"));
		Map<String, Object> map = new HashMap<String, Object>();
		if(session.getAttribute("id") != null) {
			map.put("sessionID", session.getAttribute("id"));
		}
		
		Map<String, Object> select = userService.profile(map);
		//System.out.println(select);
		
		mv.addObject("profile", select);
		mv.setViewName("user/editProfile");
		return mv;
		//return "user/editProfile";
	}
	
	@ResponseBody
	@PostMapping("/editProfile")
	public String editProfile(@RequestParam Map<String, String> map, HttpSession session) {
		
		Map<String, Object> edit = new HashMap<String, Object>();
		edit.put("sessionID", session.getAttribute("id"));
		edit.put("pw", map.get("pw"));
		edit.put("name", map.get("name"));
		edit.put("tel", map.get("tel"));
		edit.put("addr", map.get("addr"));
		
		int result = userService.editProfile(edit);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
}
