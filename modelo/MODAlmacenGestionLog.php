<?php
/**
*@package pXP
*@file gen-MODAlmacenGestionLog.php
*@author  (admin)
*@date 31-12-2013 14:16:08
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAlmacenGestionLog extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAlmacenGestionLog(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_almacen_gestion_log_sel';
		$this->transaccion='SAL_AGLOG_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_almacen_gestion_log','int4');
		$this->captura('id_almacen_gestion','int4');
		$this->captura('estado','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
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
			
	function insertarAlmacenGestionLog(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_almacen_gestion_log_ime';
		$this->transaccion='SAL_AGLOG_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_almacen_gestion','id_almacen_gestion','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAlmacenGestionLog(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_almacen_gestion_log_ime';
		$this->transaccion='SAL_AGLOG_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_almacen_gestion_log','id_almacen_gestion_log','int4');
		$this->setParametro('id_almacen_gestion','id_almacen_gestion','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAlmacenGestionLog(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_almacen_gestion_log_ime';
		$this->transaccion='SAL_AGLOG_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_almacen_gestion_log','id_almacen_gestion_log','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>