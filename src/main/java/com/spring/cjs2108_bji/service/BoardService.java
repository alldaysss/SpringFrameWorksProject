package com.spring.cjs2108_bji.service;

import java.util.List;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardReplyVO;
import com.spring.cjs2108_bji.vo.BoardVO;

public interface BoardService {

	public List<AlOrderProcessVO> AlVosDataGet(String sMid);

	public void imgCheck(BoardVO vo);

	public int totRecCnt(int lately);

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public void addReadNum(int idx);

	public BoardVO getBoardContent(int idx);

	public List<BoardVO> getPreNext(int idx);

	public void imgDelete(String content);

	public void setBoardDelete(int idx);

	public void boardGoodUpdate(int idx, int good);

	public void imgCheckUpdate(String content);

	public void imgCheckUp(String content);

	public void setBoardUpdate(BoardVO vo);

	public int getBuyCnt(String sMid);

	public List<BoardVO> getBoardSearchList(String search, String searchString, int startIndexNo, int pageSize);

	public int totRecCntSearch(String search, String searchString);

	public String maxLevelOrder(int boardIdx);

	public void setReplyInsert(BoardReplyVO rVo);

	public List<BoardReplyVO> getBoardReplyList(int idx);

	public void boardReplyGoodUpdate(int idx, int replyGood);

	public void setReplyDelete(int replyIdx);

	public void levelOrderUpdate(BoardReplyVO rVo);

	public void setReReplyInsert(BoardReplyVO rVo);

	public List<BoardVO> getadBoardList(int startIndexNo, int pageSize, String search, String searchoption);

	public int SearchtotRecCnt(String search, String searchoption);

	public void setAdBoardDelete(int idx);

	public List<BoardVO> getadBoardListlately(int startIndexNo, int pageSize, int lately);
	
}
