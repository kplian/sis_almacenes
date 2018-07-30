<?php
/**
*@package pXP
*@file PreingresoDetActV2
*@author  RCM
*@date 08/08/2017
*@description Interfaz de preingreso, segunda versión, que genera el registro en el sistema de activos fijos de pxp (sis_kactivos_fijos)
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PreingresoDetActV2 = {
    require: '../../../sis_almacenes/vista/preingreso_det/PreingresoDet.php',
    requireclase: 'Phx.vista.PreingresoDet',
    title: 'Preingreso de Activos Fijos',
    ActList:'../../sis_almacenes/control/PreingresoDet/listarPreingresoDetV2',
    constructor: function(config) {
    	this.modificarAtributo();
    	Phx.vista.PreingresoDetActV2.superclass.constructor.call(this,config);
    	console.log('si llega aqui')
    	this.init();
   	},
   	modificarAtributo: function(){
   		console.log('sigue');
   		this.Atributos[9] = {
			config: {
				name: 'id_clasificacion',
				fieldLabel: 'Clasificación',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
                    url: '../../sis_kactivos_fijos/control/Clasificacion/ListarClasificacionTree',
                    id: 'id_clasificacion',
                    root: 'datos',
                    sortInfo: {
                        field: 'orden',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_clasificacion','clasificacion', 'id_clasificacion_fk','tipo_activo','depreciable','vida_util'],
                    remoteSort: true,
                    baseParams: {
                        par_filtro:'claf.clasificacion'
                    }
                }),
				valueField: 'id_clasificacion',
				displayField: 'descripcion',
				gdisplayField: 'desc_clasificacion',
				hiddenName: 'id_clasificacion',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_clasificacion']);
				},
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Código: {codigo}</p><p>Descripción: {descripcion}</p></div></tpl>',
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'cla.nombre',type: 'string'},
			grid: false,
			form: true
		};
   	},
   	east: {
		url : '../../../sis_almacenes/vista/preingreso_det/PreingresoDetModActV2.php',
		title : 'Preingreso',
		width : '50%',
		cls : 'PreingresoDetModActV2'
	}
};
</script>
