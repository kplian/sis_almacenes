<?php
/**
*@package pXP
*@file gen-ACTMovimientoTipoItem.php
*@author  (admin)
*@date 21-08-2013 14:19:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimientoTipoItem extends ACTbase{    
			
	function listarMovimientoTipoItem(){
		$this->objParam->defecto('ordenacion','id_movimiento_tipo_item');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_movimiento_tipo')!=''){
			$this->objParam->addFiltro("timite.id_movimiento_tipo = ".$this->objParam->getParametro('id_movimiento_tipo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMovimientoTipoItem','listarMovimientoTipoItem');
		} else{
			$this->objFunc=$this->create('MODMovimientoTipoItem');
			
			$this->res=$this->objFunc->listarMovimientoTipoItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimientoTipoItem(){
		$this->objFunc=$this->create('MODMovimientoTipoItem');	
		$this->res=$this->objFunc->insertarMovimientoTipoItem($this->objParam);			
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimientoTipoItem(){
		$this->objFunc=$this->create('MODMovimientoTipoItem');	
		$this->res=$this->objFunc->eliminarMovimientoTipoItem($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>