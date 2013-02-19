<?php
/**
 *@package pXP
 *@file    ACTDetalleMateriales.php
 *@author  Gonzalo Sarmiento
 *@date    02-10-2012
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTMovimientoDetalle extends ACTbase {

    function listarMovimientoDetalle() {
        $this->objParam->defecto('ordenacion', 'id_movimiento_det');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMovimientoDetalle', 'listarMovimientoDetalle');
        } else {
            $this->objFunc = $this->create('MODMovimientoDetalle');
            $this->res = $this->objFunc->listarMovimientoDetalle();
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }

    function insertarMovimientoDetalle() {
        $this->objFunc = $this->create('MODMovimientoDetalle');
        if ($this->objParam->insertar('id_movimiento_det')) {
            $this->res = $this->objFunc->insertarMovimientoDetalle();
        } else {
            $this->res = $this->objFunc->modificarMovimientoDetalle();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarMovimientoDetalle() {
        $this->objFunc = $this->create('MODMovimientoDetalle');
        $this->res = $this->objFunc->eliminarMovimientoDetalle();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>