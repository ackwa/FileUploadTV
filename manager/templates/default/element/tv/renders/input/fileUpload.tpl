<input type="hidden" id="tv{$tv->id}" name="tv{$tv->id}" value="{$tv->value}"/>

<div id="tv-image-preview-{$tv->id}">
    {if $tv->value}
	{$fileInformations = explode(".", $tv->value)}
    {if $modx->loadClass('sources.modMediaSource')}
    	{$mediaSource = $modx->getObject('source.modMediaSource',$params['mediaSource'])}
    	{$properties = $mediaSource->getPropertyList()}
    	{$basePath = $mediaSource->getOption('basePath', $properties)}
    {/if}
    {if sizeof($fileInformations) < 2}No file
     {else}
        <a href="{$tv->value}">
		{if in_array($fileInformations[sizeof($fileInformations) - 1], array("zip", "rar", "7z"))}<img src="templates/default/images/restyle/icons/compress.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("css"))}<img src="templates/default/images/restyle/icons/css.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("js"))}<img src="templates/default/images/restyle/icons/javascript.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("ppt", "pptx", "pptm", "pps", "ppsx", "ppsm"))}<img src="templates/default/images/restyle/icons/page_white_powerpoint.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("doc", "docx", "docm"))}<img src="templates/default/images/restyle/icons/page_white_word.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("gif", "jpg", "jpeg", "png", "bmp"))}<img src="templates/default/images/restyle/icons/picture.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("flv", "swf"))}<img src="templates/default/images/restyle/icons/page_white_flash.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("pdf", "psd"))}<img src="templates/default/images/restyle/icons/page_white_acrobat.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("php"))}<img src="templates/default/images/restyle/icons/page_white_php.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("html"))}<img src="templates/default/images/restyle/icons/html_valid.png"/>
        {elseif in_array($fileInformations[sizeof($fileInformations) - 1], array("csv", "xls", "xlsx", "xlsm"))}<img src="templates/default/images/restyle/icons/page_white_excel.png"/>
        {elseif sizeof($fileInformations) < 2} No file.
        {else}<img src="templates/default/images/restyle/icons/page_white.png"/>
        {/if}
        </a>Clic on icon to download {$tv->value}
        {/if}
     {/if}
</div>
<div id="my-form-{$tv->id}"></div>

<script type="text/javascript">
// <![CDATA[
  {literal}
  var onChange = " AIM.submit(this.form, {'onStart' : startCallback{/literal}{$tv->id}{literal}, 'onComplete' : completeCallback{/literal}{$tv->id}{literal}})";
  var uploadForm = document.createElement('form');
  uploadForm.setAttribute('id','uploadForm{/literal}{$tv->id}{literal}');
  uploadForm.setAttribute('method',"POST");
  uploadForm.setAttribute('enctype',"multipart/form-data");
  uploadForm.setAttribute('action',"{/literal}{$_config.site_url}{literal}assets/components/fileuploadtv/fileUpload.php");
  uploadForm.innerHTML = '<input type="hidden" name="uploadDir" value="{/literal}{$_config['assets_path']}{literal}data/"/>'+ //Upload in assets/data by default
						 '<input type="hidden" name="maxSize" value="{/literal}{$params['maxSize']}{literal}"/>'+
						 '<input type="hidden" name="forbiddenTypes" value="{/literal}{$params['forbiddenTypes']}{literal}"/>'+
						 '<input type="hidden" name="mediaSource" value="{/literal}{$params['mediaSource']}{literal}"/>'+
                        '<input type="file" name="userfile" onChange="'+onChange+';this.form.submit();"/>';
                        
  Ext.get("my-form-{/literal}{$tv->id}{literal}").appendChild(uploadForm);
  
  if(!document.getElementById("directDelete")){
    var directDelete = document.createElement('input');
    directDelete.setAttribute('id','directDelete');
    directDelete.setAttribute('name','directDelete');
    directDelete.setAttribute('type','hidden');
    Ext.get("my-form-{/literal}{$tv->id}{literal}").appendChild(directDelete);
  }
  
{/literal}
// ]]>
</script>

<script type="text/javascript">
// <![CDATA[
{literal}
/**
*
*  AJAX IFRAME METHOD (AIM)
*  http://www.webtoolkit.info/
*
**/

AIM = {

    frame : function(c) {

        var n = 'f' + Math.floor(Math.random() * 99999);
        var d = document.createElement('DIV');
        d.innerHTML = '<iframe style="display:none" src="about:blank" id="'+n+'" name="'+n+'" onload="AIM.loaded(\''+n+'\')"></iframe>';
        document.body.appendChild(d);

        var i = document.getElementById(n);
        if (c && typeof(c.onComplete) == 'function') {
            i.onComplete = c.onComplete;
        }

        return n;
    },

    form : function(f, name) {
        f.setAttribute('target', name);
    },

    submit : function(f, c) {
        AIM.form(f, AIM.frame(c));
        if (c && typeof(c.onStart) == 'function') {
            return c.onStart();
        } else {
            return true;
        }
    },

    loaded : function(id) {
        var i = document.getElementById(id);
        if (i.contentDocument) {
            var d = i.contentDocument;
        } else if (i.contentWindow) {
            var d = i.contentWindow.document;
        } else {
            var d = window.frames[id].document;
        }
        if (d.location.href == "about:blank") {
            return;
        }

        if (typeof(i.onComplete) == 'function') {
            i.onComplete(d.body.innerHTML);
        }
    }
}
            function startCallback{/literal}{$tv->id}{literal}() {
            //alert('start');
                // make something useful before submit (onStart)
                return true;
            }
            
            
            function completeCallback{/literal}{$tv->id}{literal}(response) {
                // make something useful after (onComplete)
                MODx.fireResourceFormChange();
                var d = Ext.get('tv-image-preview-{/literal}{$tv->id}{literal}');
                if (response) {
                    document.getElementById("directDelete").value +="#{/literal}{$_config['base_path']}{literal}"+document.getElementById("tv{/literal}{$tv->id}{literal}").value;
                    document.getElementById("tv{/literal}{$tv->id}{literal}").value=response;
                    d.update(response);
                    } else {
                      document.getElementById("tv{/literal}{$tv->id}{literal}").value='';
                      d.update('');
                      }
                //alert('complite');
               // document.getElementById('nr').innerHTML = parseInt(document.getElementById('nr').innerHTML) + 1;
               // document.getElementById('r').innerHTML = response;
            }

// ]]>
{/literal}
</script>