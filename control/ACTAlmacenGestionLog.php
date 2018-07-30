<?php
/**
*@package pXP
*@file gen-ACTAlmacenGestionLog.php
*@author  (admin)
*@date 31-12-2013 14:16:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlmacenGestionLog extends ACTbase{    
			
	function listarAlmacenGestionLog(){
		$this->objParam->defecto('ordenacion','id_almacen_gestion_log');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_almacen_gestion')!=''){
			$this->objParam->addFiltro("aglog.id_almacen_gestion = ".$this->objParam->getParametro('id_almacen_gestion'));
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAlmacenGestionLog','listarAlmacenGestionLog');
		} else{
			$this->objFunc=$this->create('MODAlmacenGestionLog');
			
			$this->res=$this->objFunc->listarAlmacenGestionLog($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAlmacenGestionLog(){
		$this->objFunc=$this->create('MODAlmacenGestionLog');	
		if($this->objParam->insertar('id_almacen_gestion_log')){
			$this->res=$this->objFunc->insertarAlmacenGestionLog($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAlmacenGestionLog($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlmacenGestionLog(){
			$this->objFunc=$this->create('MODAlmacenGestionLog');	
		$this->res=$this->objFunc->eliminarAlmacenGestionLog($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>