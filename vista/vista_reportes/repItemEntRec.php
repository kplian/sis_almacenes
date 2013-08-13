<?php
/**
 * @package pxP
 * @file 	repItemEntRec.php
 * @author 	RCM
 * @date	13/08/2013
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.repItemEntRec = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config;
			Phx.vista.repItemEntRec.superclass.constructor.call(this, config);
			this.init();
			this.store.baseParams={
					fecha_hasta:this.maestro.fecha_hasta,
					tipo_mov:this.maestro.tipo_mov,
					tipo_sol:this.maestro.tipo_sol,
					id_funcionario:this.maestro.id_funcionario,
					id_proveedor:this.maestro.id_proveedor,
					all_alm:this.maestro.all_alm,
					id_items:this.maestro.id_items,
					id_clasificacion:this.maestro.id_clasificacion,
					all_items:this.maestro.all_items,
					id_almacen:this.maestro.id_almacen
			};
			this.load({
				params : {
					start: 0,
					limit: this.tam_pag,
				}
			});
		},
		tam_pag:50,
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_movimiento_det_valorado'
			},
			type : 'Field',
			form : true
		}, 
		{
			config : {
				name : 'fecha_mov',
				fieldLabel : 'Fecha',
				allowBlank : false,
				anchor : '100%',
				gwidth : 90,
				maxLength : 20,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mov.fecha_mov',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				anchor : '100%',
				gwidth : 180,
				maxLength : 20				
			},
			type : 'Field',
			filters : {
			    pfiltro : 'item.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'nombre',
				fieldLabel : 'Item',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'item.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'cantidad',
				fieldLabel : 'Cantidad',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mval.cantidad',
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
				gwidth : 150
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mval.costo_unitario',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'costo_total',
				fieldLabel : 'Costo total',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'desc_funcionario1',
				fieldLabel : 'Funcionario',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'fun.desc_funcionario1',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'desc_proveedor',
				fieldLabel : 'Proveedor',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'prov.desc_proveedor',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'mov_codigo',
				fieldLabel : 'Código Movimiento',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mov.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'tipo_nombre',
				fieldLabel : 'Tipo Movimiento',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mtipo.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'tipo',
				fieldLabel : 'Tipo',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'mtipo.tipo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'desc_almacen',
				fieldLabel : 'Almacén',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'Field',
			filters : {
			    pfiltro : 'alm.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}
		],
		title : 'Material Entregado/Recibido',
		ActList : '../../sis_almacenes/control/Reportes/listarItemEntRec',
		id_store : 'id_movimiento_det_valorado',
		fields : [{
			name : 'id_movimiento_det_valorado'
		}, {
			name : 'fecha_mov',
			type : 'date'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'cantidad',
			type : 'numeric'
		}, {
			name : 'costo_unitario',
			type : 'numeric'
		}, {
			name : 'costo_total',
			type : 'numeric'
		}, {
			name : 'desc_funcionario1',
			type : 'string'
		}, {
			name : 'desc_proveedor',
			type : 'string'
		}, {
			name : 'mov_codigo',
			type : 'string'
		}, {
			name : 'tipo_nombre',
			type : 'string'
		},{
			name:'tipo',
			type:'string'
		},
		{
			name:'desc_almacen',
			type:'string'
		}],
		sortInfo : {
			field : 'fecha_mov',
			direction : 'ASC'
		},
		bdel : false,
		bnew: false,
		bedit: false,
		fwidth : '90%',
		fheight : '80%'
	}); 
</script>
