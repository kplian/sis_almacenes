<?php
/**
*@package pXP
*@file gen-MODMovimientoTipoUo.php
*@author  (admin)
*@date 22-08-2013 22:55:37
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimientoTipoUo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimientoTipoUo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_movimiento_tipo_uo_sel';
		$this->transaccion='SAL_TIMVUO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento_tipo_uo','int4');
		$this->captura('id_movimiento_tipo','int4');
		$this->captura('id_uo','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('codigo','varchar');
		$this->captura('desc_uo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimientoTipoUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_uo_ime';
		$this->transaccion='SAL_TIMVUO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_uo','id_uo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

			
	function eliminarMovimientoTipoUo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_tipo_uo_ime';
		$this->transaccion='SAL_TIMVUO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo_uo','id_movimiento_tipo_uo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>