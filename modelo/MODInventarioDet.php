<?php
/**
 *@package pXP
 *@file gen-MODInventarioDet.php
 *@author  (admin)
 *@date 15-03-2013 21:26:02
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODInventarioDet extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarInventarioDet() {
        $this->procedimiento = 'alm.ft_inventario_det_sel';
        $this->transaccion = 'SAL_DINV_SEL';
        $this->tipo_procedimiento = 'SEL';
        
        $this->setParametro('id_inventario', 'id_inventario', 'int4');
								$this->setParametro('id_almacen', 'id_almacen', 'int4');
        
        $this->captura('id_inventario_det', 'int4');
        $this->captura('estado_reg', 'varchar');
        $this->captura('id_item', 'int4');
        $this->captura('nombre_item', 'varchar');
        $this->captura('codigo_item', 'varchar');
        $this->captura('diferencia', 'numeric');
        $this->captura('observaciones', 'varchar');
        $this->captura('cantidad_real', 'numeric');
        $this->captura('cantidad_sistema', 'numeric');
        $this->captura('id_inventario', 'int4');
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

    function insertarInventarioDet() {
        $this->procedimiento = 'alm.ft_inventario_det_ime';
        $this->transaccion = 'SAL_DINV_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'int4');
        $this->setParametro('id_almacen', 'id_almacen', 'int4');
								$this->setParametro('id_clasificacion','id_clasificacion','int4');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('cantidad_real', 'cantidad_real', 'numeric');
        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarInventarioDet() {
        $this->procedimiento = 'alm.ft_inventario_det_ime';
        $this->transaccion = 'SAL_DINV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario_det', 'id_inventario_det', 'int4');
        $this->setParametro('id_almacen', 'id_almacen', 'int4');
        $this->setParametro('id_item', 'id_item', 'int4');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('cantidad_real', 'cantidad_real', 'numeric');
        $this->setParametro('id_inventario', 'id_inventario', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarInventarioDet() {
        $this->procedimiento = 'alm.ft_inventario_det_ime';
        $this->transaccion = 'SAL_DINV_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_inventario_det', 'id_inventario_det', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>