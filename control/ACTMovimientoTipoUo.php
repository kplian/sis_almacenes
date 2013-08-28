<?php
/**
*@package pXP
*@file gen-ACTMovimientoTipoUo.php
*@author  (admin)
*@date 22-08-2013 22:55:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimientoTipoUo extends ACTbase{    
			
	function listarMovimientoTipoUo(){
		$this->objParam->defecto('ordenacion','id_movimiento_tipo_uo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_movimiento_tipo')!=''){
			$this->objParam->addFiltro("timvuo.id_movimiento_tipo = ".$this->objParam->getParametro('id_movimiento_tipo'));	
		}
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMovimientoTipoUo','listarMovimientoTipoUo');
		} else{
			$this->objFunc=$this->create('MODMovimientoTipoUo');
			
			$this->res=$this->objFunc->listarMovimientoTipoUo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimientoTipoUo(){
		$this->objFunc=$this->create('MODMovimientoTipoUo');	
		$this->res=$this->objFunc->insertarMovimientoTipoUo($this->objParam);			
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimientoTipoUo(){
			$this->objFunc=$this->create('MODMovimientoTipoUo');	
		$this->res=$this->objFunc->eliminarMovimientoTipoUo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>