<?php
/**
*@package pXP
*@file MovimientoReq.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-07-2013 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoReqSalida= {
	require:'../../../sis_almacenes/vista/movimiento/Movimiento.php',
	requireclase:'Phx.vista.Movimiento',
	title:'Movimiento',	
	nombreVista: 'movimientoReqSalida',
	
	gruposBarraTareas:[{name:'borrador',title:'<H1 align="center"><i class="fa fa-thumbs-o-down"></i> Borradores</h1>',grupo:0,height:0},
                       {name:'en_aprobacion',title:'<H1 align="center"><i class="fa fa-eye"></i> En Aprobacion</h1>',grupo:1,height:0},
                       {name:'en_almacenes',title:'<H1 align="center"><i class="fa fa-eye"></i> En Almacenes</h1>',grupo:2,height:0},
                       {name:'entregado',title:'<H1 align="center"><i class="fa fa-thumbs-o-up"></i> Entregado</h1>',grupo:3,height:0}],
		
	actualizarSegunTab: function(name, indice){		
		if(this.finCons){
			 this.store.baseParams.pes_estado = name;
			 this.load({params:{start:0, limit:this.tam_pag, ids:this.ids, cmb_tipo_movimiento:'salida'}});
		   }
	},
	
	beditGroups: [0],
    bdelGroups:  [0],
    bactGroups:  [0,1,2,3],
    btestGroups: [0],
    bexcelGroups: [0,1,2,3],
	
	constructor: function(config) {
		this.maestro = config;

    	Phx.vista.MovimientoReqSalida.superclass.constructor.call(this,config);

    	this.Cmp.id_funcionario.store.baseParams.tipo_filtro = 'usuario';
        this.addButton('btnChequeoDocumentosWf', {
            text: 'Documentos',
            iconCls: 'bchecklist',
            disabled: true,
            grupo:[0,3],
            handler: this.loadCheckDocumentosSolWf,
            tooltip: '<b>Documentos de la Solicitud</b><br/>Subir los documentos requeridos en la solicitud seleccionada.'
        });

        /*this.addButton('comail',{
            text:'',
            iconCls: 'bsendmail',
            disabled:false,
            grupo:[3],
            handler:this.onRegistrarComail,
            tooltip: '<b>Agregar numero comail</b>'
        });*/
        
    	//Botón de finalización
    	this.addButton('fin_requerimiento',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar</b>'});
		//Creación de ventana para workflow
		this.crearVentanaWF();

	    this.iniciarEventos();
		this.store.baseParams={tipo_interfaz:this.nombreVista};
		this.store.baseParams.pes_estado = 'borrador';
		this.load({params:{start:0, limit:this.tam_pag,ids:this.ids, cmb_tipo_movimiento:'salida'}});
		
		//Setea el tipo de movimiento a salida
		this.Cmp.tipo.setValue('salida');
		this.Cmp.tipo.disable();
		this.cmbMovimientoTipo.disable();
		
		this.finCons = true;
	},
    
    iniciarEventos:function(){

        this.cmpFechaMov = this.getComponente('fecha_mov');
        this.cmpIdGestion = this.getComponente('id_gestion');
        this.cmpComail = this.getComponente('comail');
        /*this.cmpMovimientoTipo = this.getComponente('tipo');
        this.cmpSubtipoMovimiento = this.getComponente('id_movimiento_tipo');
        this.cmpAlmacen = this.getComponente('id_almacen');
        this.cmpDescripcion = this.getComponente('descripcion');
        this.cmpTipoSolicitante = this.getComponente('solicitante');
        this.cmpFuncionario = this.getComponente('id_funcionario');
        this.cmpObservaciones = this.getComponente('observaciones');
        */

        //inicio de eventos 
        this.cmpFechaMov.on('change',function(f){
             this.obtenerGestion(this.cmpFechaMov);
		},this);        
      
    },
         
    onButtonNew:function(){
       Phx.vista.MovimientoReqSalida.superclass.onButtonNew.call(this);
        /*this.mostrarComponente(this.cmpMovimientoTipo);
        this.mostrarComponente(this.cmpFechaMov);
        this.mostrarComponente(this.cmpSubtipoMovimiento);
        this.mostrarComponente(this.cmpAlmacen);
        this.mostrarComponente(this.cmpDescripcion);
        this.mostrarComponente(this.cmpObservaciones);
        this.ocultarComponente(this.cmpComail);*/

       //this.Cmp.fecha_mov.setValue(new Date());
       this.Cmp.fecha_mov.fireEvent('change');
       //Setea el tipo de movimiento a salida
		this.Cmp.tipo.setValue('salida');
		this.Cmp.tipo.disable();
		
		this.setFiltroMovTipo('salida');
		this.Cmp.id_funcionario.store.load({params:{start:0,limit:this.tam_pag}, 
           callback : function (r) {
                if (r.length == 1 ) {                       
                    this.Cmp.id_funcionario.setValue(r[0].data.id_funcionario);
                }    
                                
            }, scope : this
        });      
           
    },
    
    obtenerGestion:function(x){
		if(Ext.isDate(x.getValue())){
	    	var fecha = x.getValue().dateFormat(x.format);
            Phx.CP.loadingShow();
            Ext.Ajax.request({
                    url:'../../sis_parametros/control/Gestion/obtenerGestionByFecha',
                    params:{fecha:fecha},
                    success:this.successGestion,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
             });
		}
	}, 
        
    successGestion:function(resp){ 
       Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                this.cmpIdGestion.setValue(reg.ROOT.datos.id_gestion);
            }else{
                alert('Ocurrió al obtener la gestion')
            } 
    },
	preparaMenu:function(n){
		var data = this.getSelectedData();
	    var tb =this.tbar;
	    Phx.vista.MovimientoReqSalida.superclass.preparaMenu.call(this,n);
        if(data['estado_mov']== 'borrador' || data['estado_mov']=='Borrador'){
           this.getBoton('fin_requerimiento').enable();
           this.getBoton('btnChequeoDocumentosWf').enable();
         }
        else{
             this.getBoton('fin_requerimiento').disable();
             this.getBoton('edit').disable();
             this.getBoton('del').disable();  
             this.getBoton('btnChequeoDocumentosWf').enable();
        }
        return tb;
     },
/*
     onRegistrarComail:function(){

         this.onButtonEdit();
         this.ocultarComponente(this.cmpMovimientoTipo);
         this.ocultarComponente(this.cmpFechaMov);
         this.ocultarComponente(this.cmpSubtipoMovimiento);
         this.ocultarComponente(this.cmpAlmacen);
         this.ocultarComponente(this.cmpDescripcion);
         this.ocultarComponente(this.cmpObservaciones);
         this.ocultarComponente(this.cmpTipoSolicitante);
         this.ocultarComponente(this.cmpFuncionario);
         this.mostrarComponente(this.cmpComail);
     },*/

    loadCheckDocumentosSolWf:function() {
        var rec=this.sm.getSelected();
        rec.data.nombreVista = this.nombreVista;
        Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
            'Chequear documento del WF',
            {
                width:'90%',
                height:500
            },
            rec.data,
            this.idContenedor,
            'DocumentoWf'
        )
    },

    /*onButtonEdit:function(){

        var tb = Phx.vista.MovimientoReqSalida.superclass.onButtonEdit.call(this);
        this.mostrarComponente(this.cmpMovimientoTipo);
        this.mostrarComponente(this.cmpFechaMov);
        this.mostrarComponente(this.cmpSubtipoMovimiento);
        this.mostrarComponente(this.cmpAlmacen);
        this.mostrarComponente(this.cmpDescripcion);
        this.mostrarComponente(this.cmpObservaciones);
        this.ocultarComponente(this.cmpComail);
    },*/

     liberaMenu:function(){
        var tb = Phx.vista.MovimientoReqSalida.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('fin_requerimiento').disable();
           
        }
        
       return tb;
   }

};
</script>
