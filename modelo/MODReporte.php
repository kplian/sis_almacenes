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
		$this->setParametro('saldo_cero', 'saldo_cero', 'varchar');
		$this->setParametro('id_clasificacion', 'id_clasificacion', 'varchar');
		
        $this->captura('id_item', 'integer');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('unidad_medida', 'varchar');
        $this->captura('clasificacion', 'varchar');
        $this->captura('cantidad', 'numeric');
        $this->captura('costo', 'numeric');

        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
	
	function listarKardexItem() {
        $this->procedimiento = 'alm.ft_rep_kardex_item_sel';
        $this->transaccion = 'SAL_RKARIT_SEL';
        $this->tipo_procedimiento = 'SEL';
		$this->tipo_retorno='record';
		$this->count=false;

		$this->setParametro('fecha_ini', 'fecha_ini', 'date');
		$this->setParametro('fecha_fin', 'fecha_fin', 'date');
		$this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'varchar');
        $this->setParametro('all_almacen', 'all_almacen', 'varchar');
		
		$this->captura('id', 'integer');
		$this->captura('fecha', 'date');
		$this->captura('nro_mov', 'varchar');
		$this->captura('almacen', 'varchar');
		$this->captura('ingreso', 'numeric');
		$this->captura('salida', 'numeric');
		$this->captura('saldo', 'numeric');
		$this->captura('costo_unitario', 'numeric');
		$this->captura('ingreso_val', 'numeric');
		$this->captura('salida_val', 'numeric');
		$this->captura('saldo_val', 'numeric');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>