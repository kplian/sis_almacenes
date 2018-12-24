<?php
/**
 *@package pXP
 *@file    MODMetodoVal.php
 *@author  Ariel Ayaviri Omonte
 *@date    13-02-2013
 */

class MODMetodoVal extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarMetodoVal() {
        $this->procedimiento = 'alm.ft_metodo_val_sel';
        $this->transaccion = 'SAL_MEVAL_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('id_metodo_val', 'integer');
        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_mod', 'varchar');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('read_only', 'boolean');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarMetodoVal() {
        $this->procedimiento = 'alm.ft_metodo_val_ime';
        $this->transaccion = 'SAL_MEVAL_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarMetodoVal() {
        $this->procedimiento = 'alm.ft_metodo_val_ime';
        $this->transaccion = 'SAL_MEVAL_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_metodo_val', 'id_metodo_val', 'integer');
        $this->setParametro('codigo', 'codigo', 'varchar');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');
        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarMetodoVal() {
        $this->procedimiento = 'alm.ft_metodo_val_ime';
        $this->transaccion = 'SAL_MEVAL_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_metodo_val', 'id_metodo_val', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

}
?>