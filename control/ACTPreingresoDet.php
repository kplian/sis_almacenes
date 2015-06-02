<?php
/**
*@package pXP
*@file gen-ACTPreingresoDet.php
*@author  (admin)
*@date 07-10-2013 17:46:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPreingresoDet extends ACTbase{    
			
	function listarPreingresoDet(){
		$this->objParam->defecto('ordenacion','id_preingreso_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_preingreso')!=''){
			$this->objParam->addFiltro("predet.id_preingreso = ".$this->objParam->getParametro('id_preingreso'));	
		}
		
		if($this->objParam->getParametro('estado')!=''){
			$this->objParam->addFiltro("predet.estado = ''".$this->objParam->getParametro('estado')."''");	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPreingresoDet','listarPreingresoDet');
		} else{
			$this->objFunc=$this->create('MODPreingresoDet');
			$this->res=$this->objFunc->listarPreingresoDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPreingresoDet(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		
		if($this->objParam->insertar('id_preingreso_det')){
			$this->res=$this->objFunc->insertarPreingresoDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPreingresoDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPreingresoDet(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		$this->res=$this->objFunc->eliminarPreingresoDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function preparaPreingreso(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		$this->res=$this->objFunc->preparaPreingreso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function insertarPreingresoDetPreparacion(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		
		if($this->objParam->insertar('id_preingreso_det')){
			$this->res=$this->objFunc->insertarPreingresoDetPreparacion($this->objParam);			
		} else{
			$this->res=$this->objFunc->modificarPreingresoDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function eliminarPreingresoDetPreparacion(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		$this->res=$this->objFunc->eliminarPreingresoDetPreparacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function preparaPreingresoAll(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		$this->res=$this->objFunc->preparaPreingresoAll($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function quitaPreingresoAll(){
		$this->objFunc=$this->create('MODPreingresoDet');	
		$this->res=$this->objFunc->quitaPreingresoAll($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>