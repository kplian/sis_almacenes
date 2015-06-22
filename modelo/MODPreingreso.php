<?php
/**
*@package pXP
*@file gen-MODPreingreso.php
*@author  (admin)
*@date 07-10-2013 16:56:43
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPreingreso extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPreingreso(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_preingreso_sel';
		$this->transaccion='SAL_PREING_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_preingreso','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_cotizacion','int4');
		$this->captura('id_almacen','int4');
		$this->captura('id_depto','int4');
		$this->captura('id_estado_wf','int4');
		$this->captura('id_proceso_wf','int4');
		$this->captura('estado','varchar');
		$this->captura('id_moneda','int4');
		$this->captura('tipo','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('codigo_almacen','varchar');
		$this->captura('codigo_depto','varchar');
		$this->captura('codigo_moneda','varchar');
		$this->captura('numero_oc','varchar');
		$this->captura('nro_tramite','varchar');
		$this->captura('desc_funcionario1','text');
		$this->captura('desc_proveedor','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPreingreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_ime';
		$this->transaccion='SAL_PREING_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_cotizacion','id_cotizacion','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPreingreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_ime';
		$this->transaccion='SAL_PREING_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso','id_preingreso','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_cotizacion','id_cotizacion','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_estado_wf','id_estado_wf','int4');
		$this->setParametro('id_proceso_wf','id_proceso_wf','int4');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('id_moneda','id_moneda','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPreingreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_ime';
		$this->transaccion='SAL_PREING_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso','id_preingreso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function generarIngreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_ime';
		$this->transaccion='SAL_INGRES_GEN';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso','id_preingreso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function revertirPreingreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_ime';
		$this->transaccion='SAL_PREING_REV';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso','id_preingreso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>