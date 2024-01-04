package org.busro.service;

import java.util.List;

import org.admin.domain.AnswerVO;
import org.admin.domain.Criteria;
import org.apache.ibatis.annotations.Param;

public interface AnswerService {
	
	public int answerRegister(AnswerVO vo);
	
	public AnswerVO answerGet(int ino);
	
	
	//삭제
	public int answerDelete (int ino);
	
	public boolean updateAnswer(AnswerVO answer);

	public String checkAnswer(AnswerVO vo); //Mapper의 Integer 타입으로 null 값을 받아오고 String 문자열로 반환해주기 위해 Service는 String 타입으로 
	
	public List<AnswerVO> answerGet();
	
	public List<Integer> answerTotal(int[] ino);
	
	
}
