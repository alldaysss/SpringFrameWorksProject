package com.spring.cjs2108_bji.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CartVO;

public interface AlcoholService {
	public void imgCheckProductInput(MultipartFile file, AlcoholVO vo);

	public List<AlcoholVO> getAlcoholCategory();

	public void categoryDelete(AlcoholVO vo);

	public AlcoholVO getCategorySearch(int idx);

	public List<AlcoholVO> selectAlcoholCategory(String itemCode);

	public AlcoholVO getAlcoholProduct(int idx);

	public List<CartVO> getCartList(String mid);

	public void cartInsert(CartVO vo);

	public void quanTityMinusProcess(int idx);

	public void quanTityPlusProcess(int idx);

	public void itemDel(int itemIdx);

	public AlOrderProcessVO getOrderMaxIdx();

	public void setOrderInput(AlOrderProcessVO vo);

	public List<AlOrderProcessVO> getOrderDuration(String mid, String startDates, String endDates);

	public AlOrderProcessVO getOrderProcess(String orderIdx);

	public void cartDeleteList(int cartIdx);

	public void setMidAddPoint(String mid, int point);

	public List<AlOrderProcessVO> deliverConfirm(String orderIdx);

	public int totRecCnt(String mid);

	public List<AlOrderProcessVO> getUserOrder(int startIndexNo, int pageSize, String mid);

	public int totRecCntorderPeriod(String mid);

	public int totRecCntAlorderProcess();

	public List<AlOrderProcessVO> adminOrderStatus(int startIndexNo, int pageSize);

	public List<AlOrderProcessVO> getAdminOrderDuration(int startIndexNo, int pageSize, String startDates, String endDates, String dvStatus, String orderSW);

	public int totRecCntAdminorderPeriod(String startDates, String endDates, String dvStatus, String orderSW);

	public void setdvStatusUpdate(String dvStatus, String orderIdx);

	public List<AlcoholVO> itemSearchGet(String searchString);

	public AlcoholVO getSearchAlcoholProduct(int idx);



}
