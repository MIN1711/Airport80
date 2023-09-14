package kr.or.ddit.Infra.stock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.Infra.stock.dao.OthersDAO;
import kr.or.ddit.Infra.stock.service.StockService;
import kr.or.ddit.Infra.supplier.dao.SupplierDAO;
import kr.or.ddit.Infra.vo.lstockVO;
import kr.or.ddit.Infra.vo.stockVO;
import kr.or.ddit.Infra.vo.supplierVO;
import kr.or.ddit.enumpkg.ServiceResult;



import kr.or.ddit.safety.vo.ZoneVO;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.vo.CommonCodeVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("infra/stockInsert.do")
@Controller
public class StockInsertController {

	private final StockService service;
	private final OthersDAO othersDAO;
	private final SupplierDAO supplierDAO;
	
	@ModelAttribute("zoneList")
	public List<ZoneVO> zoneList(){
		return othersDAO.selectAllZoneList();
	}
	
	@ModelAttribute("commonCode")
	public List<CommonCodeVO> commonCode(){
		return othersDAO.selectCommonList();
	}
	
	@ModelAttribute("stockList")
	public stockVO stock() {
		return new stockVO();
	}
	@ModelAttribute("supplier")
	public List<supplierVO> supplier() {
		return supplierDAO.selectSupplierById();
	}
	
	@GetMapping
	public String getHandler() {
		return "infra/stock/insertStockList";
	}
	
	@PostMapping
	public String postHandler(
	@Validated(InsertGroup.class) @ModelAttribute("stockList") stockVO stock
	, BindingResult errors
	, Model model
	) {
		String logicalViewName= null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createStock(stock);
			if(ServiceResult.OK == result) {
				logicalViewName="redirect:/infra/stockList.do";
			}else {
				model.addAttribute("message","서버오류, 잠시 뒤 다시 시도하세요.");
				logicalViewName = "infra/stock/insertStockList";
			}
		}else {
			logicalViewName="infra/stock/insertStockList";
		}
		
		return logicalViewName;
	}
}
