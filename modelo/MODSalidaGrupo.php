<?php
/**
*@package pXP
*@file gen-MODSalidaGrupo.php
*@author  (admin)
*@date 17-10-2013 18:50:00
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODSalidaGrupo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_salida_grupo_sel';
		$this->transaccion='SAL_SALGRU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_salida_grupo','int4');
		$this->captura('id_movimiento_tipo','int4');
		$this->captura('id_almacen','int4');
		$this->captura('descripcion','varchar');
		$this->captura('fecha','date');
		$this->captura('observaciones','varchar');
		$this->captura('estado','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_almacen','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_ime';
		$this->transaccion='SAL_SALGRU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_ime';
		$this->transaccion='SAL_SALGRU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','int4');
		$this->setParametro('id_almacen','id_almacen','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('fecha','fecha','date');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado','estado','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_ime';
		$this->transaccion='SAL_SALGRU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

	function finalizarSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_ime';
		$this->transaccion='SAL_SALGRU_FIN';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
	function retrocederSalidaGrupo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_ime';
		$this->transaccion='SAL_SALGRU_RET';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>