<?php
/**
 *@package sis_almacenes
 *@file MODAlmacen.php
 *@author  Gonzalo Sarmiento
 *@date 21-09-2012
 */

class MODAlmacen extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarAlmacen() {
        $this->procedimiento = 'alm.ft_almacen_sel';
        $this->transaccion = 'SAL_ALM_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_almacen', 'integer');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('localizacion', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('usr_reg', 'varchar');
        $this->captura('usr_mod', 'varchar');
        $this->captura('estado', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarAlmacen() {
        $this->procedimiento = 'alm.ft_almacen_ime';
        $this->transaccion = 'SAL_ALM_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('localizacion', 'localizacion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarAlmacen() {
        $this->procedimiento = 'alm.ft_almacen_ime';
        $this->transaccion = 'SAL_ALM_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('localizacion', 'localizacion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarAlmacen() {
        $this->procedimiento = 'alm.ft_almacen_ime';
        $this->transaccion = 'SAL_ALM_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_almacen', 'id_almacen', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function switchEstadoAlmacen() {
        $this->procedimiento = 'alm.ft_almacen_ime';
        $this->transaccion = 'SAL_SWEST_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_almacen', 'id_almacen', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
}
?>