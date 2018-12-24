<?php
/**
*@package pXP
*@file gen-MODMovimientoTipoItem.php
*@author  (admin)
*@date 21-08-2013 14:31:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimientoTipoItem extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimientoTipoItem(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_movimiento_tipo_item_sel';
		$this->transaccion='SAL_TIMITE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento_tipo_item','int4');
		$this->captura('id_item','int4');
		$this->captura('id_movimiento_tipo','int4');
		$this->captura('id_clasificacion','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo_item','varchar');
		$this->captura('desc_item','varchar');
		$this->captura('codigo_clasif','varchar');
		$this->captura('desc_clasif','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimientoTipoItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_item_ime';
		$this->transaccion='SAL_TIMITE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_items','id_items','varchar');
		$this->setParametro('id_clasificaciones','id_clasificaciones','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimientoTipoItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_item_ime';
		$this->transaccion='SAL_TIMITE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo_item','id_movimiento_tipo_item','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>