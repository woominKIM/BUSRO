package org.busro.mapper;

import java.util.List;

import org.admin.domain.AnswerVO;
import org.admin.domain.Criteria;
import org.apache.ibatis.annotations.Param;

public interface AnswerMapper {

	public int answerRegister(AnswerVO vo);
	
	public AnswerVO answerGet(int ino);
	
	public Integer checkAnswer(AnswerVO vo);
	// 답변이 있으면 1, 없으면 0(ServiceImpl)
	
	//삭제
	public int answerDelete (int ino);
	
	public boolean updateAnswer(AnswerVO answer);
	
	//상태 체크용 리스트
	public List<AnswerVO> answerGet();
	
	public Integer answerTotal(int ino);
	
	
}
