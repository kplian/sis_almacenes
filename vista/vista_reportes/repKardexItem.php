<?php
/**
 * @package pxP
 * @file 	repkardex.php
 * @author 	RCM
 * @date	10/07/2013
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.repKardexItem = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config;
			Phx.vista.repKardexItem.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start: 0,
					limit: 1000,
					fecha_ini:this.maestro.fecha_ini,
					fecha_fin:this.maestro.fecha_fin,
					id_item:this.maestro.id_item,
					all_alm:this.maestro.all_alm,
					id_almacen:this.maestro.id_almacen
				}
			});
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id'
			},
			type : 'Field',
			form : true
		}, 
		{
			config : {
				name : 'fecha',
				fieldLabel : 'Fecha',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'Field',
			filters : {
			    pfiltro : 'fecha',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'nro_mov',
				fieldLabel : 'Num.Movimiento',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'nro_mov',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'almacen',
				fieldLabel : 'Almacén',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'almacen',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'ingreso',
				fieldLabel : 'Cantidad Ingreso',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'ingreso',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'salida',
				fieldLabel : 'Cantidad salida',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'salida',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'saldo',
				fieldLabel : 'Saldo Físico',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'saldo',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'costo_unitario',
				fieldLabel : 'Costo Unitario',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'costo_unitario',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'ingreso_val',
				fieldLabel : 'Valorado Ingreso',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'ingreso_val',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'salida_val',
				fieldLabel : 'Valorado Salida',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'salida_val',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'saldo_val',
				fieldLabel : 'Saldo Valorado',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'saldo_val',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}
		],
		title : 'Kardex Item',
		ActList : '../../sis_almacenes/control/Reportes/listarKardexItem',
		id_store : 'id',
		fields : [{
			name : 'id'
		}, {
			name : 'fecha',
			type : 'date'
		}, {
			name : 'nro_mov',
			type : 'string'
		}, {
			name : 'almacen',
			type : 'string'
		}, {
			name : 'ingreso',
			type : 'numeric'
		}, {
			name : 'salida',
			type : 'numeric'
		}, {
			name : 'saldo',
			type : 'numeric'
		}, {
			name : 'costo_unitario',
			type : 'numeric'
		}, {
			name : 'ingreso_val',
			type : 'numeric'
		}, {
			name : 'salida_val',
			type : 'numeric'
		}, {
			name : 'saldo_val',
			type : 'numeric'
		}],
		sortInfo : {
			field : 'id',
			direction : 'ASC'
		},
		bdel : false,
		bnew: false,
		bedit: false,
		fwidth : '90%',
		fheight : '80%'
	}); 
</script>
