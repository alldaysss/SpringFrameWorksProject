package com.spring.cjs2108_bji.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardReplyVO;
import com.spring.cjs2108_bji.vo.BoardVO;

public interface BoardDAO {


	public List<AlOrderProcessVO> AlVosDataGet(@Param("sMid") String sMid);

	public void setBoardInput(@Param("vo") BoardVO vo);

	public int totRecCnt(@Param("lately") int lately);

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void addReadNum(@Param("idx") int idx);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public List<BoardVO> getPreNext(@Param("idx") int idx);

	public void setBoardDelete(@Param("idx") int idx);

	public void boardGoodUpdate(@Param("idx") int idx, @Param("good") int good);

	public void setBoardUpdate(@Param("vo") BoardVO vo);

	public int getBuyCnt(@Param("sMid") String sMid);

	public List<BoardVO> getBoardSearchList(@Param("search") String search, @Param("searchString") String searchString, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public String maxLevelOrder(@Param("boardIdx")  int boardIdx);

	public void setReplyInsert(@Param("rVo") BoardReplyVO rVo);

	public List<BoardReplyVO> getBoardReplyList(@Param("idx") int idx);

	public void boardReplyGoodUpdate(@Param("idx") int idx, @Param("replyGood") int replyGood);

	public void setReplyDelete(@Param("replyIdx") int replyIdx);

	public void levelOrderUpdate(@Param("rVo") BoardReplyVO rVo);

	public void setReReplyInsert(@Param("rVo") BoardReplyVO rVo);

	public List<BoardVO> getadBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchoption") String searchoption);

	public List<BoardVO> getadBoardListlately(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("lately") int lately);

	public int SearchtotRecCnt( @Param("search") String search, @Param("searchoption") String searchoption);

	public void setAdBoardDelete(@Param("idx") int idx);

}
