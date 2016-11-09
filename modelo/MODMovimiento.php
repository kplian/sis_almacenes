<?php
/**
 *@package pXP
 *@file    MODMovimiento.php
 *@author  Gonzalo Sarmiento
 *@date    02-10-2012
 *@description Clase que envia los parametros requeridos a la Base de datos para
 *             la ejecucion de las funciones, y que recibe la respuesta del
 *             resultado de la ejecucion de las mismas
 */

class MODMovimiento extends MODbase {

    function __construct(CTParametro $pParam) {
        parent::__construct($pParam);
    }

    function listarMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_sel';
        $this->transaccion = 'SAL_MOV_SEL';
        $this->tipo_procedimiento = 'SEL';
								
		$this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
		$this->setParametro('tipo_interfaz','tipo_interfaz','varchar');
        $this->setParametro('historico','historico','varchar');

        $this->captura('id_movimiento', 'integer');
        $this->captura('tipo', 'varchar');
        $this->captura('id_movimiento_tipo', 'integer');
        $this->captura('nombre_movimiento_tipo', 'varchar');
        $this->captura('id_funcionario', 'integer');
        $this->captura('nombre_funcionario', 'varchar');
        $this->captura('id_proveedor', 'integer');
        $this->captura('nombre_proveedor', 'varchar');
        $this->captura('id_almacen', 'integer');
        $this->captura('nombre_almacen', 'varchar');
        $this->captura('id_almacen_dest', 'int4');
        $this->captura('nombre_almacen_destino', 'varchar');
        $this->captura('fecha_mov', 'timestamp');
        $this->captura('codigo', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('observaciones', 'varchar');
        $this->captura('id_movimiento_origen', 'integer');
        $this->captura('codigo_origen', 'varchar');		
		$this->captura('id_proceso_wf','int4');
		$this->captura('id_estado_wf','int4');
        $this->captura('estado_mov', 'varchar');
        $this->captura('usr_reg', 'varchar');
        $this->captura('fecha_reg', 'timestamp');
        $this->captura('usr_mod', 'varchar');
        $this->captura('fecha_mod', 'timestamp');
		$this->captura('id_depto_conta', 'integer');
        $this->captura('nombre_depto', 'varchar');
        $this->captura('comail', 'integer');
        $this->captura('fecha_salida', 'date');

        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function insertarMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOV_INS';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento_tipo', 'id_movimiento_tipo', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('id_funcionario', 'id_funcionario', 'integer');
        $this->setParametro('id_proveedor', 'id_proveedor', 'integer');
        $this->setParametro('id_almacen_dest', 'id_almacen_dest', 'integer');
        $this->setParametro('fecha_mov', 'fecha_mov', 'timestamp');
        $this->setParametro('descripcion', 'descripcion', 'varchar');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('id_movimiento_origen', 'id_movimiento_origen', 'integer');
		$this->setParametro('id_gestion', 'id_gestion', 'integer');
		$this->setParametro('id_depto_conta', 'id_depto_conta', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

	function insertarMovimientoREST(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_ime';
		$this->transaccion='SAL_MOVREST_INS';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_movimiento_tipo', 'id_movimiento_tipo', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('id_funcionario', 'id_funcionario', 'integer');       
        $this->setParametro('fecha_mov', 'fecha_mov', 'date');
        $this->setParametro('descripcion', 'descripcion', 'varchar'); 		
		$this->setParametro('detalle','detalle','text');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}

    function modificarMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');
        $this->setParametro('id_movimiento_tipo', 'id_movimiento_tipo', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('id_funcionario', 'id_funcionario', 'integer');
        $this->setParametro('id_proveedor', 'id_proveedor', 'integer');
        $this->setParametro('id_almacen_dest', 'id_almacen_dest', 'integer');
        $this->setParametro('fecha_mov', 'fecha_mov', 'timestamp');
        $this->setParametro('descripcion', 'descripcion', 'varchar');
        $this->setParametro('observaciones', 'observaciones', 'varchar');
        $this->setParametro('id_movimiento_origen', 'id_movimiento_origen', 'integer');
		$this->setParametro('id_depto_conta', 'id_depto_conta', 'integer');
		$this->setParametro('comail', 'comail', 'integer');
		$this->setParametro('fecha_salida', 'fecha_salida', 'date');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function eliminarMovimiento() {
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOV_ELI';
        $this->tipo_procedimiento = 'IME';

        //Define los parametros para la funcion
        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }

    function finalizarMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOVFIN_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');								
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
        $this->setParametro('operacion', 'operacion', 'varchar');
		$this->setParametro('fecha_mov', 'fecha_mov', 'date');
		$this->setParametro('id_funcionario_wf', 'id_funcionario_wf', 'integer');
		$this->setParametro('id_tipo_estado', 'id_tipo_estado', 'integer');
		$this->setParametro('obs', 'obs', 'varchar');

        $this->armarConsulta();
		//echo $this->consulta;exit;
        $this->ejecutarConsulta();
        return $this->respuesta;
    }

    function cancelarMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOVCNL_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }

    function revertirMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOVREV_MOD';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
		$this->setParametro('obs', 'obs', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }

    function movimientosPendientesPeriodo() {
        $this->procedimiento = 'alm.ft_movimiento_sel';
        $this->transaccion = 'SAL_MOVPENPER_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->setParametro('id_periodo_subsistema', 'id_periodo_subsistema', 'integer');

        $this->captura('id_movimiento', 'integer');
        $this->captura('tipo', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }

    function listarReporteMovimiento() {
        $this->procedimiento = 'alm.ft_movimiento_sel';
        $this->transaccion = 'SAL_MOVREPORT_SEL';
        $this->tipo_procedimiento = 'SEL';

        $this->captura('codigo', 'varchar');
        $this->captura('nombre', 'varchar');
        $this->captura('unidad_medida', 'varchar');
        $this->captura('id_clasificacion', 'integer');
        $this->captura('nombre_clasificacion', 'varchar');
        $this->captura('cantidad', 'numeric');
        $this->captura('costo_unitario', 'numeric');
        $this->captura('costo_total', 'numeric');
		
		$this->captura('codigo_mov', 'varchar');
		$this->captura('comail', 'integer');
		$this->captura('nombre_almacen', 'varchar');
        $this->captura('tipo', 'varchar');
        $this->captura('nombre_movimiento_tipo', 'varchar');
        $this->captura('descripcion', 'varchar');
        $this->captura('observaciones', 'varchar');
        $this->captura('fecha_mov', 'varchar');
        $this->captura('nombre_funcionario', 'text');
        $this->captura('nombre_proveedor', 'varchar');
        $this->captura('fecha_mod', 'varchar');
		$this->captura('cantidad_solicitada', 'numeric');
        $this->captura('fecha_salida', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();

        return $this->respuesta;
    }
				
	function siguienteEstadoMovimiento(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_movimiento_ime';
        $this->transaccion='SAL_SIGEMOV_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_movimiento','id_movimiento','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('operacion','operacion','varchar');
        $this->setParametro('id_funcionario','id_funcionario','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('obs','obs','text');
        $this->setParametro('instruc_rpc','instruc_rpc','varchar');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
    
    function anteriorEstadoSolicitud(){
        //Definicion de variables para ejecucion del procedimiento
        $this->procedimiento='alm.ft_movimiento_ime';
        $this->transaccion='SAL_ANTEMOV_IME';
        $this->tipo_procedimiento='IME';
                
        //Define los parametros para la funcion
        $this->setParametro('id_movimiento','id_movimiento','int4');
        $this->setParametro('id_funcionario_usu','id_funcionario_usu','int4');
        $this->setParametro('operacion','operacion','varchar');
        $this->setParametro('id_funcionario','id_funcionario','int4');
        $this->setParametro('id_tipo_estado','id_tipo_estado','int4');
        $this->setParametro('id_estado_wf','id_estado_wf','int4');
          $this->setParametro('obs','obs','text');

        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();

        //Devuelve la respuesta
        return $this->respuesta;
    }
	
	function listarFuncionarioMovimientoTipo() {
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='alm.ft_movimiento_sel';// nombre procedimiento almacenado
		$this->transaccion='SAL_FUNCIOCAR_SEL';//nombre de la transaccion
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		//ENVIA ESTAS VARIALBES PARA EL FILTRO
		$this->setParametro('estado_reg_fun','estado_reg_fun','varchar');
		$this->setParametro('estado_reg_asi','estado_reg_asi','varchar');
		$this->setParametro('id_movimiento_tipo','id_movimiento_tipo','integer');
		$this->setParametro('fecha','fecha','date');
		
	
		$this->captura('id_uo_funcionario','integer');
		$this->captura('id_funcionario','integer');
		$this->captura('desc_funcionario1','text');
		$this->captura('desc_funcionario2','text');	
		$this->captura('id_uo','integer');
		$this->captura('nombre_cargo','varchar');
		$this->captura('fecha_asignacion','date');
		$this->captura('fecha_finalizacion','date');
		$this->captura('num_doc','integer');
		$this->captura('ci','varchar');
		$this->captura('codigo','varchar');
		$this->captura('email_empresa','varchar');
		$this->captura('estado_reg_fun','varchar');
		$this->captura('estado_reg_asi','varchar');
		//Ejecuta la funcion
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		return $this->respuesta;
	}

	function revertirPreingreso() {
        $this->procedimiento = 'alm.ft_movimiento_ime';
        $this->transaccion = 'SAL_MOVPRE_REV';
        $this->tipo_procedimiento = 'IME';

        $this->setParametro('id_movimiento', 'id_movimiento', 'integer');
        $this->setParametro('id_almacen', 'id_almacen', 'integer');
		$this->setParametro('obs', 'obs', 'varchar');

        $this->armarConsulta();
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
}
?>
