<?php
/**
*@package pXP
*@file gen-MODMovimientoGrupo.php
*@author  (admin)
*@date 18-10-2013 21:26:04
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODMovimientoGrupo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarMovimientoGrupo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_movimiento_grupo_sel';
		$this->transaccion='SAL_MOVGRU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_movimiento_grupo','int4');
		$this->captura('id_int_comprobante','int4');
		$this->captura('descripcion','varchar');
		$this->captura('id_almacen','int4');
		$this->captura('fecha_ini','date');
		$this->captura('estado','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_almacen','text');
		$this->captura('nro_cbte','varchar');
		$this->captura('id_depto_conta','int4');
		$this->captura('nombre_depto','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarMovimientoGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_ime';
		$this->transaccion='SAL_MOVGRU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_int_comprobante','id_int_comprobante','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto_conta','id_depto_conta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarMovimientoGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_ime';
		$this->transaccion='SAL_MOVGRU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_grupo','id_movimiento_grupo','int4');
		$this->setParametro('id_int_comprobante','id_int_comprobante','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('fecha_ini','fecha_ini','date');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_depto_conta','id_depto_conta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarMovimientoGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_ime';
		$this->transaccion='SAL_MOVGRU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_grupo','id_movimiento_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function generarCbte(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_grupo_ime';
		$this->transaccion='SAL_MOVGRU_GEN';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_grupo','id_movimiento_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>