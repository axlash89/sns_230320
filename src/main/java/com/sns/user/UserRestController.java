package com.sns.user;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.SHA256;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	/**
	 * 중복확인 API
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {		
		
		Map<String, Object> result = new HashMap<>();
		result.put("isDuplicatedId", false);
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(loginId);
		result.put("code", 1);
		
		if (userEntity != null) {
			result.put("isDuplicatedId", true);
		} 
		
		return result;
		
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
//		String hashedPassword = EncryptUtils.md5(password);
		
		SHA256 sha256 = new SHA256();
		
        String shaPassword = null;
        
		try {
			shaPassword = sha256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		Integer userId = userBO.addUser(loginId, shaPassword, name, email);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userId != null) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "회원가입 실패");
		}		
		
		return result;
		
	}
	
	
	// 로그인 API
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpSession session) {
		
		SHA256 sha256 = new SHA256();
		
        String shaPassword = null;
        
		try {
			shaPassword = sha256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		UserEntity userEntity = userBO.getUserEntityByLoginIdPassword(loginId, shaPassword);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userEntity != null) {
			session.setAttribute("userId", userEntity.getId());
			session.setAttribute("userLoginId", userEntity.getLoginId());
			session.setAttribute("userName", userEntity.getName());
			session.setAttribute("profileImagePath", userEntity.getProfileImagePath());
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "아이디 또는 비밀번호를 확인하세요.");
		}
		
		return result;
		
	}
	
	@PostMapping("/change_password")
	public Map<String, Object> changePassword(
			@RequestParam("password") String password,
			@RequestParam("newPassword")String newPassword,
			HttpSession session) {
		
		SHA256 sha256 = new SHA256();
		
        String shaPassword = null;
        
		try {
			shaPassword = sha256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		String loginId = (String)session.getAttribute("userLoginId");
		
		UserEntity userEntity = userBO.getUserEntityByLoginIdPassword(loginId, shaPassword);
		

		Map<String, Object> result = new HashMap<>();
		
		if (userEntity != null) {
			
			int userId = (int)session.getAttribute("userId");
			
			sha256 = new SHA256();
			
	        shaPassword = null;
	        
			try {
				shaPassword = sha256.encrypt(newPassword);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			
			userEntity = userBO.updateUserEntityPasswordById(userId, shaPassword);
			
			if (userEntity != null) {
				result.put("code", 1);
				result.put("result", "성공");
			} else {
				result.put("code", 300);
				result.put("errorMessage", "알 수 없는 오류로 인해 비밀번호 변경 실패, 관리자에게 문의하세요.");
			}
			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "기존 비밀번호가 일치하지 않습니다.");
		}
		
		return result;
		
	}
	
	@PutMapping("/image_update")
	public Map<String, Object> imageUpdate(
			HttpSession session,
			@RequestParam("file") MultipartFile file) {
		
		int userId = (int)session.getAttribute("userId");
		
		UserEntity userEntity = userBO.updateUserEntityProfileImagePathById(userId, file);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userEntity != null) {
			session.setAttribute("profileImagePath", userEntity.getProfileImagePath());
			result.put("code", 1);
			result.put("result", "성공");	
		} else {
			result.put("code", 500);
			result.put("errorMessage", "이미지 변경 실패");
		}
		
		return result;
		
	}
	
	
	@PostMapping("/image_delete")
	public Map<String, Object> imageDelete(HttpSession session) {
		
		int userId = (int)session.getAttribute("userId");
		UserEntity userEntity = userBO.updateUserEntityProfileImageNullPathById(userId);
		
		Map<String, Object> result = new HashMap<>();		
		if (userEntity != null) {
			session.removeAttribute("profileImagePath");
			result.put("code", 1);
			result.put("result", "성공");	
		} else {
			result.put("code", 500);
			result.put("errorMessage", "이미지 삭제 실패");
		}
		
		return result;
		
	}
	
}
