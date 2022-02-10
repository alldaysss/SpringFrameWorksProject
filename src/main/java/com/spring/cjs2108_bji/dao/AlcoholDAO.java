package com.spring.cjs2108_bji.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CartVO;

public interface AlcoholDAO {

	public List<AlcoholVO> getCategoryList();

	public void setDbProductInput(@Param("vo") AlcoholVO vo);

	public List<AlcoholVO> getAlcoholCategory();

	public void categoryDelete(@Param("idx") int idx);

	public AlcoholVO getCategorySearch(@Param("idx") int idx);

	public List<AlcoholVO> selectAlcoholCategory(@Param("itemCode") String itemCode);

	public AlcoholVO getAlcoholProduct(@Param("idx") int idx);

	public AlcoholVO getSearchAlcoholProduct(@Param("idx") int idx);
	
	public List<CartVO> getCartList(@Param("mid") String mid);

	public void cartInsert(@Param("vo") CartVO vo);

	public void quanTityMinusProcess(@Param("idx") int idx);

	public void quanTityPlusProcess(@Param("idx") int idx);

	public void itemDel(@Param("itemIdx") int itemIdx);

	public AlOrderProcessVO getOrderMaxIdx();

	public void setOrderInput(@Param("vo")AlOrderProcessVO vo);

	public List<AlOrderProcessVO> getOrderDuration(@Param("mid") String mid, @Param("startDates") String startDates, @Param("endDates") String endDates);

	public void cartDeleteList(@Param("cartIdx") int cartIdx);

	public void setMidAddPoint(@Param("mid") String mid, @Param("point") int point);

	public List<AlOrderProcessVO> deliverConfirm(@Param("orderIdx") String orderIdx);

	public AlOrderProcessVO getOrderProcess(@Param("orderIdx") String orderIdx);

	public int totRecCnt(@Param("mid") String mid);

	public List<AlOrderProcessVO> getUserOrder(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totRecCntorderPeriod(@Param("mid") String mid);

	public int totRecCntAlorderProcess();

	public List<AlOrderProcessVO> adminOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<AlOrderProcessVO> getAdminOrderDuration(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("startDates") String startDates, @Param("endDates") String endDates, @Param("dvStatus") String dvStatus, @Param("orderSW") String orderSW);

	public int totRecCntAdminorderPeriod(@Param("startDates") String startDates, @Param("endDates") String endDates, @Param("dvStatus") String dvStatus, @Param("orderSW") String orderSW);

	public void setdvStatusUpdate(@Param("dvStatus") String dvStatus, @Param("orderIdx") String orderIdx);

	public List<AlcoholVO> itemSearchGet(@Param("searchString") String searchString);



}
