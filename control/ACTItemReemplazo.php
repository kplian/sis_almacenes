<?php
/**
 *@package pXP
 *@file gen-ACTItem.php
 *@author  (admin)
 *@date 17-08-2012 11:18:22
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTItemReemplazo extends ACTbase {

    function listarItemReemplazo() {
        $this->objParam->defecto('ordenacion', 'id_item_reemplazo');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODItemReemplazo', 'listarItemReemplazo');
        } else {
            $this->objFunc = $this->create('MODItemReemplazo');
            $this->res = $this->objFunc->listarItemReemplazo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarItemReemplazo() {
        $this->objFunc = $this->create('MODItemReemplazo');
        if ($this->objParam->insertar('id_item_reemplazo')) {
            $this->res = $this->objFunc->insertarItemReemplazo();
        } else {
            $this->res = $this->objFunc->modificarItemReemplazo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarItemReemplazo() {
        $this->objFunc = $this->create('MODItemReemplazo');
        $this->res = $this->objFunc->eliminarItemReemplazo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>