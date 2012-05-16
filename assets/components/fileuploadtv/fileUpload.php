<?

header('Content-Type: text/html; charset=UTF-8');

//Loading Class for MediaSource
require_once (dirname(dirname(dirname(dirname(__FILE__))))).'/core/model/modx/modx.class.php';
require_once (dirname(dirname(dirname(dirname(__FILE__))))).'/core/model/modx/modprocessor.class.php';
$modx = new modX();
$modx->initialize('mgr');
$modx->loadClass('sources.modMediaSource');

$maxSize = (!empty($_REQUEST['maxSize'])? ($_REQUEST['maxSize']*1024) : ($modx->getOption('upload_maxsize')));

//If basePath of the media source is not set, file will be uploaded at assets/data
$mediaSource = $modx->getObject('source.modMediaSource',$_REQUEST['mediaSource']);
$properties = $mediaSource->getPropertyList();
$source  = $mediaSource->getOption('basePath', $properties, $_REQUEST['uploadDir']);
$uploadDir = (empty($source)? $_REQUEST['uploadDir'] : '../../'.$source.'/');

$allowedTypes = explode(",", $modx->getOption('upload_files'));

$forbiddenTypes = explode(",", $_REQUEST['forbiddenTypes']);
$forbiddenTypes[] = 'htaccess';
$fileInfos = pathinfo($_FILES['userfile']['name']);

//Checking file type
if(in_array($fileInfos['extension'], $allowedTypes))
{
	if (!in_array($fileInfos['extension'], $forbiddenTypes))
	{
		//Checking file size
		if ($_FILES['userfile']['size'] <= $maxSize)
		{
			if(!is_dir($uploadDir))mkdir($uploadDir, 0755);
				$fileName = $_FILES['userfile']['name'];
			$uploadFile = $uploadDir.$fileName;
			$uploadFile = trim($uploadFile);
			if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadFile)) 
			{
				chmod($uploadFile, 0755);
				echo $modx->config['site_url'].'assets/'.$source.'/'.$fileName;
			}
			else
			{
				echo 'Error during uploading file';
			}
		}
		else
		{
			echo 'ERROR : File oversized';
		}
	}
	else
	{
		echo 'ERROR : Type ' .$fileInfos['extension']. ' not allowed';
	}
}
else
{
		echo 'ERROR : Type ' .$fileInfos['extension']. ' not allowed';
}
?>