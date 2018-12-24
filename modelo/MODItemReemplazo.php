<?php
/**
 *@package pXP
 *@file  MODItem.php
 *@author  Gonzalo Sarmiento
 *@date 01-10-2012
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODItemReemplazo extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarItemReemplazo() {
        $this->procedimiento = 'alm.ft_item_reemplazo_sel';
        $this->transaccion = 'SAL_ITMREE_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_item', 'id_item', 'integer');

        $this->captura('id_item_reemplazo', 'integer');
        $this->captura('id_item', 'integer');
        $this->captura('id_item_r', 'integer');
        $this->captura('nombre', 'varchar');
        $this->captura('codigo', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('palabras_clave', 'varchar');
        $this->captura('codigo_fabrica', 'varchar');
        $this->captura('observaciones', 'varchar');
        $this->captura('numero_serie', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarItemReemplazo() {
        $this->procedimiento = 'alm.ft_item_reemplazo_ime';
        $this->transaccion = 'SAL_ITMREE_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('id_item_r', 'id_item_r', 'integer');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarItemReemplazo() {
        $this->procedimiento = 'alm.ft_item_reemplazo_ime';
        $this->transaccion = 'SAL_ITMREE_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item_reemplazo', 'id_item_reemplazo', 'integer');
        $this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('id_item_r', 'id_item_r', 'integer');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarItemReemplazo() {
        $this->procedimiento = 'alm.ft_item_reemplazo_ime';
        $this->transaccion = 'SAL_ITMREE_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item_reemplazo', 'id_item_reemplazo', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>