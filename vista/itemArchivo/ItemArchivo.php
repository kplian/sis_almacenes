<?php
/**
 *@package       pXP
 *@file          UniConsArchivo.php
 *@author        Ariel Ayaviri Omonte
 *@date          06-02-2013
 *@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.ItemArchivo = Ext.extend(Phx.gridInterfaz, {

		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.ItemArchivo.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50,
					id_item : this.id_item
				}
			});
			this.addButton('btnUpload', {
				text : 'Subir archivo',
				iconCls : 'bupload1',
				disabled : true,
				handler : onBtnUpload,
				tooltip : '<b>Upload</b><br/>Subir Archivo'
			});

			function onBtnUpload() {
				var rec = this.sm.getSelected();
				Phx.CP.loadWindows('../../../sis_almacenes/vista/itemArchivo/SubirArchivo.php', 'Subir Archivo', {
					modal : true,
					width : 450,
					height : 150
				}, rec.data, this.idContenedor, 'SubirArchivo')
			}


			this.Atributos[1].valorInicial = this.id_item;
		},

		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item_archivo'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 30
			},
			type : 'TextField',
			filters : {
				pfiltro : 'itmarch.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'descripcion',
				fieldLabel : 'Descripción',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'itmarch.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'extension',
				fieldLabel : 'Extensión',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 30
			},
			type : 'TextField',
			filters : {
				pfiltro : 'itmarch.extension',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				fieldLabel : "Archivo",
				gwidth : 130,
				inputType : 'file',
				name : 'archivo',
				buttonText : '',
				maxLength : 150,
				anchor : '100%',
				renderer : function(value, p, record) {
					if (record.data['extension'].length != 0)
						return String.format('{0}', "<div style='text-align:center'><a href = '../../../sis_almacenes/archivos/item/" + record.data['archivo'] + "' align='center' width='70' height='70'>documento</a></div>");
				},
				buttonCfg : {
					iconCls : 'upload-icon'
				}
			},
			type : 'Field',
			sortable : false,
			id_grupo : 0,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd-m-Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'itmarch.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 109,
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
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				format : 'd-m-Y',
				gwidth : 109,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'itmarch.fecha_mod',
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
		}],
		title : 'Archivos del Item',
		ActSave : '../../sis_almacenes/control/ItemArchivo/insertarItemArchivo',
		ActDel : '../../sis_almacenes/control/ItemArchivo/eliminarItemArchivo',
		ActList : '../../sis_almacenes/control/ItemArchivo/listarItemArchivo',
		id_store : 'id_item_archivo',
		fields : [{
			name : 'id_item_archivo',
			type : 'numeric'
		}, {
			name : 'id_item',
			type : 'numeric'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'extension',
			type : 'string'
		}, {
			name : 'archivo',
			type : 'string'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'usr_mod',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_item_archivo',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidht : 450,
		fheight : 250,
		preparaMenu : function(tb) {
			Phx.vista.ItemArchivo.superclass.preparaMenu.call(this, tb)
			this.getBoton('btnUpload').enable();
		},
		liberaMenu : function(tb) {
			Phx.vista.ItemArchivo.superclass.liberaMenu.call(this, tb)
			this.getBoton('btnUpload').disable();
		}
	})
</script>

