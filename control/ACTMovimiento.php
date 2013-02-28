<?php
/**
 * @Package pxP
 * @file    ACTMovimiento.php
 * @author  Gonzalo Sarmiento
 * @date    02-10-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RMovimiento.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');
 
class ACTMovimiento extends ACTbase {

    function listarMovimiento() {
        $this->objParam->defecto('ordenacion', 'fecha_mov');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODMovimiento', 'listarMovimiento');
        } else {
            if ($this->objParam->getParametro('estado_mov') != null) {
                $this->objParam->addFiltro(" mov.estado_mov = ''" . $this->objParam->getParametro('estado_mov') . "'' ");
            }
            if ($this->objParam->getParametro('tipo') != null) {
                $this->objParam->addFiltro(" movtip.tipo = ''" . $this->objParam->getParametro('tipo') . "'' ");
            }
            $this->objFunc = $this->create('MODMovimiento');
            $this->res = $this->objFunc->listarMovimiento();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarMovimiento() {
        $this->objFunc = $this->create('MODMovimiento');
        if ($this->objParam->insertar('id_movimiento')) {
            $this->res = $this->objFunc->insertarMovimiento();
        } else {
            $this->res = $this->objFunc->modificarMovimiento();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarMovimiento() {
        $this->objFunc = $this->create('MODMovimiento');
        $this->res = $this->objFunc->eliminarMovimiento();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function finalizarMovimiento() {
        $this->objFunc = $this->create('MODMovimiento');
        $this->res = $this->objFunc->finalizarMovimiento();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function cancelarMovimiento() {
        $this->objFunc = $this->create('MODMovimiento');
        $this->res = $this->objFunc->cancelarMovimiento();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function revertirMovimiento() {
        $this->objFunc = $this->create('MODMovimiento');
        $this->res = $this->objFunc->revertirMovimiento();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function generarReporteMovimiento() {
        $dataSource = new DataSource();
        $idMovimiento = $this->objParam->getParametro('id_movimiento');
        $this->objParam->addParametroConsulta('filtro', ' movdet.id_movimiento = '.$idMovimiento);
        $this->objParam->addParametroConsulta('ordenacion', 'movdet.id_movimiento_det');
        $this->objParam->addParametroConsulta('dir_ordenacion', 'asc');
        $this->objParam->addParametroConsulta('cantidad', 1000);
        $this->objParam->addParametroConsulta('puntero', 0);
        $this->objFunc = $this->create('MODMovimiento');
        $resultRepMovimiento = $this->objFunc->listarReporteMovimiento($this->objParam);
        $dataSource->setDataset($resultRepMovimiento->getDatos());
        
        //se obtienen los totales de los resultados
        $totalCantidad = 0;
        $totalCosto = 0;
        
        foreach($resultRepMovimiento->getDatos() as $row) {
            $totalCantidad += $row['cantidad'];
            $totalCosto += $row['costo_total'];
        }
        
        $this->objParam->addParametroConsulta('filtro', ' mov.id_movimiento = '.$idMovimiento);
        $this->objParam->addParametroConsulta('ordenacion', 'mov.id_movimiento');
        $this->objParam->addParametroConsulta('cantidad', 1);
        $this->objFunc = $this->create('MODMovimiento');
        $resultMovimiento = $this->objFunc->listarMovimiento($this->objParam);
        $datosMovimiento = $resultMovimiento->getDatos();
        
        $dataSource->putParameter('codigo', $datosMovimiento[0]['codigo']);
        $dataSource->putParameter('tipo', $datosMovimiento[0]['tipo']);
        $dataSource->putParameter('almacen', $datosMovimiento[0]['nombre_almacen']);
        $dataSource->putParameter('motivo', $datosMovimiento[0]['nombre_movimiento_tipo']);
        $dataSource->putParameter('descripcion', $datosMovimiento[0]['descripcion']);
        $dataSource->putParameter('observaciones', $datosMovimiento[0]['observaciones']);
        $dataSource->putParameter('fechaRemision', $datosMovimiento[0]['fecha_reg']);
        $dataSource->putParameter('fechaMovimiento', $datosMovimiento[0]['fecha_mov']);
        $dataSource->putParameter('totalCantidad', $totalCantidad);
        $dataSource->putParameter('totalCosto', $totalCosto);
        
        $reporte = new RMovimiento();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'Movimiento.pdf';
        $reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
        $reportWriter->writeReport(ReportWriter::PDF);
        
        $mensajeExito = new Mensaje();
        $mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
                                        'Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->res = $mensajeExito;
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>
