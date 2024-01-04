package org.busro.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

	private int startPage;	//시작페이지 번호 [여기][2][3][4][5][6][7][8][9][10]
	private int endPage;	//끝 페이지 번호 [1][2][3][4][5][6][7][8][9][여기]
	private boolean prev, next;	// [이전] [1][2][3][4][5][6][7][8][9][10] [다음] //책 306쪽 참고
	
	private int total; //전체 게시물 수
	private Criteria cri;	//현재 내가 보고 있는 페이지의 번호를 알기 위해서 그리고 게시물 수를 알기 위해서
							//그 정보를 가지고 페이지 번호들을 계산하기 위하여 가져온다
	
	public PageDTO(Criteria cri, int total) {	//생성자를 통해서 cri와 total을 받는다
		this.cri = cri;
		this.total = total;
		
										//	현재 페이지 / 10.0 * 표현하고 싶은 끝페이지
		this.endPage = (int)(Math.ceil(cri.getPageNum()/ 5.0)) * 5;
						//getPageNum 현재 페이지 번호를 가져와서 (2)
						// 2/ 10.0 -> 0.2	ceil을 통해서 올림 1
						// 1*10 = 10 현재 2페이지는 [1][2][3][4][5][6][7][8][9][여기][다음]
		
		this.startPage = this.endPage - 4;
		
		//만약에 132페이지번호까지 있으면 페이지번호 11~20까지 나옴 페이지번호 14까지만 있어야함
		// 132 * 1.0 132.0 / 10개씩 13.2 올림 14
		int realEnd = (int)(Math.ceil( (total * 1.0)/cri.getAmount()  ));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전 과 다음
		//만약에 시작페이지가 1보다 클 때는 이전값이 거짓
		this.prev = this.startPage > 1;
		
		//마지막 페이지 번호가 진짜 마지막 페이지번호보다 작다면 참
		this.next = this.endPage < realEnd;
		
	}//PageDTO
	
}//class