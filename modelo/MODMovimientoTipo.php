<?php
/**
 *@package pXP
 *@file    MODMovimientoTipo.php
 *@author  Ariel Ayaviri Omonte
 *@date    13-02-2013
 */

class MODMovimientoTipo extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarMovimientoTipo() {
        $this->procedimiento = 'alm.ft_movimiento_tipo_sel';
        $this->transaccion = 'SAL_MOVTIP_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_movimiento_tipo', 'integer');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('tipo', 'varchar');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_mod', 'varchar');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('read_only', 'boolean');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarMovimientoTipo() {
        $this->procedimiento = 'alm.ft_movimiento_tipo_ime';
        $this->transaccion = 'SAL_MOVTIP_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('tipo', 'tipo', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarMovimientoTipo() {
        $this->procedimiento = 'alm.ft_movimiento_tipo_ime';
        $this->transaccion = 'SAL_MOVTIP_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_tipo', 'id_movimiento_tipo', 'integer');
        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('tipo', 'tipo', 'varchar');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarMovimientoTipo() {
        $this->procedimiento = 'alm.ft_movimiento_tipo_ime';
        $this->transaccion = 'SAL_MOVTIP_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_tipo', 'id_movimiento_tipo', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>