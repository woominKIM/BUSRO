package org.busro.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String name;	//이름
	private String id;		//아이디
	private String pass;	//비밀번호
	
	/* @DateTimeFormat(pattern = "yyyy-MM-dd") */	
	private Date birth;		//생년월일
	
	private String year;	//년
	private String month;	//월
	private String day;		//일
	private String tel;		//핸드폰번호
	private String tel1;	//핸드폰 앞자리
	private String tel2;	//핸드폰 중간자리
	private String tel3;	//핸드폰 끝자리
	private String gender;	//성별
	private String auth;	//회원등급
	
}//class