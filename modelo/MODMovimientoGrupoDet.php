<?php
/**
*@package pXP
*@file gen-MODMovimientoGrupoDet.php
*@author  (admin)
*@date 18-10-2013 21:26:09
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimientoGrupoDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimientoGrupoDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_movimiento_grupo_det_sel';
		$this->transaccion='SAL_MOGRDE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento_grupo_det','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_movimiento','int4');
		$this->captura('id_movimiento_grupo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nro_mov','varchar');
		$this->captura('fecha_mov','timestamp');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimientoGrupoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_det_ime';
		$this->transaccion='SAL_MOGRDE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_movimiento','id_movimiento','int4');
		$this->setParametro('id_movimiento_grupo','id_movimiento_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMovimientoGrupoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_det_ime';
		$this->transaccion='SAL_MOGRDE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_grupo_det','id_movimiento_grupo_det','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_movimiento','id_movimiento','int4');
		$this->setParametro('id_movimiento_grupo','id_movimiento_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimientoGrupoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_det_ime';
		$this->transaccion='SAL_MOGRDE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_grupo_det','id_movimiento_grupo_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>