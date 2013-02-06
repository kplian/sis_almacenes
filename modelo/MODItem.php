<?php
/**
 *@package pXP
 *@file  MODItem.php
 *@author  Gonzalo Sarmiento
 *@date 01-10-2012
 *@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODItem extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarItem() {
        $this->procedimiento = 'alm.ft_item_sel';
        $this->transaccion = 'SAL_ITEM_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_item', 'integer');
        $this->captura('id_clasificacion', 'integer');
        $this->captura('desc_clasificacion', 'varchar');
        $this->captura('codigo_largo', 'varchar');
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

    function listarItemNotBase() {
        $this->procedimiento = 'alm.ft_item_sel';
        $this->transaccion = 'SAL_ITEMNOTBASE_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_item', 'integer');
        $this->captura('id_clasificacion', 'integer');
        $this->captura('desc_clasificacion', 'varchar');
        $this->captura('codigo_largo', 'varchar');
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

    function insertarItem() {
        $this->procedimiento = 'alm.ft_item_ime';
        $this->transaccion = 'SAL_ITEM_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_clasificacion', 'id_clasificacion', 'integer');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');
        $this->setParametro('palabras_clave', 'palabras_clave', 'varchar');
        $this->setParametro('codigo_fabrica', 'codigo_fabrica', 'varchar');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('numero_serie', 'numero_serie', 'varchar');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarItem() {
        $this->procedimiento = 'alm.ft_item_ime';
        $this->transaccion = 'SAL_ITEM_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'integer');
        $this->setParametro('id_clasificacion', 'id_clasificacion', 'integer');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');
        $this->setParametro('palabras_clave', 'palabras_clave', 'varchar');
        $this->setParametro('codigo_fabrica', 'codigo_fabrica', 'varchar');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('numero_serie', 'numero_serie', 'varchar');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarItem() {
        $this->procedimiento = 'alm.ft_item_ime';
        $this->transaccion = 'SAL_ITEM_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
    
    function generarCodigoItem() {
        $this->procedimiento = 'alm.ft_item_ime';
        $this->transaccion = 'SAL_GENCODE_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'int4');
        $this->setParametro('id_clasificacion', 'id_clasificacion', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
}
?>