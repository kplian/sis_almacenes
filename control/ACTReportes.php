<?php
/**
 * @Package pxP
 * @file    ACTAlmacen.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */

class ACTReportes extends ACTbase {

    function reporteExistencias() {
        
        //TODO: pasos para el reporte:
        //iterar sobre el array de ids de almacenes
            //Obtener el listado de los items ordenados por clasificacion y por fecha de un determinado almacen:
        $idAlmacen = $this->objParam->getParametro('id_almacen');
        $fechaHasta = $this->objParam->getParametro('fecha_hasta');
        $this->objParam->addParametroConsulta('filtro', ' movdet.id_movimiento = ' . $idMovimiento);
        $this->objParam->addParametroConsulta('filtro', ' mov.fecha_mov = ' . $idMovimiento);
        $this->objParam->addParametroConsulta('ordenacion', 'cla.id_clasificacion');
        $this->objParam->addParametroConsulta('dir_ordenacion', 'asc');
        $this->objParam->addParametroConsulta('cantidad', 10000);
        $this->objParam->addParametroConsulta('puntero', 0);
        $this->objFunc = $this->create('MODReporte');
        $resultRepExistencias = $this->objFunc->reporteExistencias($this->objParam);

        $resultData = $resultRepExistencias->getDatos();
        $lastNombreClasificacion = $resultData[0]['nombre_clasificacion'];
        $dataSourceArray = Array();
        $dataSourceClasificacion = new DataSource();
        $dataSetClasificacion = Array();
        $totalCostoClasificacion = 0;
        $mainDataSet = array();
        $costoTotal = 0;
        foreach ($resultRepMovimiento->getDatos() as $row) {
            if ($row['nombre_clasificacion'] != $lastNombreClasificacion) {
                $costoTotal += $totalCostoClasificacion;
                $mainDataSet[] = array("nombreClasificacion" => $lastNombreClasificacion, "totalClasificacion" => $totalCostoClasificacion);
                $dataSourceClasificacion->setDataSet($dataSetClasificacion);
                $dataSourceClasificacion->putParameter('totalCosto', $totalCostoClasificacion);
                $dataSourceClasificacion->putParameter('nombreClasificacion', $lastNombreClasificacion);
                $dataSourceArray[] = $dataSourceClasificacion;

                $lastNombreClasificacion = $row['nombre_clasificacion'];
                $dataSourceClasificacion = new DataSource();
                $dataSetClasificacion = Array();
                $totalCostoClasificacion = 0;
            }
            $dataSetClasificacion[] = $row;
            $totalCostoClasificacion += $row['costo_total'];
        }
        $costoTotal += $totalCostoClasificacion;
        $mainDataSet[] = array("nombreClasificacion" => $lastNombreClasificacion, "totalClasificacion" => $totalCostoClasificacion);
        $dataSourceClasificacion->setDataSet($dataSetClasificacion);
        $dataSourceClasificacion->putParameter('totalCosto', $totalCostoClasificacion);
        $dataSourceClasificacion->putParameter('nombreClasificacion', $lastNombreClasificacion);
        $dataSourceArray[] = $dataSourceClasificacion;
    }
}
?>
