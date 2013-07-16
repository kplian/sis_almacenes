<?php
/**
 *@package pXP
 *@file MODClasificacion.php
 *@author  Gonzalo Sarmiento
 *@date 21-09-2012
 *@description Clase que envia los parametros requeridos a la Base de datos para
 *             la ejecucion de las funciones, y que recibe la respuesta del
 *             resultado de la ejecucion de las mismas
 */

class MODClasificacion extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarClasificacion() {
        $this->procedimiento = 'alm.ft_clasificacion_sel';
        $this->transaccion = 'ALM_CLA_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_clasificacion', 'integer');
        $this->captura('nombre', 'varchar');
        $this->captura('codigo_largo', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function listarClasificacionArb() {
        $this->procedimiento = 'alm.ft_clasificacion_sel';
        $this->setCount(false);
        $this->transaccion = 'ALM_CLA_ARB_SEL';
        $this->tipo_procedimiento = 'SEL';

        $id_padre = $this->objParam->getParametro('id_padre');
        $this->setParametro('id_padre', 'id_padre', 'varchar');

        $this->captura('id_clasificacion', 'int4');
        $this->captura('id_clasificacion_fk', 'int4');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('tipo_nodo', 'varchar');
        $this->captura('codigo_largo', 'varchar');
        $this->captura('estado', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        if ($this->respuesta->getTipo() == 'ERROR') {
            return $this->respuesta;
        } 
        
        if($this->objParam->getParametro('clasificacion')){
        		  return $this->respuesta;
        }
        else {
            $this->procedimiento = 'alm.ft_item_sel';
            $this->transaccion = 'SAL_ARB_SEL';
            $this->tipo_procedimiento = 'SEL';
            $this->setCount(false);
            $this->resetCaptura();
            $this->addConsulta();

            $this->setParametro('id_clasificacion', 'id_padre', 'varchar');

            $this->captura('id_item', 'integer');
            $this->captura('nombre', 'varchar');
            $this->captura('codigo', 'varchar');
            $this->captura('id_clasificacion_fk', 'integer');
            $this->captura('id_clasificacion', 'varchar');
            $this->captura('tipo_nodo', 'varchar');

            $this->armarConsulta();
            $consulta = $this->getConsulta();

            $this->ejecutarConsulta($this->respuesta);
        }

        return $this->respuesta;
    }

    function insertarClasificacion() {
        $this->procedimiento = 'alm.ft_clasificacion_ime';
        $this->transaccion = 'SAL_CLA_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_clasificacion_fk', 'id_clasificacion_fk', 'integer');
        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarClasificacion() {
        $this->procedimiento = 'alm.ft_clasificacion_ime';
        $this->transaccion = 'SAL_CLA_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_clasificacion', 'id_clasificacion', 'integer');
        $this->setParametro('id_clasificacion_fk', 'id_clasificacion_fk', 'integer');
        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarClasificacion() {
        $this->procedimiento = 'alm.ft_clasificacion_ime';
        $this->transaccion = 'SAL_CLA_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_clasificacion', 'id_clasificacion', 'integer');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function cambiarEstadoClasificacion() {
        $this->procedimiento = 'alm.ft_clasificacion_ime';
        $this->transaccion = 'SAL_ESTCLA_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_clasificacion', 'id_clasificacion', 'int4');
        $this->setParametro('estado', 'estado', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function guardarDragDrop() {
        $this->procedimiento = 'alm.ft_clasificacion_ime';
        $this->transaccion = 'SAL_CLADD_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('punto', 'point', 'varchar');
        $this->setParametro('id_nodo', 'id_nodo', 'integer');
        $this->setParametro('id_old_parent', 'id_old_parent', 'integer');
        $this->setParametro('id_target', 'id_target', 'integer');
        $this->setParametro('tipo_nodo', 'tipo_nodo', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }

}
?>