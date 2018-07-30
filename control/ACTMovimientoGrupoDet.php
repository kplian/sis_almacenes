<?php
/**
*@package pXP
*@file gen-ACTMovimientoGrupoDet.php
*@author  (admin)
*@date 18-10-2013 21:26:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimientoGrupoDet extends ACTbase{    
			
	function listarMovimientoGrupoDet(){
		$this->objParam->defecto('ordenacion','id_movimiento_grupo_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_movimiento_grupo')!=''){
			$this->objParam->addFiltro("mogrde.id_movimiento_grupo = ".$this->objParam->getParametro('id_movimiento_grupo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMovimientoGrupoDet','listarMovimientoGrupoDet');
		} else{
			$this->objFunc=$this->create('MODMovimientoGrupoDet');
			
			$this->res=$this->objFunc->listarMovimientoGrupoDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimientoGrupoDet(){
		$this->objFunc=$this->create('MODMovimientoGrupoDet');	
		if($this->objParam->insertar('id_movimiento_grupo_det')){
			$this->res=$this->objFunc->insertarMovimientoGrupoDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMovimientoGrupoDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimientoGrupoDet(){
			$this->objFunc=$this->create('MODMovimientoGrupoDet');	
		$this->res=$this->objFunc->eliminarMovimientoGrupoDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>