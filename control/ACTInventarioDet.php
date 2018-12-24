<?php
/**
 *@package pXP
 *@file gen-ACTInventarioDet.php
 *@author  (admin)
 *@date 15-03-2013 21:26:02
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTInventarioDet extends ACTbase {

    function listarInventarioDet() {
        $this->objParam->defecto('ordenacion', 'id_inventario_det');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODInventarioDet', 'listarInventarioDet');
        } else {
            $this->objFunc = $this->create('MODInventarioDet');

            $this->res = $this->objFunc->listarInventarioDet($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarInventarioDet() {
        $this->objFunc = $this->create('MODInventarioDet');
        if ($this->objParam->insertar('id_inventario_det')) {
            $this->res = $this->objFunc->insertarInventarioDet($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarInventarioDet($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarInventarioDet() {
        $this->objFunc = $this->create('MODInventarioDet');
        $this->res = $this->objFunc->eliminarInventarioDet($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>