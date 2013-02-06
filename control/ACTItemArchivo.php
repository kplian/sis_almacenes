<?php
/**
 *@package       pXP
 *@file          ACTItemArchivo.php
 *@author        Ariel Ayaviri Omonte
 *@date          06-01-2013
 *@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
 */

class ACTItemArchivo extends ACTbase {

    function listarItemArchivo() {
        $this->objParam->defecto('ordenacion', 'id_item_archivo');
        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODItemArchivo', 'listarItemArchivo');
        } else {
            $this->objFunc = $this->create('MODItemArchivo');
            $this->res = $this->objFunc->listarItemArchivo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarItemArchivo() {
        $this->objFunc = $this->create('MODItemArchivo');
        if ($this->objParam->insertar('id_item_archivo')) {
            $this->res = $this->objFunc->insertarItemArchivo();
        } else {
            $this->res = $this->objFunc->modificarItemArchivo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarItemArchivo() {
        $this->objFunc = $this->create('MODItemArchivo');
        $this->res = $this->objFunc->eliminarItemArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function subirArchivo() {
        $this->objFunc = $this->create('MODItemArchivo');
        $this->res = $this->objFunc->subirItemArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>