<?php
/**
 * @Package pxP
 * @file    ACTClasificacion.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */

class ACTClasificacion extends ACTbase {

    function listarClasificacion() {
        $this->objParam->defecto('ordenacion', 'codigo');

        $this->objParam->defecto('dir_ordenacion', 'asc');
        $this->objFunc = $this->create('MODClasificacion');
        $this->res = $this->objFunc->listarClasificacion();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function listarClasificacionArb() {
        $node = $this->objParam->getParametro('node');
        $id_clasificacion = $this->objParam->getParametro('id_clasificacion');

        if ($node == 'id') {
            $this->objParam->addParametro('id_padre', '%');
        } else {
            $this->objParam->addParametro('id_padre', $id_clasificacion);
        }

        $this->objFunc = $this->create('MODClasificacion');
        $this->res = $this->objFunc->listarClasificacionArb();

        $this->res->setTipoRespuestaArbol();

        $arreglo = array();

        array_push($arreglo, array('nombre' => 'id', 'valor' => 'id_clasificacion'));
        array_push($arreglo, array('nombre' => 'id_p', 'valor' => 'id_clasificacion_fk'));

        array_push($arreglo, array('nombre' => 'text', 'valores' => '[#codigo_largo#]-#nombre#'));
        array_push($arreglo, array('nombre' => 'cls', 'valor' => 'descripcion'));
        array_push($arreglo, array('nombre' => 'qtip', 'valores' => '<b>#codigo_largo#</b><br/>#nombre#'));

        /*Estas funciones definen reglas para los nodos en funcion a los tipo de nodos que contenga cada uno*/

        $this->res->addNivelArbol('tipo_nodo', 'raiz', array('leaf' => false, 'draggable' => true, 'allowDelete' => true, 'allowEdit' => true, 'cls' => 'folder', 'tipo_nodo' => 'raiz', 'icon' => '../../../lib/imagenes/a_form_edit.png'), $arreglo);
        $this->res->addNivelArbol('tipo_nodo', 'hijo', array('leaf' => false, 'draggable' => true, 'allowDelete' => true, 'allowEdit' => true, 'tipo_nodo' => 'hijo', 'icon' => '../../../lib/imagenes/a_form_edit.png'), $arreglo);
        $this->res->addNivelArbol('tipo_nodo', 'raiz_bloqueado', array('leaf' => false, 'draggable' => false, 'allowDelete' => false, 'allowEdit' => true, 'cls' => 'folder', 'tipo_nodo' => 'raiz', 'icon' => '../../../lib/imagenes/a_form.png'), $arreglo);
        $this->res->addNivelArbol('tipo_nodo', 'hijo_bloqueado', array('leaf' => false, 'draggable' => false, 'allowDelete' => false, 'allowEdit' => true, 'cls' => 'folder', 'tipo_nodo' => 'hijo', 'icon' => '../../../lib/imagenes/a_form.png'), $arreglo);

        $arreglo = array();

        array_push($arreglo, array('nombre' => 'id', 'valor' => 'id_clasificacion'));
        array_push($arreglo, array('nombre' => 'id_p', 'valor' => 'id_clasificacion_fk'));

        array_push($arreglo, array('nombre' => 'text', 'valores' => '[#codigo#]-#nombre#'));
        array_push($arreglo, array('nombre' => 'cls', 'valor' => 'nombre'));
        array_push($arreglo, array('nombre' => 'qtip', 'valores' => '<b>#codigo#</b><br/>#nombre#'));
        $this->res->addNivelArbol('tipo_nodo', 'item_codificado', array('leaf' => true, 'draggable' => false, 'allowDelete' => false, 'allowEdit' => false, 'cls' => 'folder', 'tipo_nodo' => 'item', 'icon' => '../../../lib/imagenes/gear.png'), $arreglo);        $this->res->addNivelArbol('tipo_nodo', 'item', array('leaf' => true, 'draggable' => true, 'allowDelete' => false, 'allowEdit' => false, 'cls' => 'folder', 'tipo_nodo' => 'item', 'icon' => '../../../lib/imagenes/gear.png'), $arreglo);
        //Se imprime el arbol en formato JSON
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function insertarClasificacion() {
        $this->objFunc = $this->create('MODClasificacion');
        if ($this->objParam->insertar('id_clasificacion')) {
            $this->res = $this->objFunc->insertarClasificacion();
        } else {
            $this->res = $this->objFunc->modificarClasificacion();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function eliminarClasificacion() {
        $this->objFunc = $this->create('MODClasificacion');
        $this->res = $this->objFunc->eliminarClasificacion();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function cambiarEstadoClasificacion() {
        $this->objFunc = $this->create('MODClasificacion');
        $this->res = $this->objFunc->cambiarEstadoClasificacion();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

    function guardarDragDrop() {
        $this->objFunSeguridad = $this->create('MODClasificacion');
        $this->res = $this->objFunSeguridad->guardarDragDrop($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }

}
?>
