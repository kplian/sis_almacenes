<?php
/**
 * @Package pxP
 * @file    ACTMovimientoTipo.php
 * @author  Ariel Ayaviri Omonte
 * @date    13-02-2013
 */

class ACTMovimientoTipo extends ACTbase {

    function listarMovimientoTipo() {
        $this->objParam->defecto('ordenacion', 'id_movimiento_tipo');
        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMovimientoTipo', 'listarMovimientoTipo');
        } else {
            if($this->objParam->getParametro('tipo') != null && $this->objParam->getParametro('tipo') != '') {
                $this->objParam->addFiltro(" movtip.tipo like ''%".$this->objParam->getParametro('tipo')."%''");
            }
            $this->objFunc = $this->create('MODMovimientoTipo');
            $this->res = $this->objFunc->listarMovimientoTipo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarMovimientoTipoCargo() {
        $this->objParam->defecto('ordenacion', 'id_movimiento_tipo');
        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMovimientoTipo', 'listarMovimientoTipo');
        } else {
            if($this->objParam->getParametro('tipo') != null && $this->objParam->getParametro('tipo') != '') {
                $this->objParam->addFiltro(" movtip.tipo like ''%".$this->objParam->getParametro('tipo')."%''");
            }
            $this->objParam->addParametro('id_funcionario_usu',$_SESSION["ss_id_funcionario"]);
            $this->objFunc = $this->create('MODMovimientoTipo');
            $this->res = $this->objFunc->listarMovimientoTipoCargo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarMovimientoTipo() {
        $this->objFunc = $this->create('MODMovimientoTipo');
        if ($this->objParam->insertar('id_movimiento_tipo')) {
            $this->res = $this->objFunc->insertarMovimientoTipo();
        } else {
            $this->res = $this->objFunc->modificarMovimientoTipo();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarMovimientoTipo() {
        $this->objFunc = $this->create('MODMovimientoTipo');
        $this->res = $this->objFunc->eliminarMovimientoTipo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>
