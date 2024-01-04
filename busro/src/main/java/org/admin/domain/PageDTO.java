package org.admin.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDTO {

	private int startPage;	//시작페이지 
	private int endPage;	//끝 페이지 번호 
	private boolean prev, next;	//이전 페이지, 다음 페이지 있나? 스프링 코드로 배우기 p.306
	
	private int total; //전체 게시물 수
	
	private Criteria cri; 	//현재 내가 보고 있는 페이지의 번호를 알기위해, & 게시물 수를 알기 위해 Criteria 타입을 가져옴
				//그 정보로 페이지 번호들을 계산하기 위해 가져옴
	
	public PageDTO(Criteria cri, int total) {	//생성자를 통해 cri와 total를 준다
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 5.0)) * 5; //마지막 페이지
			//pageNum = getPageNum : 현재 페이지번호를 가져와서 (2페이지 가지고 옴)
		// 2 / 10.0 -? 0.2  ceil을 통해서 올림 1
		// 1* 10 = 10 그래서 현재 2페이지는 [1][2][3][4][5][6][7][8][9][여기]
		
		//시작페이지
		this.startPage = this.endPage - 4;
		
		//만약에 132게시물수 까지 있으면 페이지번호 11~20 까지 나옴. 페이지번호 13까지만 있어야하ㅏㅁ
		// 132 * 1.0 -> 132.0 // 10개씩 13.2 올림 -> 14
		
		 int realEnd = (int)(Math.ceil( (total * 1.0) / cri.getAmount()));
		 								//1.0 곱한 이유 : int total과 int amount 를 나누면 소수점 버리고 정수를 리턴하기 때문
		 								//1.0을 total에 곱해서 double로 형변환한 것을 amount로 나눈 값도 소수점 나오게 함
		 				//최종적으로 (int)로 정수로 형변환함
		 if(realEnd < this.endPage) {
			 this.endPage = realEnd;
			
		 }
		 
		 //시작페이지가 1보다 큰 경우 true
			this.prev = this.startPage > 1;
			
			//마지막 페이지 번호가 진짜 마지막 페이지보다 작다면 //가령 14였으니 10이라면 다음으로, 참
			this.next = this.endPage < realEnd;
		
	}
	
	
	
}
