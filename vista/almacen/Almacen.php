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

			this.addButton('btnSwitchEstado', {
				text : 'Inactivar',
				iconCls : 'btag_deny',
				disabled : true,
				handler : this.onBtnSwitchEstado,
				tooltip : '<b>Activar o Inactivar Almacen</b>'
			});
			
			this.addButton('btnGestion', {
				text : 'Gestiones',
				iconCls : 'bassign',
				disabled : true,
				handler : this.onBtnGestion,
				tooltip : '<b>Administración de Gestiones por almacén</b>'
			});
		},
		onBtnAlmacenUsuario : function() {
			var rec = this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php', 'Personal del Almacén', {
				modal : true,
				width : 800,
				height : 400,
			}, rec.data, this.idContenedor, 'AlmacenUsuario');
		},
		onBtnSwitchEstado : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de activar/inactivar este almacén?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Almacen/switchEstadoAlmacen',
						params : {
							'id_almacen' : data.id_almacen
						},
						success : global.successSave,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
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
				name : 'estado',
				fieldLabel : 'Estado',
				allowBlank : false,
				anchor : '100%',
				gwidth : 70,
				maxLength : 10,
				renderer : function(value, e) {
					var result;
					if (value == "activo") {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_tag_accept.png' align='center' width='18' height='18' title='Activo'/></div>";
					} else if (value == 'inactivo') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/icono_dibu/dibu_tag_deny.png' align='center' width='18' height='18' title='Inactivo'/></div>";
					}
					return result;
				}
			},
			type : 'TextField',
			filters : {
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Codigo',
				allowBlank : false,
				anchor : '100%',
				gwidth : 70,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
			    pfiltro : 'alm.codigo',
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
			    pfiltro : 'alm.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'localizacion',
				fieldLabel : 'Localizacion',
				allowBlank : true,
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
				name : 'id_departamento',
				fieldLabel : 'Departamento',
				allowBlank : false,
				emptyText : 'Departamento...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Depto/listarDepto',
					id : 'id_depto',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_depto', 'nombre', 'codigo'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'DEPPTO.nombre#DEPPTO.codigo'
					}
				}),
				valueField : 'id_depto',
				displayField : 'nombre',
				gdisplayField : 'nombre_depto',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				hiddenName : 'id_departamento',
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 100,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_depto']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'dpto.nombre',
				type : 'string'
			},
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
				pfiltro : 'alm.fecha_reg',
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
				pfiltro : 'alm.fecha_mod',
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
		}, {
			name : 'estado',
			type : 'string'
		}, {
			name : 'id_departamento'
		}, {
			name : 'nombre_depto',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_almacen',
			direction : 'ASC'
		},
		bdel : true,
		fwidth : 420,
		fheight : 250,
		tabsouth:[{
			url : '../../../sis_almacenes/vista/almacenStock/AlmacenStock.php',
			title : 'Stock Minimo de almacenes',
			height: '50%',
			cls : 'AlmacenStock'
		}, {
			url : '../../../sis_parametros/vista/tabla_upload/TablaUpload.php',
			title : 'Upload archivos',
			height: '50%',
			cls : 'TablaUpload',
			params:{nombre_tabla:'alm.talmacen',tabla_id : 'id_almacen'}
		}],
		preparaMenu : function(tb) {
			Phx.vista.Almacen.superclass.preparaMenu.call(this, tb);
			this.getBoton('btnAlmacenUsuario').enable();
			var btnSwitchEstado = this.getBoton('btnSwitchEstado');
			var rec = this.sm.getSelected();
			var data = rec.data;
			if (data.estado == 'inactivo') {
				btnSwitchEstado.setIconClass('btag_accept');
				btnSwitchEstado.setText('Activar');
			} else {
				btnSwitchEstado.setIconClass('btag_deny');
				btnSwitchEstado.setText('Inactivar');
			}
			btnSwitchEstado.enable();
			//Habilita boton  de gestiones
			this.getBoton('btnGestion').enable();
		},
		liberaMenu : function() {
			Phx.vista.Almacen.superclass.liberaMenu.call(this);
			this.getBoton('btnAlmacenUsuario').disable();
			this.getBoton('btnSwitchEstado').disable();
			this.getBoton('btnGestion').disable();
		},
		onBtnGestion: function() {
			var rec = this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_almacenes/vista/almacen_gestion/AlmacenGestion.php', 'Gestión Almacenes', {
				modal : true,
				width : '70%',
				height : '90%',
			}, rec.data, this.idContenedor, 'AlmacenGestion');
		},
}); 
</script>
