<div id="tv-input-properties-form{$tv}"></div>
{literal}

<script type="text/javascript">
// <![CDATA[
var params = {
{/literal}{foreach from=$params key=k item=v name='p'}
 '{$k}': '{$v|escape:"javascript"}'{if NOT $smarty.foreach.p.last},{/if}
{/foreach}{literal}
};
var oc = {'change':{fn:function(){Ext.getCmp('modx-panel-tv').markDirty();},scope:this}};

MODx.load({
    xtype: 'panel'
    ,layout: 'form'
    ,cls: 'form-with-labels'
    ,autoHeight: true
    ,border: false
    ,labelAlign: 'top'
    ,labelSeparator: ''
    ,items: [{
        xtype: 'modx-combo-source'
		,fieldLabel: 'Media Source'
		,name: 'inopt_mediaSource'
		,hiddenName: 'inopt_mediaSource'
		,id: 'inopt_mediaSource'
		,value: params['mediaSource'] || ''
		,width: 200
		,listeners: oc
     },{
        xtype: MODx.expandHelp ? 'label' : 'hidden'
        ,forId: 'inopt_mediaSource{/literal}{$tv}{literal}'
        ,id: 'inopt_mediaSource{/literal}{$tv}{literal}-help'
        ,html: 'Used to know path where upload files'
        ,cls: 'desc-under'
	},{
        xtype: 'textfield'
        ,fieldLabel: 'Maximum file size (Ko)'
        ,name: 'inopt_maxSize'
        ,id: 'inopt_maxSize{/literal}{$tv}{literal}'
        ,value: params['maxSize'] || ''
        ,width: 200
        ,listeners: oc
    },{
        xtype: 'textfield'
        ,fieldLabel: 'Forbidden types (separated by ",")'
        ,name: 'inopt_forbiddenTypes'
        ,id: 'inopt_forbiddenTypes{/literal}{$tv}{literal}'
        ,value: params['forbiddenTypes'] || ''
        ,width: 200
        ,listeners: oc
    }]
    ,renderTo: 'tv-input-properties-form{/literal}{$tv}{literal}'
});
// ]]>
</script>
{/literal}
