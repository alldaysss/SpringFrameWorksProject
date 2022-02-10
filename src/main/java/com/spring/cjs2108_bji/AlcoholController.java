package com.spring.cjs2108_bji;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.service.AlcoholService;
import com.spring.cjs2108_bji.service.UserService;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.BoardVO;
import com.spring.cjs2108_bji.vo.CartVO;
import com.spring.cjs2108_bji.vo.UserVO;

@Controller
@RequestMapping("/alcohol")
public class AlcoholController {
	String msgFlag = "";
	
	@Autowired
	AlcoholService alcoholService;
	
	@Autowired
	UserService userService;
	
	// 상품 등록시 상품의 상세설명을 ckeditor로 처리
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		// ckeditor에서 올린 파일을 서버 파일시스템에 저장시켜준다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);		// 서버에 업로드시킨 그림파일이 저장된다.
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");       /* "atom":"12.jpg","uploaded":1,"": */
		
		out.flush();
		outStr.close();
	}
	
	// 상품등록창 보기
	@RequestMapping(value="/alcoholCategory", method= RequestMethod.GET)
	public String alcoholCategoryGet(Model model) {
		List<AlcoholVO> vos = alcoholService.getAlcoholCategory();
		model.addAttribute("vos", vos);
		return "admin/alcohol/alcoholCategoryInput";
	}
	
	// 상품분류 등록하기
	@RequestMapping(value="/alcoholCategory", method= RequestMethod.POST)
	public String categoryInputPost(MultipartFile file, AlcoholVO vo) {
//	public String categoryInputPost(AlcoholVO vo) {
		// 이미지파일 업로드시에는 ckeditor폴더에서 board폴더로 복사작업처리
		alcoholService.imgCheckProductInput(file, vo);
		
		msgFlag = "categoryInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	//등록상품 삭제
	@ResponseBody
	@RequestMapping(value="/delCategory", method=RequestMethod.POST)
	public String categoryDeletePost(int idx) {
		AlcoholVO vo = alcoholService.getCategorySearch(idx);
		alcoholService.categoryDelete(vo);
		
		return "";
	}
	
	// 판매상품 진열하기
	@RequestMapping(value="/shopList", method=RequestMethod.GET)
	public String shopListGet(String itemCode, Model model) {
		String[] arrItemCode = itemCode.split("/");
		
		List<AlcoholVO> alVos = alcoholService.selectAlcoholCategory(arrItemCode[0]);
		
		model.addAttribute("itemCode", arrItemCode[1]);
		model.addAttribute("itemCodeJoin", itemCode);
		model.addAttribute("alVos", alVos);
		return "shop/shopList";
	}
	
	// 진열 된 상품 내역 상세 보여주기
	@RequestMapping(value="/shopContent", method=RequestMethod.GET)
	public String shopContentGet(int idx, Model model, String itemCodeJoin) {
		AlcoholVO vo = alcoholService.getAlcoholProduct(idx); //진열 된 상품 불러오기
		vo.setItemCodeJoin(itemCodeJoin);
		model.addAttribute("vo", vo);
		return "shop/shopContent";
	}
	// 검색 된 상품 내역 상세 보여주기
	@RequestMapping(value="/searchContent", method=RequestMethod.GET)
	public String searchContentGet(int idx, Model model) {
		AlcoholVO vo = alcoholService.getSearchAlcoholProduct(idx); //진열 된 상품 불러오기
		model.addAttribute("vo", vo);
		return "shop/searchContent";
	}
	
	// 위시리스트에 담으면 데이터가 vo담김 (장바구니로 담기 - 장바구니테이블에 저장하기)
	@RequestMapping(value="/cartInput", method=RequestMethod.POST)
	public String cartInputPost(CartVO vo, HttpSession session) {
		vo.setMid((String)session.getAttribute("sMid"));
		// insert 작업
		alcoholService.cartInsert(vo);
		
		return "redirect:/alcohol/cartList";
	}
	
	// 수량 1개 감소
	@ResponseBody
	@RequestMapping(value="/quanTityMinusProcess")
	public String quanTityMinusProcessGet(int idx) {
		alcoholService.quanTityMinusProcess(idx);
		return "";
	}
	
	// 수량 1개 증가
	@ResponseBody
	@RequestMapping(value="/quanTityPlusProcess")
	public String quanTityPlusProcessGet(int idx) {
		alcoholService.quanTityPlusProcess(idx);
		return "";
	}
	
	//장바구니에서 삭제 
	@ResponseBody
	@RequestMapping(value="/itemDel")
	public String itemDelGet(int itemIdx) {
		alcoholService.itemDel(itemIdx);
		return "";
	}
	
	// 장바구니에 담겨있는 모든 품목들 보여주기
	@RequestMapping(value="/cartList", method=RequestMethod.GET)
	public String cartListGet(CartVO vo, AlcoholVO avo, HttpSession session, Model model, String itemCodeJoin) {
		String mid = (String) session.getAttribute("sMid");
		avo.setItemCodeJoin(itemCodeJoin);
		
		List<CartVO> vos = alcoholService.getCartList(mid);
		
		if(vos == null || vos.size() == 0) {
			msgFlag = "CartProductNo";
			return "redirect:/msg/" + msgFlag;
		}
		else {
			UserVO userVo = userService.getIdCheck(mid);
			model.addAttribute("vos", vos);
			model.addAttribute("userVo", userVo);
			return "shop/cartList";
		}
	}
	
	// 장바구니에 담겨있는 모든 품목들을 주문테이블에 저장하기(결제후 처리되는곳)
	@RequestMapping(value="/cartList", method=RequestMethod.POST)
	public String cartListPost(AlOrderProcessVO vo, HttpSession session, Model model) {
		System.out.println(vo);
		String mid = (String) session.getAttribute("sMid");
		vo.setMid(mid);
		
		// 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		AlOrderProcessVO maxIdx = alcoholService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		//주문번호(orderIdx) 만들기(->날짜_idx)
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		vo.setOrderIdx(orderIdx);
		session.setAttribute("sOrderIdx", orderIdx);
		
		// 장바구니에 넘어온 여러개의 상품 각각을 하나의 주문번호로 주문테이블에 저장한다.
		alcoholService.setOrderInput(vo);
		
		// 구매한 내역을 장바구니테이블에서 삭제처리한다.
		String[] cartIdx = vo.getItemIdx().split(",");
		for(int i=0; i<cartIdx.length; i++) {
			alcoholService.cartDeleteList(Integer.parseInt(cartIdx[i]));
		}
		
		// 일정량의 포인터를 회원 포인터에 적립한다.(포인트는 구매합계액의 5%로 한다.)
		int point = (int) (vo.getTotCalcPrice() * 0.05)-vo.getUsePoint();
		
		alcoholService.setMidAddPoint(vo.getMid(),point);
		msgFlag = "orderInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 주문 완료 후 주문(배송정보)된 내역 보여주는 폼
	@RequestMapping(value="/itemOrderConfirm", method=RequestMethod.GET)
	public String dbOrderConfirmGet(HttpSession session, Model model) {
		String orderIdx = (String) session.getAttribute("sOrderIdx");
		AlOrderProcessVO vo = alcoholService.getOrderProcess(orderIdx);
		model.addAttribute("vo", vo);
		return "shop/itemOrderConfirm";
	}
	
	//배송지 정보 보여주기
	@RequestMapping(value="/deliverConfirm", method=RequestMethod.GET)
	public String deliverConfirmGet(String orderIdx, Model model) {
		List<AlOrderProcessVO> vos = alcoholService.deliverConfirm(orderIdx);  // 같은 주문번호가 2개 이상 있을수 있기에 List객체로 받아온다.
		model.addAttribute("vo", vos.get(0));  // 같은 배송지면 0번째것 하나만 vo에 담아서 넘겨주면 된다.
		return "shop/deliverConfirm";
	}
	
	//로그인 사용자가 주문내역 조회하기
	@RequestMapping(value="/userOrder", method=RequestMethod.GET)
	public String userOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "전체";
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = alcoholService.totRecCnt(mid);		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
		List<AlOrderProcessVO> userOrderVos = alcoholService.getUserOrder(startIndexNo, pageSize, mid);
		
		model.addAttribute("userOrderVos", userOrderVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "shop/userOrder";
	}
	
	// 주문 조건 조회하기(기간별)
	@RequestMapping(value="/myOrderDuration", method=RequestMethod.GET)
	public String myOrderDurationGet(HttpSession session, Model model,String startDates, String endDates,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		//String orderIdx = (String) session.getAttribute("sOrderIdx");
		List<AlOrderProcessVO> vos = alcoholService.getOrderDuration(mid, startDates, endDates);
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = alcoholService.totRecCntorderPeriod(mid);
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;
	  int curBlock = (pag - 1) / blockSize;
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
	  model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("startDates", startDates);
		model.addAttribute("endDates", endDates);
		
		// 아래는 startJumun과 endJumun을 넘겨주는 부분(view에서 시작날짜와 끝날짜를 지정해서 출력시켜주기위해 startJumun과 endJumun값을 구해서 넘겨준다.)
		Calendar startDateJumun = Calendar.getInstance();
		Calendar endDateJumun = Calendar.getInstance();
		startDateJumun.setTime(new Date());  // 오늘날짜로 셋팅
		endDateJumun.setTime(new Date());    // 오늘날짜로 셋팅
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		startDates = "";
		endDates = "";
		if(startDates != null) {
			startDates = sdf.format(startDateJumun.getTime());
			endDates = sdf.format(endDateJumun.getTime());
		}
		
		return "shop/userOrder";
	}
	
	// 관리자 폼 호출
	@RequestMapping(value="/alcoholOrderManager")
	public String dbOrderProcessGet(Model model,
			@RequestParam(name="startDates", defaultValue="", required=false) String startDates,
			@RequestParam(name="endDates", defaultValue="", required=false) String endDates,
			@RequestParam(name="dvStatus", defaultValue="전체", required=false) String dvStatus,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		//int totRecCnt = dbShopService.totRecCntAdminStatus(startJumun, endJumun, orderStatus);
		String strNow = "";
		if(startDates.equals("")) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			strNow = sdf.format(now);
		}
		
		/* 블록페이징처리 처리 시작 */
		//int totRecCnt = alcoholService.totRecCntAlorderProcess(strNow, strNow, orderStatus);
		int totRecCnt = alcoholService.totRecCntAlorderProcess();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		/* 블록페이징처리 끝 */
		
		//List<AlOrderProcessVO> orderVos = alcoholService.adminOrderStatus(startJumun, endJumun, orderStatus);
		List<AlOrderProcessVO> orderVos = alcoholService.adminOrderStatus(startIndexNo, pageSize);
		model.addAttribute("startDates", startDates);
		model.addAttribute("endDates", endDates);
		model.addAttribute("dvStatus", dvStatus);
		model.addAttribute("orderVos", orderVos);
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
//		
		return "admin/alcohol/alcoholOrderManager";
	}
	
	// 관리자 주문 조건 조회하기(기간별/상태별)
	@RequestMapping(value="/adminOrderProcess", method=RequestMethod.GET)
	public String AdminOrderProcessGet(HttpSession session, Model model,String startDates, String endDates, String orderSW,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
	    @RequestParam(name="dvStatus", defaultValue="전체", required=false) String dvStatus){
		String mid = (String) session.getAttribute("sMid");
		//String orderIdx = (String) session.getAttribute("sOrderIdx");
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		int totRecCnt = 0;
		if(orderSW.equals("DD")) {
			totRecCnt = alcoholService.totRecCntAdminorderPeriod(startDates, endDates, dvStatus, orderSW);
		}
		else {
			totRecCnt = alcoholService.totRecCntAdminorderPeriod(startDates, endDates, dvStatus, orderSW);
		}
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		/* 블록페이징처리 끝 */
		List<AlOrderProcessVO> orderVos = new ArrayList<AlOrderProcessVO>();
		if(orderSW.equals("DD")) {
			orderVos = alcoholService.getAdminOrderDuration(startIndexNo, pageSize, startDates, endDates, dvStatus, orderSW);
		}
		else {
			orderVos = alcoholService.getAdminOrderDuration(startIndexNo, pageSize, startDates, endDates, dvStatus, orderSW);
		}
		
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("startDates", startDates);
		model.addAttribute("endDates", endDates);
		model.addAttribute("dvStatus", dvStatus);
		
		// 아래는 startJumun과 endJumun을 넘겨주는 부분(view에서 시작날짜와 끝날짜를 지정해서 출력시켜주기위해 startJumun과 endJumun값을 구해서 넘겨준다.)
		Calendar startDateJumun = Calendar.getInstance();
		Calendar endDateJumun = Calendar.getInstance();
		startDateJumun.setTime(new Date());  // 오늘날짜로 셋팅
		endDateJumun.setTime(new Date());    // 오늘날짜로 셋팅
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		startDates = "";
		endDates = "";
		if(startDates != null) {
			startDates = sdf.format(startDateJumun.getTime());
			endDates = sdf.format(endDateJumun.getTime());
		}
		
		return "admin/alcohol/alcoholOrderManager";
	}
	
  // 관리자가 주문상태를 변경처리하는것
	@ResponseBody
	@RequestMapping(value="/dvStatusUpdate", method=RequestMethod.POST)
	public String dvStatusUpdateGet(String dvStatus, String orderIdx) {
		alcoholService.setdvStatusUpdate(dvStatus, orderIdx);
		return "";
	}
	
	// 메인 검색창으로 상품명 호출
	@RequestMapping(value="/itemSearch", method=RequestMethod.POST)
	public String itemSearchGet(Model model, String searchString) {
		
		List<AlcoholVO> scVos =  alcoholService.itemSearchGet(searchString);
		model.addAttribute("searchString", searchString);
		model.addAttribute("scVos", scVos);
		return "shop/itemSearch";
	}
}

