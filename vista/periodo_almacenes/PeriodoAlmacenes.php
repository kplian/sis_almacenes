<?php
/**
 *@package pXP
 *@file gen-SistemaDist.php
 *@author  (Ariel ayaviri Omonte)
 *@date 20-09-2011 10:22:05
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.PeriodoAlmacenes = {
		require : '../../../sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php',
		requireclase : 'Phx.vista.PeriodoSubsistema',
		title : 'Periodo Almacenes',
		codigoSubsistema : 'ALM',
		constructor : function(config) {
			Phx.vista.PeriodoAlmacenes.superclass.constructor.call(this, config);
			this.init();
		},
		switchEstadoPeriodo : function() {
		    var rec = this.sm.getSelected();
            var data = rec.data;
            global = this;
		    Ext.Ajax.request({
                url : '../../sis_almacenes/control/Movimiento/movimientosPendientesPeriodo',
                params : {
                    id_periodo_subsistema : data.id_periodo_subsistema
                },
                success : global.successValidation,
                failure : global.conexionFailure,
                timeout : global.timeout,
                scope : global
            });
		},
		successValidation : function(resp, b, c, d){
		    var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
		    if (parseInt(reg.total)>0) {
		        Ext.Msg.alert('Error','No se puede cerrar el periodo seleccionado debido a que existen movimientos pendientes.');
		    } else {
		        Phx.vista.PeriodoAlmacenes.superclass.switchEstadoPeriodo.call(this);
		    }
		}
	}; 
</script>
