<?php
/**
*@package pXP
*@file gen-ACTSalidaGrupoItem.php
*@author  (admin)
*@date 17-10-2013 20:34:52
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTSalidaGrupoItem extends ACTbase{    
			
	function listarSalidaGrupoItem(){
		$this->objParam->defecto('ordenacion','id_salida_grupo_item');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_salida_grupo')!=''){
			$this->objParam->addFiltro("sagrit.id_salida_grupo = ".$this->objParam->getParametro('id_salida_grupo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODSalidaGrupoItem','listarSalidaGrupoItem');
		} else{
			$this->objFunc=$this->create('MODSalidaGrupoItem');
			
			$this->res=$this->objFunc->listarSalidaGrupoItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSalidaGrupoItem(){
		$this->objFunc=$this->create('MODSalidaGrupoItem');	
		if($this->objParam->insertar('id_salida_grupo_item')){
			$this->res=$this->objFunc->insertarSalidaGrupoItem($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSalidaGrupoItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSalidaGrupoItem(){
			$this->objFunc=$this->create('MODSalidaGrupoItem');	
		$this->res=$this->objFunc->eliminarSalidaGrupoItem($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>