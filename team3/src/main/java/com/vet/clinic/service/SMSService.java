package com.vet.clinic.service;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vet.clinic.dao.SMSDAO;
import com.vet.clinic.dto.SmsDTO;
import com.vet.clinic.dto.SmsRequestDTO;
import com.vet.clinic.dto.SmsResponseDTO;
import com.vet.clinic.dto.SmsSearchDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SMSService {
	
	@Autowired
	public SMSDAO smsDAO;
	
	@Value("${naver-cloud-sms.accessKey}")
	private String accessKey;
	
	@Value("${naver-cloud-sms.secretKey}")
	private String secretKey;
	
	@Value("${naver-cloud-sms.serviceId}")
	private String serviceId;
 
	@Value("${naver-cloud-sms.senderPhone}")
	private String phone;
	
	public String makeSignature(Long time) throws Exception {
		String space = " ";
        String newLine = "\n";
        String method = "POST";
        String url = "/sms/v2/services/"+ this.serviceId+"/messages";
        String timestamp = time.toString();
        String accessKey = this.accessKey;
        String secretKey = this.secretKey;
 
        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();
 
        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);
 
        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        String encodeBase64String = Base64.encodeBase64String(rawHmac);
 
        return encodeBase64String;
	}
	
	public SmsResponseDTO sendSms(SmsDTO smsDTO) throws Exception {
		Long time = System.currentTimeMillis();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("x-ncp-apigw-timestamp", time.toString());
		headers.set("x-ncp-iam-access-key", accessKey);
		headers.set("x-ncp-apigw-signature-v2", makeSignature(time));
		
		List<SmsDTO> messages = new ArrayList<>();
		messages.add(smsDTO);
		
		SmsRequestDTO request = SmsRequestDTO.builder()
				.type("SMS")
				.contentType("COMM")
				.countryCode("82")
				.from(phone)
				.content(smsDTO.getContent())
				.messages(messages)
				.build();
		
		ObjectMapper objectMapper = new ObjectMapper();
		String body = objectMapper.writeValueAsString(request);
		HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
		
		RestTemplate restTemplate = new RestTemplate();
	    restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
	    SmsResponseDTO response = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+ serviceId +"/messages"), httpBody, SmsResponseDTO.class);

	    return response;	
	}
	
	public List<SmsDTO> smsclientlist() {
		return smsDAO.smsclientlist();
	}

	public Map<String, Object> smsform(int smsform_no) {
		return smsDAO.smsform(smsform_no);
	}

	public int smsform_setdel(Map<String, String> map) {
		return smsDAO.smsform_setdel(map);
	}

	public String[] smsFormName() {
		return smsDAO.smsFormName();
	}

	public void smsDataSave(Map<String, Object> responseList) {
		smsDAO.smsDataSave(responseList);
	}

	public List<Map<String, Object>> smsDetail() {
		return smsDAO.smsDetail();
	}

	public List<SmsSearchDTO> searchClient(Map<String, Object> search_param) {
		return smsDAO.searchClient(search_param);
	}

}
