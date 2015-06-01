<?php
/**
*@package pXP
*@file gen-MODPreingresoDet.php
*@author  (admin)
*@date 07-10-2013 17:46:04
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODPreingresoDet extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarPreingresoDet(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_preingreso_det_sel';
		$this->transaccion='SAL_PREDET_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
									
		//Definicion de la lista del resultado del query
		$this->captura('id_preingreso_det','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_preingreso','int4');
		$this->captura('id_cotizacion_det','int4');
		$this->captura('id_item','int4');
		$this->captura('id_almacen','int4');
		$this->captura('cantidad_det','numeric');
		$this->captura('precio_compra','numeric');
		$this->captura('id_depto','int4');
		$this->captura('id_clasificacion','int4');
		$this->captura('sw_generar','varchar');
		$this->captura('observaciones','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('desc_almacen','text');
		$this->captura('desc_depto','text');
		$this->captura('desc_item','text');
		$this->captura('desc_clasificacion','text');
		$this->captura('desc_ingas','varchar');
		$this->captura('descripcion','text');
		$this->captura('estado','varchar');
		$this->captura('tipo','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarPreingresoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREDET_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_preingreso','id_preingreso','int4');
		$this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('cantidad_det','cantidad_det','numeric');
		$this->setParametro('precio_compra','precio_compra','numeric');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_clasificacion','id_clasificacion','int4');
		$this->setParametro('sw_generar','sw_generar','varchar');
		$this->setParametro('observaciones','observaciones','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarPreingresoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREDET_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso_det','id_preingreso_det','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_preingreso','id_preingreso','int4');
		$this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('cantidad_det','cantidad_det','numeric');
		$this->setParametro('precio_compra','precio_compra','numeric');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_clasificacion','id_clasificacion','int4');
		$this->setParametro('sw_generar','sw_generar','varchar');
		$this->setParametro('observaciones','observaciones','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarPreingresoDet(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREDET_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso_det','id_preingreso_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function preparaPreingreso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREPPRE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso_det','id_preingreso_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function insertarPreingresoDetPreparacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREPPRE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_preingreso','id_preingreso','int4');
		$this->setParametro('id_cotizacion_det','id_cotizacion_det','int4');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('cantidad_det','cantidad_det','numeric');
		$this->setParametro('precio_compra','precio_compra','numeric');
		$this->setParametro('id_depto','id_depto','int4');
		$this->setParametro('id_clasificacion','id_clasificacion','int4');
		$this->setParametro('sw_generar','sw_generar','varchar');
		$this->setParametro('observaciones','observaciones','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function eliminarPreingresoDetPreparacion(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREDETPRE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_preingreso_det','id_preingreso_det','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function preparaPreingresoAll(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_PREPPREALL_MOD';
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
	
	function quitaPreingresoAll(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_preingreso_det_ime';
		$this->transaccion='SAL_QUITAPREALL_MOD';
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