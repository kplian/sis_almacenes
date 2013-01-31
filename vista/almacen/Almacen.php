<?php
/**
 * @package pxP
 * @file 	Almacen.php
 * @author 	Gonzalo Sarmiento
 * @date	21-09-2012
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Almacen = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.Almacen.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			});
			this.addButton('btnAlmacenUsuario', {
				text : 'Almaceneros',
				iconCls : 'bassign',
				disabled : true,
				handler : this.onBtnAlmacenUsuario,
				tooltip : '<b>Personal del Almacén</b>'
			});
		},
		onBtnAlmacenUsuario : function() {
			Phx.CP.loadWindows('../../../sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php', 'Personal del Almacén', {
				modal : true,
				width : 600,
				height : 300
			}, '', this.idContenedor, 'AlmacenUsuario');
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_almacen'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Codigo',
				allowBlank : false,
				anchor : '100%',
				gwidth : 70,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre almacen',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 50
			},
			type : 'TextField',
			filters : {
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'localizacion',
				fieldLabel : 'Localizacion',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 50
			},
			type : 'TextField',
			filters : {
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
				pfiltro : 'cencos.fecha_reg',
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
				pfiltro : 'cencos.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Almacen',
		ActSave : '../../sis_almacenes/control/Almacen/insertarAlmacen',
		ActDel : '../../sis_almacenes/control/Almacen/eliminarAlmacen',
		ActList : '../../sis_almacenes/control/Almacen/listarAlmacen',
		id_store : 'id_almacen',
		fields : [{
			name : 'id_almacen'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'localizacion',
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
		}],
		sortInfo : {
			field : 'id_almacen',
			direction : 'ASC'
		},
		bdel : true,
		fwidth : 420,
		fheight : 230,
		east : {
			url : '../../../sis_almacenes/vista/almacenStock/AlmacenStock.php',
			title : 'Stock Minimo de almacenes',
			width : 400,
			cls : 'AlmacenStock'
		},
		preparaMenu : function(tb) {
			Phx.vista.Almacen.superclass.preparaMenu.call(this, tb);
			this.getBoton('btnAlmacenUsuario').enable();
		},
		liberaMenu : function() {
			Phx.vista.Almacen.superclass.liberaMenu.call(this);
			this.getBoton('btnAlmacenUsuario').disable();
		}
	}); 
</script>
