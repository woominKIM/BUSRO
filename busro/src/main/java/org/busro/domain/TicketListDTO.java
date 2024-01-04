package org.busro.domain;

import java.util.List;

import lombok.Data;

@Data
//TicketDTO 배열을 Form태그를 통해 컨트롤러 단에서 받기 위한 목적으로 만든 클래스.
public class TicketListDTO {
	private List<TicketDTO> tDTOList;
}
