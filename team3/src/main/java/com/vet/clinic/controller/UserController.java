package com.vet.clinic.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.mail.EmailException;
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
import com.vet.clinic.util.Email;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
// 로그인
	@GetMapping("/login")
	public String login() {
		
		return "/user/login";
	}

	@PostMapping("/login")
	public String login(@RequestParam Map<String, Object> map, HttpServletRequest request) throws IOException {
		
		StaffDTO result = userService.login(map);
		//System.out.println(result);
		
		if(result.getCount() == 1) {
			// 세션만들기
			HttpSession session = request.getSession();
			session.setAttribute("id", result.getStaff_id());
			session.setAttribute("email", result.getStaff_email());
			session.setAttribute("username", result.getStaff_name());
			session.setAttribute("staff_grade", result.getStaff_grade());
			
			return "/index";
			
		} else {	
			return "redirect:/login?error=1111";
		}
	}

// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
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
	public String findPW(@RequestParam ("email") String email) throws EmailException {
		
		JSONObject json = new JSONObject();

		// step1) 입력한 email이 DB에 있는지 확인
		//System.out.println("사용자가 입력한 email : " + email);
		int result = userService.findEmail(email);	// email DB에 있는지 확인하고 있다면 해당 email의 회원번호 반환.
		
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
			
			
			// step4) 입력한 email로 발송
			String title = "[중앙동물병원] 인증번호 발송";
			
			
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
		//System.out.println("사용자가 입력한 이메일 : " + map.get("email") + "\n || 사용자가 입력한 인증번호 : " + map.get("userTempnum"));
		
		JSONObject json = new JSONObject();
		
		// DB로 userTemppw 보내서 해당이메일 사용자의 temppw와 비교하여 result값 출력
		int result = userService.checkTempnum(map);
		//System.out.println("인증번호 확인 결과 : " + result); // 비교결과 : 1
		
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
		
		// DB로 보내 비밀번호 새로 저장 & 저장된 tempnum 삭제(null)
		int result = userService.newpwSet(map);
		//System.out.println("새비밀번호 저장결과 : " + result);
		
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
	@PostMapping("/telCheck")
	public String telCheck(@RequestParam(value="tel") String tel) {
		int result = userService.telCheck(tel);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping("/join")
	public String join(@RequestParam Map<String, String> map) {
		
		//System.out.println(map);
		
		String addr = map.get("addr") + map.get("detailAddr") + map.get("extraAddr");
		//System.out.println(addr);
		map.put("addr", addr);
		
		int result = userService.join(map);
		//System.out.println(result);
		
		String message = "";
		if(result == 1) {
			message = "<script> alert('회원가입이 완료되었습니다. 로그인하여 주세요.'); location.href='/login';</script>";
		} else {
			message = "<script> alert('회원가입 실패');</script>";
		}
		
		return message;
	}
	

// 프로필
	@GetMapping("/userProfile={id}")
	public ModelAndView profile(@PathVariable("id") String id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//System.out.println(session.getAttribute("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		if(session.getAttribute("id") != null) {
			map.put("sessionID", session.getAttribute("id"));
		}
		
		Map<String, Object> select = userService.profile(map);
		//System.out.println(select);
		
		mv.addObject("profile", select);
		mv.setViewName("user/userProfile");
		return mv;
	}
	
	@PostMapping("/userProfile={id}")
	public String profile(HttpSession session) {
		return "redirect:/userprofile="+session.getAttribute("id");
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
		
		map.put("sessionID", (String) session.getAttribute("id"));
		
		int result = userService.editProfile(map);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
}
