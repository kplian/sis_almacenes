<?php
/**
*@package pXP
*@file gen-ACTSalidaGrupoFun.php
*@author  (admin)
*@date 18-10-2013 02:54:34
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTSalidaGrupoFun extends ACTbase{    
			
	function listarSalidaGrupoFun(){
		$this->objParam->defecto('ordenacion','id_salida_grupo_fun');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_salida_grupo_item')!=''){
			$this->objParam->addFiltro("gritfu.id_salida_grupo_item = ".$this->objParam->getParametro('id_salida_grupo_item'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODSalidaGrupoFun','listarSalidaGrupoFun');
		} else{
			$this->objFunc=$this->create('MODSalidaGrupoFun');
			
			$this->res=$this->objFunc->listarSalidaGrupoFun($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSalidaGrupoFun(){
		$this->objFunc=$this->create('MODSalidaGrupoFun');	
		if($this->objParam->insertar('id_salida_grupo_fun')){
			$this->res=$this->objFunc->insertarSalidaGrupoFun($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSalidaGrupoFun($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSalidaGrupoFun(){
			$this->objFunc=$this->create('MODSalidaGrupoFun');	
		$this->res=$this->objFunc->eliminarSalidaGrupoFun($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>