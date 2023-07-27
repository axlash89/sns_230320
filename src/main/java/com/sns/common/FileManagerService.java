package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public static final String FILE_UPLOAD_PATH = "C:\\Users\\axlas\\Desktop\\kotaeyoung\\6_spring_project\\new_sns\\workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "D:\\kotaeyoung\\6_spring_project\\sns\\workspace\\images/";
	
	
	
	public String saveFile(String loginId, MultipartFile file) {
		
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}
	
	
	
	// 프로필 이미지 파일
	public String saveProfileImageFile(String existingFilePath, int userId, MultipartFile file) {
		if (existingFilePath != null) {
			String existingDirectory = FILE_UPLOAD_PATH + existingFilePath;
			Path path = Paths.get(existingDirectory); 
			try {
				Files.delete(path);
			} catch (IOException e) {
				logger.info("###[FileManagerService 이미지 삭제 실패] imagePath:{}", existingFilePath);
			}
			
			try {
				Files.delete(path.getParent());
			} catch (IOException e) {
				logger.info("###[FileManagerService 이미지 폴더 삭제 실패] imagePath:{}", existingFilePath);
			}
		}
			
		String directoryName = userId + "_" + System.currentTimeMillis() + "/";
		
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			logger.info("###[FileManagerService 이미지 저장 실패] imagePath:{}", filePath + file.getOriginalFilename());
			return null;
		}
		
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}
	
	// 프로필 이미지 파일 삭제
	public void deleteExistingProfileImageFile(String existingFilePath) {
		
		String existingDirectory = FILE_UPLOAD_PATH + existingFilePath;
		Path path = Paths.get(existingDirectory); 
		
		try {
			Files.delete(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try {
			Files.delete(path.getParent());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
