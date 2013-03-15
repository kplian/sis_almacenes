<?php
/**
*@package pXP
*@file gen-ACTInventario.php
*@author  (admin)
*@date 15-03-2013 15:36:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInventario extends ACTbase{    
			
	function listarInventario(){
		$this->objParam->defecto('ordenacion','id_inventario');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODInventario','listarInventario');
		} else{
			$this->objFunc=$this->create('MODInventario');
			
			$this->res=$this->objFunc->listarInventario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInventario(){
		$this->objFunc=$this->create('MODInventario');	
		if($this->objParam->insertar('id_inventario')){
			$this->res=$this->objFunc->insertarInventario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInventario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInventario(){
			$this->objFunc=$this->create('MODInventario');	
		$this->res=$this->objFunc->eliminarInventario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>