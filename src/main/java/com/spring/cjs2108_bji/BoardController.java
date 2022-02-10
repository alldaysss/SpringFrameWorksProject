package com.spring.cjs2108_bji;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_bji.service.BoardService;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardReplyVO;
import com.spring.cjs2108_bji.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	String msgFlag = "";
	
	@Autowired
	BoardService boardService;
	
	// 게시판 들어가기 
	@RequestMapping(value="/boardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="10", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately,
			Model model) {
	
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = boardService.totRecCnt(lately);		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 10;		// 한블록의 크기를 10개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
	  List<BoardVO> vos = boardService.getBoardList(startIndexNo, pageSize);
	  
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);

		return "board/boardList";
	}
	
	// 게시글 검색기 호출
	@RequestMapping(value="/boardSearch", method = RequestMethod.POST)
	public String boardSearchGet(Model model, String searchString, String search,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="10", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately
			) {
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = boardService.totRecCntSearch(search, searchString);		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 10;		// 한블록의 크기를 10개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
	  List<BoardVO> vos = boardService.getBoardSearchList(search, searchString, startIndexNo, pageSize);
	  
	  model.addAttribute("search", search);
	  model.addAttribute("searchString", searchString);
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		return "board/boardSearch";
	}
	
	// 게시글 등록폼 호출
	@RequestMapping(value="/boardInput", method = RequestMethod.GET)
	public String boardInputGet(HttpSession session, Model model) {
		String sMid = (String) session.getAttribute("sMid");
		List<AlOrderProcessVO> alVos = boardService.AlVosDataGet(sMid);
		// 이미지파일 업로드시에는 ckeditor폴더에서 board폴더로 복사작업처리
		// itemNames에 넘어오는값? ${vo.orderIdx}/${vo.itemName}/${vo.pdImage}
		int selCnt = boardService.getBuyCnt(sMid);
		if(selCnt == 0) {
			return "redirect:/msg/notBuyItem";
		}
		model.addAttribute("alVos", alVos);
		return "/board/boardInput";
	}
	
	// 게시글 입력후 DB에 저장하기
	@RequestMapping(value="/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		// 이미지파일 업로드시에는 ckeditor폴더에서 board폴더로 복사작업처리
		// itemNames에 넘어오는값? ${vo.orderIdx}/${vo.itemName}/${vo.pdImage}
		String[] itemNames = vo.getItemNames().split("/");
		if(itemNames == null) {
			return "redirect:/msg/notBuyItem";
		}
		vo.setTitle(vo.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt"));
		vo.setItemName(itemNames[1]);
		vo.setPdImage(itemNames[2]);
		boardService.imgCheck(vo);
		
		return "redirect:/msg/boardInputOk";
	}
	
  //게시글 내용보기 폼 호출
	@RequestMapping(value="/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, int pag, int pageSize, int lately, Model model, HttpSession session) {
		// 조회수 증가
		
		if(session.getAttribute("sContentView"+idx) == null) session.setAttribute("sContentView"+idx, 0);
		int viewCnt = (int)session.getAttribute("sContentView"+idx);
		if(viewCnt == 0) {
			boardService.addReadNum(idx);
			session.setAttribute("sContentView"+idx, 1);
		}
		// 원본글 가져오기
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전글, 다음글 가져오기
		List<BoardVO> pnVos = boardService.getPreNext(idx);
		
		if(session.getAttribute("sGood"+idx) == null) session.setAttribute("sGood"+idx, 0);
		
		model.addAttribute("good", (int) session.getAttribute("sGood"+idx));
		
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("lately", lately);
		
		// 댓글 가지고 오기
		List<BoardReplyVO> rVos = boardService.getBoardReplyList(idx);
		model.addAttribute("rVos", rVos);
		
		return "board/boardContent";
	}
	
	// idx를 추적하여 게시글 삭제하기
	@RequestMapping(value="/boardDelete")
	public String boardDeleteGet(int idx, int pag, int pageSize, int lately) {
		// 게시글에 사진이 존재하면 실제 서버파일시스템에서 사진파일을 삭제 처리한다.
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent()); //이미지 파일 제거가 끝났다. 후에 DB를 제거한다.
		
		//DB내의 게시글 삭제 처리.
		boardService.setBoardDelete(idx);
		
		msgFlag = "boardDeleteOk$pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 좋아요 증가 처리
	@ResponseBody
	@RequestMapping("/boardGood")
	public String boardGoodPost(int idx, HttpSession session) {
		if(session.getAttribute("sGood"+idx) == null) session.setAttribute("sGood"+idx, 0);
		int good = (int)session.getAttribute("sGood"+idx);
		if(good == 0) {
			boardService.boardGoodUpdate(idx, good);
			session.setAttribute("sGood"+idx, 1);
		}
		else {
			boardService.boardGoodUpdate(idx, good);
			session.setAttribute("sGood"+idx, 0);
		}
		return "";
	}
	// 게시물 수정 처리 폼 불러오기
	@RequestMapping(value="/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="10", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately) {
	BoardVO vo = boardService.getBoardContent(idx);
	
	// 수정 작업 처리 전에 그림이 있으면 원본파일을 CKEDITOR폴더로 복사 시킨다.
	if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheckUpdate(vo.getContent());
	
	model.addAttribute("vo", vo);
	model.addAttribute("pag", pag);
	model.addAttribute("pageSize", pageSize);
	model.addAttribute("lately", lately);
	
	return "board/boardUpdate";
	}
	
	// 수정 후 게시글 DB에 저장하기
	@RequestMapping(value="/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="10", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately) {
		//원본 파일을 board폴더에서 삭제한다.
		if(vo.getOriContent().equals(vo.getContent()) && vo.getTitle().equals(vo.getOriTitle())) {
			msgFlag = "boardUpdateOkNo$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
			return "redirect:/msg/" + msgFlag;
		}
		if(vo.getOriContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getOriContent());
		
		//원본 파일이 수정폼에 들어올때 board폴더에서 temp폴더로 복사 후 원본 파일이 삭제 되었으므로, 복사 처리전의 vo.content 안에 들어 있는 원본파일 경로를 board폴더에서 temp로 변경해줘야 한다.
		vo.setContent(vo.getContent().replace("/data/board/", "/data/temp/"));
		
		//수정된 그림 파일을 다시 복사 처리한다.(수정된 그림파일의 경로는 content필드에 있음) temp폴더 > board폴더로 복사 : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		boardService.imgCheckUp(vo.getContent());
		
		//필요한 파일을 board폴더로 복사했기 때문에 CKEDITOR안의 vo.content 내용도 변경해준다.
		vo.setContent(vo.getContent().replace("/data/temp/", "/data/board/"));
		
		//잘 정리된 vo값을 DB에 저장시켜준다.
		// itemNames에 넘어오는값? ${vo.orderIdx}/${vo.itemName}/${vo.pdImage}
		if(vo.getItemNames()==null) vo.setItemNames("");
		else {
			String[] itemNames = vo.getItemNames().split("/");
			vo.setTitle(vo.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt"));
			vo.setContent(vo.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt"));
			vo.setItemName(itemNames[1]);
			vo.setPdImage(itemNames[2]);
		}
		boardService.setBoardUpdate(vo);
		
		msgFlag = "boardUpdateOk$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 댓글 저장하기
	@ResponseBody
	@RequestMapping(value="/boardReplyInsert", method = RequestMethod.POST)
	public String boardReplyInsertPost(BoardReplyVO rVo) {
		int levelOrder = 0;
		String temp = boardService.maxLevelOrder(rVo.getBoardIdx());
		if(temp != null) levelOrder = Integer.parseInt(temp) +1;
		rVo.setLevelOrder(levelOrder);
		
		boardService.setReplyInsert(rVo);
		return "";
	}
	
	List<Integer> replyGoods = new ArrayList<Integer>();
	// 댓글 좋아요 처리
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/replyBoardGood", method = RequestMethod.POST)
	public void replyBoardGoodPost(int idx, HttpSession session) {
		if(session.getAttribute("replyGoods")==null) {
			boardService.boardReplyGoodUpdate(idx, 0);
			//session.setAttribute("sReplyGood"+idx, 1);
			replyGoods.add(idx);
			session.setAttribute("replyGoods", replyGoods);
		} else {
			if(((List<Integer>) session.getAttribute("replyGoods")).indexOf(idx)==-1) {
				boardService.boardReplyGoodUpdate(idx, 0);
				//session.setAttribute("sReplyGood"+idx, 1);
				replyGoods.add(idx);
				session.setAttribute("replyGoods", replyGoods);
			}	else {
				
				boardService.boardReplyGoodUpdate(idx, 1);
				//session.setAttribute("sReplyGood"+idx, 0);
				replyGoods.remove(replyGoods.indexOf(idx));
				session.setAttribute("replyGoods", replyGoods);
			}
		}
	}
	// 댓글 삭제 기능
	@ResponseBody
	@RequestMapping(value="/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int replyIdx) {
		boardService.setReplyDelete(replyIdx);
		return "";
	}
	
	//대댓글 저장하기
	@ResponseBody
	@RequestMapping(value="/boardReReplyInsert", method = RequestMethod.POST)
	public String boardReReplyInsertPost(BoardReplyVO rVo) {
		boardService.levelOrderUpdate(rVo);
		
		rVo.setLevel(rVo.getLevel()+1);
		rVo.setLevelOrder(rVo.getLevelOrder()+1); // 업데이트된 level과 levelorder를 다시 rVo에 저장 시켜준다
		
		boardService.setReReplyInsert(rVo);
		return "";
	}
}
