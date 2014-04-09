<?php
/**
 * @package pxP
 * @file    BuscarClasificacion.php
 * @author  Gonzalo Sarmiento Sejas
 * @date    16-07-2013
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.BuscarClasificacion = Ext.extend(Phx.arbInterfaz, {
        constructor : function(config) {
        	alert('llega');
            this.maestro = config.maestro;
            Phx.vista.BuscarClasificacion.superclass.constructor.call(this, config);
            this.init();
            this.getBoton('triguerreturn').enable();          
        },
        Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_clasificacion'
			},
			type:'Field',
			form:true 
		}],
        NodoCheck:true,//si los nodos tienen los valores para el check
		ActCheck:'../../sis_seguridad/control/GuiRol/checkGuiRol',
        title : 'Buscador de Clasificacion',
        ActList : '../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
        //ActSearch : '../../sis_almacenes/control/Item/buscarClasificacionArb',
        id_store : 'id_clasificacion',
        baseParams : {clasificacion:true},                
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
        onCheckchange: function(){
			//do nothing
        },
	getAllChildNodes: function(node){ 
        var allNodes = new Array();
        if(!Ext.value(node,false)){ 
			return []; 
        } 
        if(!node.hasChildNodes()){ 
            return node; 
        } else{ 
            allNodes.push(node); 
            node.eachChild(function(Mynode){
            	allNodes = allNodes.concat(this.getAllChildNodes(Mynode));
            	if(Mynode.attributes.checked){
            		var _id = ','+Mynode.attributes.id_clasificacion;
            		var _desc = ', '+Mynode.attributes.text;
            		this.id_clasificacion = this.id_clasificacion + _id;
            		this.desc_clasificacion = this.desc_clasificacion + _desc;  
            	}
            },this);         
        } 
        return allNodes; 
	},
	seleccionNodos: function(node){
		this.id_clasificacion='';
		this.desc_clasificacion='';
		var nodes = this.getAllChildNodes(node);
		this.id_clasificacion = this.id_clasificacion.substring(1,this.id_clasificacion.length)
		this.desc_clasificacion = this.desc_clasificacion.substring(1,this.desc_clasificacion.length)
	},
	id_clasificacion:'',
	desc_clasificacion:'',
	btriguerreturn:true,
	onButtonTriguerreturn: function(){		
		this.seleccionNodos(this.root);
		Phx.CP.getPagina(this.idContenedorPadre).Cmp.clasificacion.setValue(this.desc_clasificacion);
		Phx.CP.getPagina(this.idContenedorPadre).id_clasificacion=this.id_clasificacion;
		this.panel.close();
	}        
        
}); 
</script>
