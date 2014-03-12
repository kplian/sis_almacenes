<?php
/**
*@package pXP
*@file gen-ACTPreingreso.php
*@author  (admin)
*@date 07-10-2013 16:56:43
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPreingreso extends ACTbase{    
			
	function listarPreingreso(){
		$this->objParam->defecto('ordenacion','id_preingreso');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		
		//si es un preingreso de almances
		if($this->objParam->getParametro('tipo_interfaz')=='preingresoAlm'){
            $this->objParam->addFiltro("tipo = ''almacen''");  
        }
        //si es un preingreso de activos fijos
        if($this->objParam->getParametro('tipo_interfaz')=='preingresoAct'){
            $this->objParam->addFiltro("tipo = ''activo_fijo''");  
        }
		
		
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPreingreso','listarPreingreso');
		} else{
			$this->objFunc=$this->create('MODPreingreso');
			
			$this->res=$this->objFunc->listarPreingreso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPreingreso(){
		$this->objFunc=$this->create('MODPreingreso');	
		if($this->objParam->insertar('id_preingreso')){
			$this->res=$this->objFunc->insertarPreingreso($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPreingreso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPreingreso(){
			$this->objFunc=$this->create('MODPreingreso');	
		$this->res=$this->objFunc->eliminarPreingreso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function generarIngreso(){
		$this->objFunc=$this->create('MODPreingreso');	
		$this->res=$this->objFunc->generarIngreso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function revertirPreingreso(){
		$this->objFunc=$this->create('MODPreingreso');	
		$this->res=$this->objFunc->revertirPreingreso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>