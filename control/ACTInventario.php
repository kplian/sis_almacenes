<?php
/**
 *@package pXP
 *@file gen-ACTInventario.php
 *@author  (admin)
 *@date 15-03-2013 15:36:09
 *@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTInventario extends ACTbase {

    function listarInventario() {
        $this->objParam->defecto('ordenacion', 'id_inventario');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODInventario', 'listarInventario');
        } else {
            if ($this->objParam->getParametro('nombreVista') == 'EjecucionInventario') {
                $this->objParam->addFiltro(" inv.estado in (''pendiente_ejecucion'',''ejecucion'')");
            }
            $this->objFunc = $this->create('MODInventario');
            $this->res = $this->objFunc->listarInventario($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarInventario() {
        $this->objFunc = $this->create('MODInventario');
        if ($this->objParam->insertar('id_inventario')) {
            $this->res = $this->objFunc->insertarInventario($this->objParam);
        } else {
            $this->res = $this->objFunc->modificarInventario($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarInventario() {
        $this->objFunc = $this->create('MODInventario');
        $this->res = $this->objFunc->eliminarInventario($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function finalizarRegistro() {
        $this->objFunc = $this->create('MODInventario');
        $this->res = $this->objFunc->finalizarRegistro($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function iniciarEjecucionInventario() {
        $this->objFunc = $this->create('MODInventario');
        $this->res = $this->objFunc->iniciarEjecucionInventario($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function finalizarEjecucionInventario() {
        $this->objFunc = $this->create('MODInventario');
        $this->res = $this->objFunc->finalizarEjecucionInventario($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function finalizarRevisionInventario() {
        $this->objFunc = $this->create('MODInventario');
        $this->res = $this->objFunc->finalizarRevisionInventario($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>