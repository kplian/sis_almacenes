<?php
/**
 *@package       pXP
 *@file          gen-MODUniConsArchivo.php
 *@author        Ariel Ayaviri Omonte
 *@date          06-02-2013
 *@description   Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
 */

class MODItemArchivo extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarItemArchivo() {
        $this->procedimiento = 'alm.ft_item_archivo_sel';
        $this->transaccion = 'SAL_ITMARCH_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_item', 'id_item', 'int4');

        $_SESSION["ARCHIVO"] = array();

        $this->captura('id_item_archivo', 'int4');
        $this->captura('id_item', 'int4');
        $this->captura('nombre', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('extension', 'varchar');
        $this->captura('archivo', 'bytea', 'id_item_archivo', 'extension', 'archivo', '../../../sis_almacenes/archivos/item/');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_mod', 'timestamp');
        $this->captura('usr_mod', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarItemArchivo() {
        $this->procedimiento = 'alm.ft_item_archivo_ime';
        $this->transaccion = 'SAL_ITMARCH_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item', 'id_item', 'int4');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function modificarItemArchivo() {
        $this->procedimiento = 'alm.ft_item_archivo_ime';
        $this->transaccion = 'SAL_ITMARCH_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item_archivo', 'id_item_archivo', 'int4');
        $this->setParametro('id_item', 'id_item', 'int4');
        $this->setParametro('nombre', 'nombre', 'varchar');
        $this->setParametro('descripcion', 'descripcion', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarItemArchivo() {
        $this->procedimiento = 'alm.ft_item_archivo_ime';
        $this->transaccion = 'SAL_ITMARCH_ELI';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_item_archivo', 'id_item_archivo', 'int4');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function subirItemArchivo() {
        $this->procedimiento = 'alm.ft_item_archivo_ime';
        $this->transaccion = 'SAL_UPARCH_MOD';
        $this->tipo_procedimiento = 'IME';

        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension'] = $ext['extension'];

        $this->setParametro('id_item_archivo', 'id_item_archivo', 'integer');
        $this->setParametro('extension', 'extension', 'varchar');
        $this->setParametro('archivo', 'archivo', 'bytea', false, '', false, array('doc', 'pdf', 'docx', 'jpg', 'png', 'bmp', 'xls', 'xlsx'));

        $this->armarConsulta();

        $this->ejecutarConsulta();
        return $this->respuesta;
    }

}
?>