<?php
/**
 * @Package pxP
 * @file    ACTAlmacen.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
require_once (dirname(__FILE__) . '/../reportes/pxpReport/ReportWriter.php');
require_once (dirname(__FILE__) . '/../reportes/RExistencias.php');
require_once (dirname(__FILE__) . '/../reportes/pxpReport/DataSource.php');
 
class ACTReportes extends ACTbase {

    function reporteExistencias() {
        
        //TODO: pasos para el reporte:
        //iterar sobre el array de ids de almacenes
            //Obtener el listado de los items ordenados por clasificacion y por fecha de un determinado almacen:
        $idAlmacen = $this->objParam->getParametro('id_almacen');
        $fechaHasta = $this->objParam->getParametro('fecha_hasta');
        $this->objParam->addParametroConsulta('ordenacion', 'cla.id_clasificacion');
        $this->objParam->addParametroConsulta('dir_ordenacion', 'asc');
        $this->objParam->addParametroConsulta('cantidad', 10000);
        $this->objParam->addParametroConsulta('puntero', 0);
        $this->objFunc = $this->create('MODReporte');
        $resultRepExistencias = $this->objFunc->listarItemsPorAlmacenFecha($this->objParam);
		//var_dump($resultRepExistencias->getDatos());
        
        $dataSource = new DataSource();
        $resultData = $resultRepExistencias->getDatos();
        $lastNombreClasificacion = $resultData[0]['clasificacion'];
        $dataSourceArray = Array();
        $dataSourceClasificacion = new DataSource();
        $dataSetClasificacion = Array();
        $totalCostoClasificacion = 0;
        $mainDataSet = array();
        $costoTotal = 0;
        foreach ($resultData as $row) {
            if ($row['clasificacion'] != $lastNombreClasificacion) {
                $costoTotal += $totalCostoClasificacion;
                $mainDataSet[] = array("nombreClasificacion" => $lastNombreClasificacion, "totalClasificacion" => $totalCostoClasificacion);
                $dataSourceClasificacion->setDataSet($dataSetClasificacion);
                $dataSourceClasificacion->putParameter('totalCosto', $totalCostoClasificacion);
                $dataSourceClasificacion->putParameter('nombreClasificacion', $lastNombreClasificacion);
                $dataSourceArray[] = $dataSourceClasificacion;

                $lastNombreClasificacion = $row['clasificacion'];
                $dataSourceClasificacion = new DataSource();
                $dataSetClasificacion = Array();
                $totalCostoClasificacion = 0;
            }
            $dataSetClasificacion[] = $row;
            $totalCostoClasificacion += $row['costo'];
        }
        $costoTotal += $totalCostoClasificacion;
        $mainDataSet[] = array("nombreClasificacion" => $lastNombreClasificacion, "totalClasificacion" => $totalCostoClasificacion);
        $dataSourceClasificacion->setDataSet($dataSetClasificacion);
        $dataSourceClasificacion->putParameter('totalCosto', $totalCostoClasificacion);
        $dataSourceClasificacion->putParameter('nombreClasificacion', $lastNombreClasificacion);
        $dataSourceArray[] = $dataSourceClasificacion;
        
        $dataSource->putParameter('clasificacionDataSources', $dataSourceArray);
        $dataSource->putParameter('costoTotal', $costoTotal);
        $dataSource->putParameter('fechaHasta', $fechaHasta);
        $dataSource->setDataSet($mainDataSet);
        
        $reporte = new RExistencias();
        
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'Existencias.pdf';
        $reportWriter = new ReportWriter($reporte, dirname(__FILE__) . '/../../reportes_generados/' . $nombreArchivo);
        $reportWriter->writeReport(ReportWriter::PDF);

        $mensajeExito = new Mensaje();
        $mensajeExito->setMensaje('EXITO', 'Reporte.php', 'Reporte generado', 'Se generó con éxito el reporte: ' . $nombreArchivo, 'control');
        $mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->res = $mensajeExito;
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

	function listarKardexItem() {
        $this->objParam->defecto('ordenacion', 'codigo');
        $this->objParam->defecto('dir_ordenacion', 'asc');
		
        if ($this->objParam->getParametro('tipoReporte') == 'excel_grid' || $this->objParam->getParametro('tipoReporte') == 'pdf_grid') {
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODReporte', 'listarKardexItem');
        } else {
            $this->objFunc = $this->create('MODReporte');
            $this->res = $this->objFunc->listarKardexItem();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}
?>
