package com.spring.cjs2108_bji.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.dao.AlcoholDAO;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CartVO;

@Service
public class AlcoholServiceImpl implements AlcoholService {

	@Autowired
	AlcoholDAO alcoholDAO;

	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckProductInput(MultipartFile file, AlcoholVO vo) {
		// 메인 이미지 저장하기
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != "" && originalFilename != null) {
				// 상품 메인사진을 업로드처리하기위해 중복파일명처리와 업로드처리
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			  String saveFileName = sdf.format(date) + "_o_" + originalFilename;
				writeFile(file, saveFileName);	  // 메인 이미지를 서버에 업로드 시켜주는 메소드 호출
				vo.setFName(originalFilename);		// 업로드시 파일명을 fName에 저장
				vo.setFName(saveFileName);				// 서버에 저장된 파일명을 vo에 set시켜준다.
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// CKEditor안의 그림파일 data폴더에서 shop폴더로 복사하기
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_bji/data/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_bji/data/shop/211229124318_4.jpg"
		
		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 dbShop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		// content박스의 내용중 그림이 없으면 돌아간다.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/");
		
		int position = 23;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			String copyFilePath = uploadPath + "shop/" + imgFile;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// 이미지 복사작업이 종료되면 실제로 저장된 'data/shop'폴더명을 vo에 set시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/", "/data/shop/"));

		// 파일 복사작업이 모두 끝나면 vo에 담긴내용을 상품의 내역을 DB에 저장한다.
		alcoholDAO.setDbProductInput(vo);
	}
	
  // 실제 파일(data폴더)을 'data/shop'폴더로 복사처리하는곳
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public List<AlcoholVO> getAlcoholCategory() {
		return alcoholDAO.getAlcoholCategory();
	}
	
	@Override
	public AlcoholVO getCategorySearch(int idx) {
		return alcoholDAO.getCategorySearch(idx);
	}

	@Override
	public void categoryDelete(AlcoholVO vo) {
		// ckeditor에서의 이미지 삭제
		if(vo.getContent().indexOf("src=\"/") != -1)	imgDelete(vo.getContent(), vo.getFName());
		
		alcoholDAO.categoryDelete(vo.getIdx());
		
	}

	public void imgDelete(String content, String fName) {
		// ckeditor에 이미지 있을때 삭제하는곳...
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_bji/data/shop/211229124318_4.jpg"

		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/shop/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
		// 메인 이미지 삭제하기
		fileDelete(uploadPath + fName);
	}

	// 원본이미지를 삭제처리하는곳(board폴더에서 삭제처리한다.)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public List<AlcoholVO> selectAlcoholCategory(String itemCode) {
		return alcoholDAO.selectAlcoholCategory(itemCode);
	}

	@Override
	public AlcoholVO getAlcoholProduct(int idx) {
		return alcoholDAO.getAlcoholProduct(idx);
	}

	@Override
	public AlcoholVO getSearchAlcoholProduct(int idx) {
		return alcoholDAO.getSearchAlcoholProduct(idx);
	}
	@Override
	public List<CartVO> getCartList(String mid) {
		return alcoholDAO.getCartList(mid);
	}

	@Override
	public void cartInsert(CartVO vo) {
		alcoholDAO.cartInsert(vo);
	}

	@Override
	public void quanTityMinusProcess(int idx) {
		alcoholDAO.quanTityMinusProcess(idx);
	}

	@Override
	public void quanTityPlusProcess(int idx) {
		alcoholDAO.quanTityPlusProcess(idx);
	}

	@Override
	public void itemDel(int itemIdx) {
		alcoholDAO.itemDel(itemIdx);
		
	}

	@Override
	public AlOrderProcessVO getOrderMaxIdx() {
		return alcoholDAO.getOrderMaxIdx();
	}

	@Override
	public void setOrderInput(AlOrderProcessVO vo) {
		alcoholDAO.setOrderInput(vo);
	}

	@Override
	public List<AlOrderProcessVO> getOrderDuration(String mid, String startDates, String endDates) {
		return alcoholDAO.getOrderDuration(mid, startDates, endDates);
	}

	@Override
	public void cartDeleteList(int cartIdx) {
		alcoholDAO.cartDeleteList(cartIdx);
	}

	@Override
	public void setMidAddPoint(String mid, int point) {
		alcoholDAO.setMidAddPoint(mid, point);
		
	}

	@Override
	public List<AlOrderProcessVO> deliverConfirm(String orderIdx) {
		return alcoholDAO.deliverConfirm(orderIdx);
	}

	@Override
	public int totRecCnt(String mid) {
		return alcoholDAO.totRecCnt(mid);
	}

	@Override
	public List<AlOrderProcessVO> getUserOrder(int startIndexNo, int pageSize, String mid) {
		return alcoholDAO.getUserOrder(startIndexNo, pageSize, mid);
	}

	@Override
	public int totRecCntorderPeriod(String mid) {
		return alcoholDAO.totRecCntorderPeriod(mid);
	}

	@Override
	public AlOrderProcessVO getOrderProcess(String orderIdx) {
		return alcoholDAO.getOrderProcess(orderIdx);
	}

	@Override
	public int totRecCntAlorderProcess() {
		return alcoholDAO.totRecCntAlorderProcess();
	}

	@Override
	public List<AlOrderProcessVO> adminOrderStatus(int startIndexNo, int pageSize) {
		return alcoholDAO.adminOrderStatus(startIndexNo, pageSize);
	}

	@Override
	public List<AlOrderProcessVO> getAdminOrderDuration(int startIndexNo, int pageSize, String startDates, String endDates, String dvStatus, String orderSW) {
		return alcoholDAO.getAdminOrderDuration(startIndexNo, pageSize, startDates, endDates, dvStatus, orderSW);
	}

	@Override
	public int totRecCntAdminorderPeriod(String startDates, String endDates, String dvStatus, String orderSW) {
		return alcoholDAO.totRecCntAdminorderPeriod(startDates, endDates, dvStatus, orderSW);
	}

	@Override
	public void setdvStatusUpdate(String dvStatus, String orderIdx) {
		switch(dvStatus) {
			case "결제완료": dvStatus = "배송중"; break;
			case "배송중": dvStatus = "배송완료"; break;
			case "배송완료": dvStatus = "구매완료"; break;
			default : dvStatus = "결제완료";
		}
		alcoholDAO.setdvStatusUpdate(dvStatus, orderIdx);
	}

	@Override
	public List<AlcoholVO> itemSearchGet(String searchString) {
		return alcoholDAO.itemSearchGet(searchString);
	}


	
}
