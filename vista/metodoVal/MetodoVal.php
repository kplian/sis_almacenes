<?php
/**
 * @package pxP
 * @file 	MetodoVal.php
 * @author 	Ariel Ayaviri Omonte
 * @date	14-02-2013
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.MetodoVal = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.MetodoVal.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			});
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_metodo_val'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				anchor : '100%',
				gwidth : 70,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'meval.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 50
			},
			type : 'TextField',
			filters : {
				pfiltro : 'meval.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'descripcion',
				fieldLabel : 'Descripcion',
				allowBlank : true,
				anchor : '100%',
				gwidth : 150,
				maxLength : 150
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'meval.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'meval.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Modificado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu2.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'meval.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Tipo Movimiento',
		ActSave : '../../sis_almacenes/control/MetodoVal/insertarMetodoVal',
		ActDel : '../../sis_almacenes/control/MetodoVal/eliminarMetodoVal',
		ActList : '../../sis_almacenes/control/MetodoVal/listarMetodoVal',
		id_store : 'id_metodo_val',
		fields : [{
			name : 'id_metodo_val'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		}, {
			name : 'read_only',
			type : 'boolean'
		}],
		sortInfo : {
			field : 'id_metodo_val',
			direction : 'ASC'
		},
		bdel : true,
		fwidth : 420,
		fheight : 260,
		preparaMenu : function(n) {
			var tb = Phx.vista.MetodoVal.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.read_only == true) {
				this.getBoton('edit').setDisabled(true);
				this.getBoton('del').setDisabled(true);
			}
			return tb;
		}
	}); 
</script>
