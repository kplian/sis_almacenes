<?php
/**
 * @package pxP
 * @file    Clasificacion.php
 * @author  Ariel Ayaviri Omonte
 * @date    21-09-2012
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.BuscarItem = Ext.extend(Phx.arbInterfaz, {
        constructor : function(config) {
        	this.id_movimiento=config.id_movimiento;
            this.maestro = config.maestro;
            Phx.vista.BuscarItem.superclass.constructor.call(this, config);

            this.txtSearch = new Ext.form.TextField();
            this.txtSearch.on('specialkey', this.onTxtSearchSpecialkey, this);
            this.tbar.add(this.txtSearch);
            this.init();
            this.addButton('btnBuscar', {
                text : 'Buscar',
                iconCls : 'bzoom',
                disabled : false,
                handler : this.onBtnBuscar
            });
        },
        title : 'Buscador de Items',
        ActList : '../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
        ActSearch : '../../sis_almacenes/control/Item/buscarItemArb',
        id_store : 'id_clasificacion',
        textRoot : 'Clasificaciones',
        id_nodo : 'id_clasificacion',
        id_nodo_p : 'id_clasificacion_fk',
        enableDD : false,
        bnew : false,
        bsave : false,
        bedit : false,
        bdel : false,
        rootVisible : true,
        fwidth : 420,
        fheight : 300,
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
        onBtnBuscar : function() {
            this.sm.clearSelections();
            this.root.collapseChildNodes(true);
            this.clearLightNodes();
            if (this.txtSearch.getValue() != '') {
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url : this.ActSearch,
                    params : {
                        'text_search' : this.txtSearch.getValue()
                    },
                    success : this.successSearch,
                    failure : this.conexionFailure,
                    timeout : this.timeout,
                    scope : this
                });
            }
        },
        successSearch : function(response, e, i, o, u) {
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(response.responseText));
            var pathTxt;
            for (var i = 0; i < reg.datos.length; i++) {
                pathTxt = Ext.util.Format.trim(reg.datos[i].ruta);
                pathTxt = pathTxt.replace('{', '[');
                pathTxt = pathTxt.replace('}', ']');
                var path = eval(pathTxt);
                if (path.length == 0) {
                    this.showPath(path, '0_'+reg.datos[i].id.toString());
                } else {
                    this.showPath(path, path[path.length - 1].toString()+'_'+reg.datos[i].id.toString());
                }
            }
        },
        showPath : function(pathArray, foundId) {
            var global = this;
            if (pathArray.length > 0) {
                var currentNode = this.treePanel.getNodeById(pathArray[0].toString());
                currentNode.expand(false, true, function(node, b, c, d) {
                    pathArray.shift();
                    global.showPath(pathArray, foundId);
                    
                }, global);
            } else {
                var foundNode = global.treePanel.getNodeById(foundId.toString());
                foundNode.setCls('light-node');
                global.lightNodes[global.lightNodes.length] = foundNode;
            }
            
        },
        clearLightNodes : function() {
            if (this.lightNodes != undefined && this.lightNodes != null) {
                for (var i = 0; i < this.lightNodes.length; i++) {
                    this.lightNodes[i].setCls('');
                }
            }
            this.lightNodes = new Array();
        },
        onTxtSearchSpecialkey : function(field, e) {
            if (e.getKey() == e.ENTER) {
                this.onBtnBuscar();
            }
        },
        east:{
		  url:'../../../sis_almacenes/vista/item/ItemExistenciaAlmacen.php',
		  title:'Existencia de Materiales por Almacén', 
		  width:'30%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'ItemExistenciaAlmacen'
		},
		onBeforeLoad : function(treeLoader, node) {
			treeLoader.baseParams[this.id_nodo] = node.attributes[this.id_nodo];
			Ext.apply(treeLoader.baseParams,{id_movimiento:this.id_movimiento});
		},
}); 
</script>
