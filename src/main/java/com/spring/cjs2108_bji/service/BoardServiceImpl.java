package com.spring.cjs2108_bji.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.cjs2108_bji.dao.BoardDAO;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardReplyVO;
import com.spring.cjs2108_bji.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<AlOrderProcessVO> AlVosDataGet(String sMid) {
		return boardDAO.AlVosDataGet(sMid);
	}
	
	//ckeditor폴더의 그림을 board폴더로 복사처리
	@Override
	public void imgCheck(BoardVO vo) {
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_bji/data/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_bji/data/board/211229124318_4.jpg"
		String content = vo.getContent();
		
		if(content.indexOf("src=\"/") != -1) {
		
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getRealPath("/resources/data/");
			
			int position = 23;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);
			boolean sw = true;
			
			while(sw) {
				String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
				String copyFilePath = "";
				String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
				
				copyFilePath = uploadPath + "board/" + imgFile;	// 복사가 될 '경로명+파일명'
				
				fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
				
				if(nextImg.indexOf("src=\"/") == -1) {
					sw = false;
				}
				else {
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
				}
			  // 이미지 복사작업이 종료되면 실제로 저장된 board폴더명을 DB에 저장시켜줘야 한다.
				vo.setContent(vo.getContent().replace("/data/", "/data/board/"));
				// 이미지 작업과 실제저장폴더를 set처리후, 잘 정비된 vo를 DB에 저장한다.
			}
		}
		boardDAO.setBoardInput(vo);
	}
	
	// 실제 파일(ckeditor폴더)을 board폴더로 복사처리하는곳 
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

	@Override
	public int totRecCnt(int lately) {
		return boardDAO.totRecCnt(lately);
	}

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public void addReadNum(int idx) {
		boardDAO.addReadNum(idx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public List<BoardVO> getPreNext(int idx) {
		return boardDAO.getPreNext(idx);
	}
	
	@Override
	public void imgDelete(String content) {
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_bji/data/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_bji/data/board/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1 ) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/");
		
		int position = 23;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile; // 원본 그림이 들어있는 경로명+파일명을 찾았다.
			
			fileDelete(oriFilePath); //원본 그림을 삭제처리하는 메소드를 만든다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	// 원본 이미지 삭제처리하는 메소드
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
			if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setBoardDelete(int idx) {
		boardDAO.setBoardDelete(idx);
	}

	@Override
	public void boardGoodUpdate(int idx, int good) {
		boardDAO.boardGoodUpdate(idx, good);
	}

	@SuppressWarnings("deprecation")
	//업데이트 시 원본 파일먼저 임시폴더에 복사 시킨다.('data/board' -> 'data/temp')
	//             0         1         2         3   3     4         5
	//             012345678901234567890123456789012345678901234567890
	// <img alt="" src="/cjs2108_bji/data/board/211229124318_4.jpg"
	// <img alt="" src="/cjs2108_bji/data/temp/211229124318_4.jpg"
	@Override
	public void imgCheckUpdate(String content) {
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/board/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\"")); // nextimg 에서 이미지 파일 경로에서 잘라줌
			String oriFilePath = uploadPath + imgFile; //원본그림은 /resources/data/board/ + 29(position값)(파일명imgFile)"
			String copyFilePath = request.getRealPath("/resources/data/temp/" + imgFile); // 복사될 파일을 Temp로 복사시킬 경로
			
			fileCopyCheck(oriFilePath, copyFilePath); // 원본 board의 그림을 temp로 복사시커 주는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	@Override
	public void imgCheckUp(String content) {
	//  0         1         2       2 3   3     4         5
	//             012345678901234567890123456789012345678901234567890
	// <img alt="" src="/cjs2108_bji/data/temp/211229124318_4.jpg"
	// <img alt="" src="/cjs2108_bji/data/board/211229124318_4.jpg"
	
		if(content.indexOf("src=\"/") != -1) {
		
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getRealPath("/resources/data/temp");
			
			int position = 23;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);
			boolean sw = true;
		
			while(sw) {
				String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
				String copyFilePath = "";
				String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
				
				copyFilePath = uploadPath + "board/" + imgFile;	// 복사가 될 '경로명+파일명'
				
				fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
				
				if(nextImg.indexOf("src=\"/") == -1) {
					sw = false;
				}
				else {
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
				}
			}
		}
	}

	@Override
	public void setBoardUpdate(BoardVO vo) {
		boardDAO.setBoardUpdate(vo);
	}

	@Override
	public int getBuyCnt(String sMid) {
		return boardDAO.getBuyCnt(sMid);
	}

	@Override
	public List<BoardVO> getBoardSearchList(String search, String searchString, int startIndexNo, int pageSize) {
		return boardDAO.getBoardSearchList(search, searchString, startIndexNo, pageSize);
	}

	@Override
	public int totRecCntSearch(String search, String searchString) {
		return boardDAO.totRecCntSearch(search, searchString);
	}

	@Override
	public String maxLevelOrder(int boardIdx) {
		return boardDAO.maxLevelOrder(boardIdx);
	}

	@Override
	public void setReplyInsert(BoardReplyVO rVo) {
		boardDAO.setReplyInsert(rVo);
	}

	@Override
	public List<BoardReplyVO> getBoardReplyList(int idx) {
		return boardDAO.getBoardReplyList(idx);
	}

	@Override
	public void boardReplyGoodUpdate(int idx, int replyGood) {
		boardDAO.boardReplyGoodUpdate(idx, replyGood);
	}

	@Override
	public void setReplyDelete(int replyIdx) {
		boardDAO.setReplyDelete(replyIdx);
	}

	@Override
	public void levelOrderUpdate(BoardReplyVO rVo) {
		boardDAO.levelOrderUpdate(rVo);
	}

	@Override
	public void setReReplyInsert(BoardReplyVO rVo) {
		boardDAO.setReReplyInsert(rVo);
	}

	@Override
	public List<BoardVO> getadBoardList(int startIndexNo, int pageSize, String search, String searchoption ) {
		return boardDAO.getadBoardList(startIndexNo, pageSize, search, searchoption);
	}

	@Override
	public int SearchtotRecCnt(String search, String searchoption) {
		return boardDAO.SearchtotRecCnt(search, searchoption);
	}

	@Override
	public void setAdBoardDelete(int idx) {
		boardDAO.setAdBoardDelete(idx);
	}

	@Override
	public List<BoardVO> getadBoardListlately(int startIndexNo, int pageSize, int lately) {
		return boardDAO.getadBoardListlately(startIndexNo, pageSize, lately);
	}
}
