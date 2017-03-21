<?php
/**
 * @package pxP
 * @author Ariel Ayaviri Omonte
 * @file MODMovimientoDetalle.php
 * @date 19-02-2013
 * @description Clase que envia los parametros requeridos a la base de datos para la ejecucion de las funciones y recibe el resultado de le ejecucion de las mismas
 */

class MODMovimientoDetalle extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarMovimientoDetalle() {
        $this->procedimiento = 'alm.ft_movimiento_det_sel';
        $this->transaccion = 'SAL_MOVDET_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_movimiento', 'id_movimiento', 'int4');

        $this->captura('id_movimiento_det', 'int4');
        $this->captura('id_movimiento', 'int4');
        $this->captura('id_item', 'int4');
        $this->captura('nombre_item', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('codigo_unidad', 'varchar');
        $this->captura('cantidad_item', 'numeric');
        $this->captura('cantidad_solicitada', 'numeric');
        $this->captura('costo_unitario', 'numeric');
        $this->captura('fecha_caducidad', 'date');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_mod', 'varchar');
        $this->captura('fecha_mod', 'timestamp');
		$this->captura('codigo_item', 'varchar');
		$this->captura('costo_total', 'numeric');
		$this->captura('observaciones', 'varchar');
		$this->captura('id_concepto_ingas', 'int4');
        $this->captura('desc_concepto_ingas', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarMovimientoDetalle() {
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOVDET_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');
        $this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('cantidad_item', 'cantidad_item', 'numeric');
        $this->setParametro('cantidad_solicitada', 'cantidad_solicitada', 'numeric');
        $this->setParametro('costo_unitario', 'costo_unitario', 'numeric');
        $this->setParametro('fecha_caducidad', 'fecha_caducidad', 'date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_concepto_ingas', 'id_concepto_ingas', 'integer');
	
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarMovimientoDetalle() {
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOVDET_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_det', 'id_movimiento_det', 'integer');
        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');
        $this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('cantidad_item', 'cantidad_item', 'numeric');
        $this->setParametro('cantidad_solicitada', 'cantidad_solicitada', 'numeric');
        $this->setParametro('costo_unitario', 'costo_unitario', 'numeric');
        $this->setParametro('fecha_caducidad', 'fecha_caducidad', 'date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_concepto_ingas', 'id_concepto_ingas', 'integer');
								
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarMovimientoDetalle() {
        $this->procedimiento = 'alm.ft_movimiento_det_ime';
        $this->transaccion = 'SAL_MOVDET_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_det', 'id_movimiento_det', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>