<?php
/**
*@package pXP
*@file gen-ACTAlmacenGestion.php
*@author  (admin)
*@date 31-12-2013 14:15:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlmacenGestion extends ACTbase{    
			
	function listarAlmacenGestion(){
		$this->objParam->defecto('ordenacion','id_almacen_gestion');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_almacen')!=''){
			$this->objParam->addFiltro("almges.id_almacen = ".$this->objParam->getParametro('id_almacen'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAlmacenGestion','listarAlmacenGestion');
		} else{
			$this->objFunc=$this->create('MODAlmacenGestion');
			
			$this->res=$this->objFunc->listarAlmacenGestion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAlmacenGestion(){
		$this->objFunc=$this->create('MODAlmacenGestion');	
		if($this->objParam->insertar('id_almacen_gestion')){
			$this->res=$this->objFunc->insertarAlmacenGestion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAlmacenGestion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlmacenGestion(){
		$this->objFunc=$this->create('MODAlmacenGestion');	
		$this->res=$this->objFunc->eliminarAlmacenGestion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function accionesGestion(){
		$this->objFunc=$this->create('MODAlmacenGestion');	
		$this->res=$this->objFunc->accionesGestion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>