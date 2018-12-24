<?php
/**
 *@package pXP
 *@file    ACTDetalleMateriales.php
 *@author  Gonzalo Sarmiento
 *@date    02-10-2012
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTMovimientoDetValorado extends ACTbase {

    function listarMovimientoDetValorado() {
        $this->objParam->defecto('ordenacion', 'id_movimiento_det_valorado');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMovimientoDetValorado', 'listarMovimientoDetValorado');
        } else {
            $this->objFunc = $this->create('MODMovimientoDetValorado');
            $this->res = $this->objFunc->listarMovimientoDetValorado();
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }

    function insertarMovimientoDetValorado() {
        $this->objFunc = $this->create('MODMovimientoDetValorado');
        if ($this->objParam->insertar('id_movimiento_det_valorado')) {
            $this->res = $this->objFunc->insertarMovimientoDetValorado();
        } else {
            $this->res = $this->objFunc->modificarMovimientoDetValorado();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarMovimientoDetValorado() {
        $this->objFunc = $this->create('MODMovimientoDetValorado');
        $this->res = $this->objFunc->eliminarMovimientoDetValorado();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>