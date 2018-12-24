<?php
/**
*@package pXP
*@file gen-MODPeriodo.php
*@author  (admin)
*@date 19-06-2013 08:33:57
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPeriodo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPeriodo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_periodo_sel';
		$this->transaccion='SAL_ALMPER_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_periodo','int4');
		$this->captura('fecha_fin','date');
		$this->captura('fecha_ini','date');
		$this->captura('estado_reg','varchar');
		$this->captura('periodo','date');
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
			
	function insertarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_periodo_ime';
		$this->transaccion='SAL_ALMPER_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('periodo','periodo','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_periodo_ime';
		$this->transaccion='SAL_ALMPER_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('periodo','periodo','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_periodo_ime';
		$this->transaccion='SAL_ALMPER_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function AbrirCerrarPeriodo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_periodo_ime';
		$this->transaccion='SAL_PEABCE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_periodo','id_periodo','int4');
		$this->setParametro('nuevo_estado','nuevo_estado','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>