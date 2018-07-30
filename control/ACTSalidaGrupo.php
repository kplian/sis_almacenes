<?php
/**
*@package pXP
*@file gen-ACTSalidaGrupo.php
*@author  (admin)
*@date 17-10-2013 18:50:00
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTSalidaGrupo extends ACTbase{    
			
	function listarSalidaGrupo(){
		$this->objParam->defecto('ordenacion','id_salida_grupo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODSalidaGrupo','listarSalidaGrupo');
		} else{
			$this->objFunc=$this->create('MODSalidaGrupo');
			
			$this->res=$this->objFunc->listarSalidaGrupo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSalidaGrupo(){
		$this->objFunc=$this->create('MODSalidaGrupo');	
		if($this->objParam->insertar('id_salida_grupo')){
			$this->res=$this->objFunc->insertarSalidaGrupo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSalidaGrupo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSalidaGrupo(){
			$this->objFunc=$this->create('MODSalidaGrupo');	
		$this->res=$this->objFunc->eliminarSalidaGrupo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function finalizarSalidaGrupo(){
		$this->objFunc=$this->create('MODSalidaGrupo');	
		$this->res=$this->objFunc->finalizarSalidaGrupo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function retrocederSalidaGrupo(){
		$this->objFunc=$this->create('MODSalidaGrupo');	
		$this->res=$this->objFunc->retrocederSalidaGrupo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>