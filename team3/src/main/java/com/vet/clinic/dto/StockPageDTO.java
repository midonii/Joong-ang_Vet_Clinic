package com.vet.clinic.dto;

public class StockPageDTO {
	
	private int totalcount;	// 전체 게시글 수
	private int pagenum;	// 현재 페이지 번호
	private int pageindex;	// 현재 페이지 인덱스
	private int contentnum;	// 한 페이지에 들어갈 게시글 수
	private int firstnumInPage;		// 각 페이지의 첫번째 게시글 번호
	private int numInBlock = 5 ; 	// 블록 안에 들어갈 페이지 수
	private int lastPage;
	private int startPageInBlock;	// 현재 페이지가 속해있는 블록의 시작 페이지 숫자
	private int endPageInBlock;		// 현재 페이지가 속해있는 블록의 마지막 페이지 숫자
	private int currentBlockIdx;	// 현재 페이지가 속해있는 블록 index
	private int lastBlockIdx;		// 마지막 페이지 블록 index
	
	// 이전, 다음은 나중에...
	
	public int calcpage(int totalcount, int contentnum) { // 전체 페이지 수 계산 함수 
		int totalpage = totalcount / contentnum ;
		if(totalcount % contentnum > 0) {
			totalpage++;
		}
		return totalpage;	// totalpage : 전체 페이지 수
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public int getPagenum() {
		return pagenum;
	}

	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}

	public int getContentnum() {
		return contentnum;
	}

	public void setContentnum(int contentnum) {
		this.contentnum = contentnum;
	}

	public int getStartPageInBlock() {
		return startPageInBlock;
	}

	public void setStartPageInBlock(int pagenum, int contentnum) {	// 현재 페이지블록 숫자로 시작페이지 구하기
		this.startPageInBlock = (pagenum / contentnum) + 1;
	}

	public int getEndPageInBlock() {
		return endPageInBlock;
	}

	public void setEndPageInBlock () {	// 블록의 마지막 페이지 숫자 구하기
		if(getLastBlockIdx() == getCurrentBlockIdx()) {
			this.endPageInBlock = calcpage(getTotalcount(), getContentnum());
		} else {
			this.endPageInBlock = getStartPageInBlock() + 4;
		}
	}

	public int getCurrentBlockIdx() {
		return currentBlockIdx;
	}

	public void setCurrentBlockIdx(int pagenum) {	// 현재 페이지가 속해있는 블록 인덱스
		this.currentBlockIdx = pagenum / numInBlock;
		if(pagenum % numInBlock > 0) {
			this.currentBlockIdx++;
		}
	}

	public int getLastBlockIdx() {
		return lastBlockIdx;
	}

	public void setLastBlockIdx(int getlastPage) {
		this.lastBlockIdx = getlastPage / numInBlock;
		if(getlastPage % numInBlock > 0) {
			this.lastBlockIdx++;
		}
	}

	public int getNumInBlock() {
		return numInBlock;
	}

	public void setNumInBlock(int numInBlock) {
		this.numInBlock = numInBlock;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int totalcount, int contentnum) {
		this.lastPage = totalcount / contentnum;
		if(totalcount % contentnum > 0) {
			this.lastPage++;
		}
	}

	public int getPageindex() {
		return pageindex;
	}

	public void setPageindex(int pagenum) {
		this.pageindex = pagenum - 1;
	}
	
	public int getFirstnumInPage() {
		return firstnumInPage;
	}
	
	public void setFirstnumInPage(int contentnum) {
		this.firstnumInPage = getPageindex() * contentnum ;
	}
	
	
}
