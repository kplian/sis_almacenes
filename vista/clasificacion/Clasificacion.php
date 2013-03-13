<?php
/**
 * @package pxP
 * @file    Clasificacion.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Clasificacion = Ext.extend(Phx.arbInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.Clasificacion.superclass.constructor.call(this, config);
			this.init();

			this.tbar.items.get('b-new-' + this.idContenedor).disable();

			this.addButton('btnBlockUnblock', {
				text : '',
				iconCls : 'block',
				disabled : true,
				handler : this.onBtnBlockUnblock,
				tooltip : '<b>Bloquear</b><br/>Bloquea la clasificacion actual para que no pueda ser modificada.'
			});
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_clasificacion'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_clasificacion_fk'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Codigo',
				allowBlank : false,
				anchor : '100%',
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'cla.codigo',
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
				gwidth : 100,
				maxLength : 100
			},
			type : 'TextField',
			filters : {
				pfiltro : 'cla.nombre',
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
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'cla.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}],
		title : 'Clasificacion',
		ActSave : '../../sis_almacenes/control/Clasificacion/insertarClasificacion',
		ActDel : '../../sis_almacenes/control/Clasificacion/eliminarClasificacion',
		ActList : '../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
		ActDragDrop:'../../sis_almacenes/control/Clasificacion/guardarDragDrop',
		id_store : 'id_clasificacion',
		textRoot : 'Clasificaciones',
		id_nodo : 'id_clasificacion',
		id_nodo_p : 'id_clasificacion_fk',
		idNodoDD : 'id_clasificacion',
		idOldParentDD : 'id_clasificacion_fk',
		idTargetDD : 'id_clasificacion',
		enableDD : true,
		onButtonNew : function() {
			Phx.vista.Clasificacion.superclass.onButtonNew.call(this);
			this.getComponente('codigo').enable();
			this.getComponente('nombre').enable();
			this.getComponente('descripcion').enable();
		},
		onButtonEdit : function() {
			Phx.vista.Clasificacion.superclass.onButtonEdit.call(this);
			var nodo = this.sm.getSelectedNode();
			if (nodo.attributes != undefined && nodo.attributes.estado == 'restringido') {
				this.getComponente('codigo').disable();
			} else if (nodo.attributes != undefined && nodo.attributes.estado == 'bloqueado') {
				this.getComponente('codigo').disable();
				this.getComponente('nombre').disable();
				this.getComponente('descripcion').disable();
			} else {
				this.getComponente('codigo').enable();
				this.getComponente('nombre').enable();
				this.getComponente('descripcion').enable();
			}
		},
		fields : [{
			name : 'id',
			type : 'numeric'
		}, {
			name : 'tipo_meta',
			type : 'string'
		}, {
			name : 'id_clasificacion',
			type : 'numeric'
		}, {
			name : 'id_clasificacion_fk',
			type : 'numeric'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_clasificacion',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		bexcel : true,
		bexcel : false,
		rootVisible : true,
		fwidth : 420,
		fheight : 300,
		onNodeDrop : function(o) {
		    this.ddParams = {
		        tipo_nodo : o.dropNode.attributes.tipo_nodo
		    };
		    this.idTargetDD = 'id_clasificacion';
		    if (o.dropNode.attributes.tipo_nodo == 'raiz' || o.dropNode.attributes.tipo_nodo == 'hijo') {
		        this.idNodoDD = 'id_clasificacion';
		        this.idOldParentDD = 'id_clasificacion_fk';
		    } else if(o.dropNode.attributes.tipo_nodo == 'item') {
		        this.idNodoDD = 'id_item';
                this.idOldParentDD = 'id_p';
		    }
		    Phx.vista.Clasificacion.superclass.onNodeDrop.call(this, o);
		},
		preparaMenu : function(n) {
			Phx.vista.Clasificacion.superclass.preparaMenu.call(this, n);
			this.id_nodo = 'id_clasificacion';
            this.id_nodo_p = 'id_clasificacion_fk';
			this.ddParams = {
                tipo_nodo : n.attributes.tipo_nodo
            };
			if (n.attributes.tipo_nodo == 'raiz' || n.attributes.tipo_nodo == 'hijo') {
			    this.getBoton('new').enable();
				this.getBoton('edit').enable();
				this.getBoton('del').enable();
				this.getBoton('btnBlockUnblock').enable();
				if (n.attributes.estado == 'bloqueado') {
					this.getBoton('btnBlockUnblock').setIconClass('bunlock');
					this.getBoton('btnBlockUnblock').setTooltip('<b>Desbloquear</b><br/>Desbloquea la clasificacion actual para su edición.');
				} else {
					this.getBoton('btnBlockUnblock').setIconClass('block');
					this.getBoton('btnBlockUnblock').setTooltip('<b>Bloquear</b><br/>Bloquea la clasificacion actual para que no pueda ser modificada.');
				}
			} else if (n.attributes.tipo_nodo == undefined) {
				this.getBoton('new').enable();
				this.getBoton('edit').disable();
				this.getBoton('del').disable();
				this.getBoton('btnBlockUnblock').disable();
			} else {
				this.getBoton('new').disable();
				this.getBoton('edit').disable();
				this.getBoton('del').disable();
				this.getBoton('btnBlockUnblock').disable();
			}
		},
		liberaMenu : function(n) {
			Phx.vista.Clasificacion.superclass.liberaMenu.call(this, n);
			this.getBoton('new').disable();
			this.getBoton('edit').disable();
			this.getBoton('del').disable();
			this.getBoton('btnBlockUnblock').disable();
		},
		getNombrePadre : function(n) {
			var direc;
			var padre = n.parentNode;
			if (padre) {
				if (padre.attributes.id != 'id') {
					direc = n.attributes.nombre + ' - ' + this.getNombrePadre(padre);
					return direc;
				} else {
					return n.attributes.nombre;
				}
			} else {
				return undefined;
			}
		},
		successSave : function(resp) {
			Phx.vista.Clasificacion.superclass.successSave.call(this, resp);
			var selectedNode = this.sm.getSelectedNode();
			selectedNode.attributes.estado = 'restringido';
		},
		south : {
			url : '../../../sis_almacenes/vista/item/Item.php',
			title : 'Materiales',
			height : 300,
			cls : 'Item'
		},
		onBtnBlockUnblock : function() {
			var node = this.sm.getSelectedNode();
			var data = node.attributes;
			if (data && (data.tipo_nodo == 'raiz' || data.tipo_nodo == 'hijo')) {
				Phx.CP.loadingShow();
				var nuevoEstado = (data.estado == 'bloqueado') ? 'restringido' : 'bloqueado';
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/Clasificacion/cambiarEstadoClasificacion',
					params : {
						'id_clasificacion' : data.id_clasificacion,
						estado : nuevoEstado
					},
					success : this.successBU,
					argument : {
						node : node.parentNode
					},
					failure : this.conexionFailure,
					timeout : this.timeout,
					scope : this
				});
			}
		},
		successBU : function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (!reg.ROOT.error) {
				alert(reg.ROOT.detalle.mensaje)
			} else {

				alert('ocurrio un error durante el proceso')
			}
			resp.argument.node.reload();

		},
	}); 
</script>
