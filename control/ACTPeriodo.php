<?php
/**
*@package pXP
*@file gen-ACTPeriodo.php
*@author  (admin)
*@date 19-06-2013 08:33:57
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPeriodo extends ACTbase{    
			
	function listarPeriodo(){
		$this->objParam->defecto('ordenacion','id_periodo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPeriodo','listarPeriodo');
		} else{
			$this->objFunc=$this->create('MODPeriodo');
			
			$this->res=$this->objFunc->listarPeriodo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPeriodo(){
		$this->objFunc=$this->create('MODPeriodo');	
		if($this->objParam->insertar('id_periodo')){
			$this->res=$this->objFunc->insertarPeriodo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPeriodo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPeriodo(){
			$this->objFunc=$this->create('MODPeriodo');	
		$this->res=$this->objFunc->eliminarPeriodo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function AbrirCerrarPeriodo(){
			$this->objFunc=$this->create('MODPeriodo');	
		$this->res=$this->objFunc->AbrirCerrarPeriodo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>