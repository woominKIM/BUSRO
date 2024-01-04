package org.busro.service;

import java.util.ArrayList;
import java.util.List;

import org.admin.domain.AnswerVO;
import org.busro.mapper.AnswerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class AnswerServiceImpl implements AnswerService{
	
	@Setter(onMethod_ = @Autowired )
	private AnswerMapper amapper;
	
	@Override
	public int answerRegister(AnswerVO vo) {
		
		return amapper.answerRegister(vo);
	}



	
	  @Override 
	  public String checkAnswer(AnswerVO vo) {
	  
	  Integer result = amapper.checkAnswer(vo);
	  
	  if(result == null) {
	  
	  return "0";
	  
	  }else {
	  
	  return "1"; }
	  
	  }
	 



	@Override
	public AnswerVO answerGet(int ino) {
		// TODO Auto-generated method stub
		return amapper.answerGet(ino);
	}



	@Override
	public int answerDelete(int ino) {
		// TODO Auto-generated method stub
		return amapper.answerDelete(ino);
	}



	@Override
	public boolean updateAnswer(AnswerVO answer) {
		// TODO Auto-generated method stub
		return amapper.updateAnswer(answer);
	}




	@Override
	public List<AnswerVO> answerGet() {
		
		return amapper.answerGet();
	}




	@Override
	public List<Integer> answerTotal(int[] ino) {
		
		List<Integer> at = new ArrayList<Integer>();
		
		for(int i = 0; i < ino.length; i++) {
			at.add(amapper.answerTotal(ino[i]));
			
			
		}
		
		
		
		
		return at;
	}











	



	
}
