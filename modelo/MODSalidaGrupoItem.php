<?php
/**
*@package pXP
*@file gen-MODSalidaGrupoItem.php
*@author  (admin)
*@date 17-10-2013 20:34:52
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODSalidaGrupoItem extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarSalidaGrupoItem(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='alm.ft_salida_grupo_item_sel';
		$this->transaccion='SAL_SAGRIT_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_salida_grupo_item','int4');
		$this->captura('observaciones','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_item','int4');
		$this->captura('cantidad_sol','numeric');
		$this->captura('id_salida_grupo','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_item','text');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarSalidaGrupoItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_item_ime';
		$this->transaccion='SAL_SAGRIT_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('cantidad_sol','cantidad_sol','numeric');
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarSalidaGrupoItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_item_ime';
		$this->transaccion='SAL_SAGRIT_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo_item','id_salida_grupo_item','int4');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('id_item','id_item','int4');
		$this->setParametro('cantidad_sol','cantidad_sol','numeric');
		$this->setParametro('id_salida_grupo','id_salida_grupo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarSalidaGrupoItem(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_salida_grupo_item_ime';
		$this->transaccion='SAL_SAGRIT_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_salida_grupo_item','id_salida_grupo_item','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>