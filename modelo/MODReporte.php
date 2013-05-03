<?php
/**
 *@package pXP
 *@file    MODMovimiento.php
 *@author  Ariel Ayaviri Omonte
 *@date    17-04-2013
 *@description: DAO para los reportes del sistema de almacenes
 */

class MODReporte extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarItemsPorAlmacenFecha() {
        $this->procedimiento = 'alm.ft_reporte_sel';
        $this->transaccion = 'SAL_REPEXIST_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('fecha_hasta', 'fecha_hasta', 'date');
        $this->setParametro('all_items', 'all_items', 'varchar');
        $this->setParametro('id_items', 'id_items', 'varchar');
        
        $this->captura('id_item', 'integer');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('unidad_medida', 'varchar');
        $this->captura('clasificacion', 'varchar');
        $this->captura('cantidad', 'numeric');
        $this->captura('costo', 'numeric');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>