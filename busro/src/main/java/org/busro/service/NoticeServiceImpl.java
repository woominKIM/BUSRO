package org.busro.service;

import java.util.List;

import org.busro.domain.Criteria;
import org.busro.domain.NoticeAttachVO;
import org.busro.domain.NoticeVO;
import org.busro.mapper.NoticeAttachMapper;
import org.busro.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(NoticeVO notice) {
		
		log.info("register........" + notice);
		
		mapper.insertSelectKey(notice);
		
		if(notice.getAttachList() == null || notice.getAttachList().size() <=0) {
			return;
		}
		
		notice.getAttachList().forEach(attach ->{
			
			attach.setNno(notice.getNno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public NoticeVO get(Long nno) {
		
		log.info("get.........." + nno);
		
		return mapper.read(nno);
	}
	
	@Transactional
	@Override
	public boolean modify(NoticeVO notice) {
		
		log.info("modify........." + notice);
		
		attachMapper.deleteAll(notice.getNno());
		
		boolean modifyResult = mapper.update(notice) == 1;
		
		if (modifyResult && notice.getAttachList() != null && notice.getAttachList().size() >0) {
			
			notice.getAttachList().forEach(attach -> {
				
				attach.setNno(notice.getNno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long nno) {
		
		log.info("remove........" + nno);
		
		attachMapper.deleteAll(nno);
		
		return mapper.delete(nno) == 1;
	}

//	@Override
//	public List<NoticeVO> getList() {
//		
//		log.info("getList............");
//		
//		return mapper.getList();
//	}

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		
		log.info("get List with criteria: " + cri);
		
		return mapper.getListWithPaing(cri);
	}

	
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<NoticeVO> getTopList() {
		log.info("중요서비스");
		return mapper.getTopList();
	}
	
	@Override
	public List<NoticeAttachVO> getAttachList(Long nno) {
		
		log.info("get Attach list by nno" + nno);
		
		return attachMapper.findByNno(nno);
	}
}
