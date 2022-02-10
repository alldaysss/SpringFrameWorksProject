package com.spring.cjs2108_bji.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.dao.UserDAO;
import com.spring.cjs2108_bji.vo.UserVO;

@Service
public class UserServiceimpl implements UserService {
	@Autowired
	UserDAO userDAO;

	@Override
	public UserVO getIdCheck(String mid) {
		return userDAO.getIdCheck(mid);
	}

	@Override
	public UserVO getNickNameCheck(String nickName) {
		return userDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setUserInput(MultipartFile fName, UserVO vo) {
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			if(oFileName != "" && oFileName != null) {
				// 회원 사진을 업로드 처리하기 위하여 중복파일명과 업로드 처리
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				writeFile(fName, saveFileName);
				vo.setPhoto(saveFileName);
			}
			else {
				vo.setPhoto("noimage.jpg");
			}
			// 회원사진이 정상적으로 업로드 되면 회원정보를 DB에 넣는다.
			userDAO.setUserInput(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	// 회원사진 업로드 처리
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException{
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/user/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public int getBoardWriteCnt(String mid) {
		return userDAO.getBoardWriteCnt(mid);
	}
	
	@Override
	public int setUserUpdate(MultipartFile fName, UserVO vo) {
		int res = 0;
		try {
			// 정보수정중 사진을 새로 업로드 하였을 경우 아래 if문장을 처리한다.
			String oFileName = fName.getOriginalFilename();
			if(oFileName != "" && oFileName != null) {
				System.out.println("그림 수정중...");
				// 기존에 존재하는 회원사진을 삭제처리한다.
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/user/");
				if(!vo.getPhoto().equals("noimage.jpg")) {
					new File(uploadPath + vo.getPhoto()).delete();
				}
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				writeFile(fName, saveFileName);
				vo.setPhoto(saveFileName);
			}
			
			// 회원사진을 정상적으로 업로드마치고나면 회원정보를 DB에서 수정처리해준다.
			userDAO.setUserUpdate(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void setUserDelete(String mid) {
		userDAO.setUserDelete(mid);
	}

	@Override
	public ArrayList<UserVO> getIdSearcher(String toMail, String name, String tel) {
		return userDAO.getIdSearcher(toMail, name, tel);
	}

	@Override
	public UserVO getPwdSearcher(String mid, String toMail) {
		return userDAO.getPwdSearcher(mid, toMail);
	}

	@Override
	public void setNewPwdChange(String mid, String pwd) {
		userDAO.setNewPwdChange(mid, pwd);
	}

}
