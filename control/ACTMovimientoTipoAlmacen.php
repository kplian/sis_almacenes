<?php
/**
*@package pXP
*@file gen-ACTMovimientoTipoAlmacen.php
*@author  (admin)
*@date 13-07-2016 19:37:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimientoTipoAlmacen extends ACTbase{    
			
	function listarMovimientoTipoAlmacen(){
		$this->objParam->defecto('ordenacion','id_movimiento_tipo_almacen');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_movimiento_tipo')!=''){
			$this->objParam->addFiltro("tpmovalm.id_movimiento_tipo = ".$this->objParam->getParametro('id_movimiento_tipo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMovimientoTipoAlmacen','listarMovimientoTipoAlmacen');
		} else{
			$this->objFunc=$this->create('MODMovimientoTipoAlmacen');
			
			$this->res=$this->objFunc->listarMovimientoTipoAlmacen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimientoTipoAlmacen(){
		$this->objFunc=$this->create('MODMovimientoTipoAlmacen');	
		if($this->objParam->insertar('id_movimiento_tipo_almacen')){
			$this->res=$this->objFunc->insertarMovimientoTipoAlmacen($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMovimientoTipoAlmacen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimientoTipoAlmacen(){
			$this->objFunc=$this->create('MODMovimientoTipoAlmacen');	
		$this->res=$this->objFunc->eliminarMovimientoTipoAlmacen($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>