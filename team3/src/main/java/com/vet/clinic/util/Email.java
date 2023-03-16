package com.vet.clinic.util;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Component;

@Component
public class Email {
	
	// static : 내부에서만 쓸것임
		private static String emailAddr = "joong-ang-vet@outlook.kr";
		private static String name = "JoongAng-vet";
		private static String passwd = "Joongang";
	
	// outlook 설정 > 전자메일동기화 > SMTP설정
		private static String hostName = "smtp.office365.com";
		private static int port = 587;
		
		// 메일전송이 되는지 확인하기 위하 메소드 파라미터 : (받는사람메일주소, 받는사람이름, 제목, 내용)
		public static void simpleMail(String email, String toName, String title, String msg) throws EmailException {

			SimpleEmail mail = new SimpleEmail();
			// 메일정보담기
			mail.setCharset("UTF-8");
			mail.setDebug(true);
			mail.setHostName(hostName);		// 보내는 서버 설정 : 고정(위의 설정 내용 그대로 받아야함)
			mail.setAuthentication(emailAddr, passwd); // 보내는사람 인증 : 고정
			mail.setSmtpPort(port);			// 사용할 port번호 : 고정
			mail.setStartTLSEnabled(true); // 암호화방법 : 보안 사용할거니? : 고정
			mail.setFrom(emailAddr, name);	// (보내는사람 email, 보내는사람 name) : 고정. 밑줄 > throws EmailException.
			
			// 메일내용은 아래에
			mail.addTo(email);		// 받는사람메일
			mail.setSubject(title);	// 제목
			mail.setMsg(msg);		// 내용
			
			// 전송하기
			mail.send(); 	// 끝
		}	
}
