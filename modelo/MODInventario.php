<?php
/**
 *@package pXP
 *@file gen-MODInventario.php
 *@author  (admin)
 *@date 15-03-2013 15:36:09
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODInventario extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarInventario() {
        $this->procedimiento = 'alm.ft_inventario_sel';
        $this->transaccion = 'SAL_INV_SEL';
        $this->tipo_procedimiento = 'SEL';
        //tipo de transaccion

        $this->captura('id_inventario', 'int4');
        $this->captura('estado_reg', 'varchar');
        $this->captura('id_almacen', 'int4');
        $this->captura('nombre_almacen', 'varchar');
        $this->captura('fecha_inv_planif', 'timestamp');
        $this->captura('estado', 'varchar');
        $this->captura('observaciones', 'varchar');
        $this->captura('fecha_inv_ejec', 'timestamp');
        $this->captura('completo', 'varchar');
        $this->captura('id_usuario_resp', 'int4');
        $this->captura('nombre_usuario', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('id_usuario_reg', 'int4');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('id_usuario_mod', 'int4');
        $this->captura('usr_reg', 'varchar');
        $this->captura('usr_mod', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INV_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_almacen', 'id_almacen', 'int4');
        $this->setParametro('fecha_inv_planif', 'fecha_inv_planif', 'timestamp');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('fecha_inv_ejec', 'fecha_inv_ejec', 'timestamp');
        $this->setParametro('completo', 'completo', 'varchar');
        $this->setParametro('id_usuario_resp', 'id_usuario_resp', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');
        $this->setParametro('id_almacen', 'id_almacen', 'int4');
        $this->setParametro('fecha_inv_planif', 'fecha_inv_planif', 'timestamp');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('fecha_inv_ejec', 'fecha_inv_ejec', 'timestamp');
        $this->setParametro('completo', 'completo', 'varchar');
        $this->setParametro('id_usuario_resp', 'id_usuario_resp', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INV_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function finalizarRegistro() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVFINREG_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function iniciarEjecucionInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVINIEJE_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function finalizarEjecucionInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVFINEJE_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function finalizarRevisionInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVFINREV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function corregirEjecucionInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVCORRREV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function revisarDiferenciasInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVREVDIF_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function nivelarDiferenciasInventario() {
        $this->procedimiento = 'alm.ft_inventario_ime';
        $this->transaccion = 'SAL_INVNIVMOV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
}
?>