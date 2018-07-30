<?php
/**
 * @package pxP
 * @author Ariel Ayaviri Omonte
 * @file MODMovimientoDetValorado.php
 * @date 19-02-2013
 * @description Clase que envia los parametros requeridos a la base de datos para la ejecucion de las funciones y recibe el resultado de le ejecucion de las mismas
 */

class MODMovimientoDetValorado extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarMovimientoDetValorado() {
        $this->procedimiento = 'alm.ft_movimiento_det_valorado_sel';
        $this->transaccion = 'SAL_DETVAL_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_movimiento_det', 'id_movimiento_det', 'int4');

        $this->captura('id_movimiento_det_valorado', 'int4');
        $this->captura('id_movimiento_det', 'int4');
        $this->captura('cantidad_item', 'numeric');
        $this->captura('costo_unitario', 'numeric');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_mod', 'varchar');
        $this->captura('fecha_mod', 'timestamp');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarMovimientoDetValorado() {
        $this->procedimiento = 'alm.ft_movimiento_det_valorado_ime';
        $this->transaccion = 'SAL_DETVAL_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_det', 'id_movimiento_det', 'integer');
        $this->setParametro('cantidad_item', 'cantidad_item', 'numeric');
        $this->setParametro('costo_unitario', 'costo_unitario', 'numeric');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarMovimientoDetValorado() {
        $this->procedimiento = 'alm.ft_movimiento_det_valorado_ime';
        $this->transaccion = 'SAL_DETVAL_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_det_valorado', 'id_movimiento_det_valorado', 'integer');
        $this->setParametro('id_movimiento_det', 'id_movimiento_det', 'integer');
        $this->setParametro('cantidad_item', 'cantidad_item', 'numeric');
        $this->setParametro('costo_unitario', 'costo_unitario', 'numeric');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarMovimientoDetValorado() {
        $this->procedimiento = 'alm.ft_movimiento_det_valorado_ime';
        $this->transaccion = 'SAL_DETVAL_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_det_valorado', 'id_movimiento_det_valorado', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>