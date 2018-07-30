<?php
/**
*@package pXP
*@file gen-MODMovimientoTipoAlmacen.php
*@author  (admin)
*@date 13-07-2016 19:37:32
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimientoTipoAlmacen extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimientoTipoAlmacen(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_movimiento_tipo_almacen_sel';
		$this->transaccion='SAL_TPMOVALM_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento_tipo_almacen','int4');
		$this->captura('id_movimiento_tipo','int4');
		$this->captura('id_almacen','int4');
		$this->captura('nombre','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimientoTipoAlmacen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_almacen_ime';
		$this->transaccion='SAL_TPMOVALM_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMovimientoTipoAlmacen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_almacen_ime';
		$this->transaccion='SAL_TPMOVALM_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo_almacen','id_movimiento_tipo_almacen','int4');
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimientoTipoAlmacen(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_almacen_ime';
		$this->transaccion='SAL_TPMOVALM_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo_almacen','id_movimiento_tipo_almacen','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>