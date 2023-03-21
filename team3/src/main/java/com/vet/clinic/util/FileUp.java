package com.vet.clinic.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUp {

	// 파일 저장시키기 (경로, 실제 파일)
		public String fileSave(String path, MultipartFile file) throws IOException {
			File upFile = new File(path);
			// 경로가 없다면(폴더가 없을때)
			if(!upFile.exists()) {
				upFile.mkdirs(); // 경로까지 폴더가 없다면 다 만들어주세요.
			}
			//유니크한 파일명 만들기 == UUID -----> 연월일시분초_파일명.(이렇게 해도됨)
			String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			
			//파일경로 + 파일명으로 만들어줍니다. (경로,파일명) (기존 경로에 파일명 추가되는 것)
			upFile = new File(upFile, fileName);
			//파일 올리기		(저장할 파일, 파일경로)
			FileCopyUtils.copy(file.getBytes(), upFile);
			
			//파일명 되돌려주기
			return fileName;
		}
		
}
