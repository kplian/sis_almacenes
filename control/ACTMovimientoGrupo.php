<?php
/**
*@package pXP
*@file gen-ACTMovimientoGrupo.php
*@author  (admin)
*@date 18-10-2013 21:26:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMovimientoGrupo extends ACTbase{    
			
	function listarMovimientoGrupo(){
		$this->objParam->defecto('ordenacion','id_movimiento_grupo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMovimientoGrupo','listarMovimientoGrupo');
		} else{
			$this->objFunc=$this->create('MODMovimientoGrupo');
			
			$this->res=$this->objFunc->listarMovimientoGrupo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimientoGrupo(){
		$this->objFunc=$this->create('MODMovimientoGrupo');	
		if($this->objParam->insertar('id_movimiento_grupo')){
			$this->res=$this->objFunc->insertarMovimientoGrupo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMovimientoGrupo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimientoGrupo(){
			$this->objFunc=$this->create('MODMovimientoGrupo');	
		$this->res=$this->objFunc->eliminarMovimientoGrupo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function generarCbte(){
		$this->objFunc=$this->create('MODMovimientoGrupo');	
		$this->res=$this->objFunc->generarCbte($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>