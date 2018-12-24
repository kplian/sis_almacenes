<?php
/**
 * @Package pxP
 * @file    ACTMetodoVal.php
 * @author  Ariel Ayaviri Omonte
 * @date    13-02-2013
 */

class ACTMetodoVal extends ACTbase {

    function listarMetodoVal() {
        $this->objParam->defecto('ordenacion', 'id_metodo_val');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMetodoVal', 'listarMetodoVal');
        } else {
            $this->objFunc = $this->create('MODMetodoVal');
            $this->res = $this->objFunc->listarMetodoVal();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarMetodoVal() {
        $this->objFunc = $this->create('MODMetodoVal');
        if ($this->objParam->insertar('id_metodo_val')) {
            $this->res = $this->objFunc->insertarMetodoVal();
        } else {
            $this->res = $this->objFunc->modificarMetodoVal();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarMetodoVal() {
        $this->objFunc = $this->create('MODMetodoVal');
        $this->res = $this->objFunc->eliminarMetodoVal();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>
