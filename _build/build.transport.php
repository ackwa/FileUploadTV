<?php
/*
 * FileUploadTV :: build.transport.php
 *
 * Copyright 2012 by Kévin PAUSÉ (kevin.pause@supinfo.com)
 * Development funded by Ackwa, agency based at Larçay, Indre-et-Loire, Centre, FRANCE.
 *
 * All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 *
 */
 
$fStartTime = explode(' ', microtime());
$fStartTime = $fStartTime[1] + $fStartTime[0];
set_time_limit(0);

/* ----- PACKAGE VARIABLES ----- */

define('PKG_NAME', 'FileUploadTV');
define('PKG_NAME_LOWER', 'fileuploadtv');
define('PKG_VERSION', '1.0.0');
define('PKG_RELEASE', 'pl');

/* ----- ---------------- ----- */

/* ----- BUILD PATHS ----- */

$sRootDirectory = dirname(dirname(__FILE__)).'/';
$aSources = array(
		'root' => $sRootDirectory,
		'build' => $sRootDirectory . '_build/',
		'data' => $sRootDirectory . '_build/data/',
		'resolvers' => $sRootDirectory . '_build/resolvers/',
		'chunks' => $sRootDirectory.'core/components/'.PKG_NAME_LOWER.'/chunks/',
		'lexicon' => $sRootDirectory . 'core/components/'.PKG_NAME_LOWER.'/lexicon/',
		'docs' => $sRootDirectory.'core/components/'.PKG_NAME_LOWER.'/docs/',
		'elements' => $sRootDirectory.'core/components/'.PKG_NAME_LOWER.'/elements/',
		'source_assets' => $sRootDirectory.'assets/components/'.PKG_NAME_LOWER,
		'source_core' => $sRootDirectory.'core/components/'.PKG_NAME_LOWER,
		'input_tv' => $sRootDirectory.'core/model/modx/processors/element/tv/renders/mgr/input/fileUpload.php',
		'input_tv_properties' => $sRootDirectory.'core/model/modx/processors/element/tv/renders/mgr/inputproperties/fileUpload.php',
		'input_tv_templates' => $sRootDirectory.'manager/templates/default/element/tv/renders/input/fileUpload.tpl',
		'input_tv_properties_templates' => $sRootDirectory.'manager/templates/default/element/tv/renders/inputproperties/fileUpload.tpl',
		);
unset($sRootDirectory);

/* ----- ---------- ----- */

require_once $aSources['build'].'build.config.php';
require_once (MODX_CORE_PATH . 'model/modx/modx.class.php');

$modx = new modX();
$modx->initialize('mgr');

echo "<pre>";
$modx->setLogLevel(modX::LOG_LEVEL_INFO);
$modx->setLogTarget('ECHO');

$modx->loadClass('transport.modPackageBuilder', "", false, true);
$builder = new modPackageBuilder($modx);
$builder->createPackage(PKG_NAME, PKG_VERSION, PKG_RELEASE);
$builder->registerNamespace(PKG_NAME_LOWER, false, true, '{core_path}components/' .PKG_NAME_LOWER. '/');
	
//Creating new category for the extra
$category= $modx->newObject('modCategory');
$category->set('category',PKG_NAME);

/* ----- CATEGORY ATTRIBUTES ----- */	

$aAttr = array(
	xPDOTransport::UNIQUE_KEY => 'category',
    xPDOTransport::PRESERVE_KEYS => false,
    xPDOTransport::UPDATE_OBJECT => true,
    xPDOTransport::RELATED_OBJECTS => true,
    xPDOTransport::RELATED_OBJECT_ATTRIBUTES => array (
    	'Snippets' => array(
       		xPDOTransport::PRESERVE_KEYS => false,
            xPDOTransport::UPDATE_OBJECT => true,
            xPDOTransport::UNIQUE_KEY => 'name',
        ),
   	),
);
		
/* ----- ------------------- ----- */

//Adding category and its attributes into a vehicle		
$vehicle = $builder->createVehicle($category,$aAttr);
	
$modx->log(modX::LOG_LEVEL_INFO,'Adding package attributes and setup options...');
$builder->setPackageAttributes(array(
	'license' => file_get_contents($aSources['docs'] . 'license.txt'),
    'readme' => file_get_contents($aSources['docs'] . 'readme.txt'),
    'changelog' => file_get_contents($aSources['docs'] . 'changelog.txt'),
    'setup-options' => array(
    	'source' => $aSources['build'].'setup.options.php',
   		),
		
));

$modx->log(modX::LOG_LEVEL_INFO,'Adding file resolvers to category...');

/* ----- ADDING SOURCES ----- */

$vehicle->resolve('file',array(
	'source' => $aSources['source_assets'],
	'target' => "return MODX_ASSETS_PATH . 'components/';",
));

$vehicle->resolve('file',array(
	'source' => $aSources['input_tv'],
	'target' => "return MODX_CORE_PATH . 'model/modx/processors/element/tv/renders/mgr/input/';",
));

$vehicle->resolve('file',array(
	'source' => $aSources['input_tv_properties'],
	'target' => "return MODX_CORE_PATH . 'model/modx/processors/element/tv/renders/mgr/inputproperties/';",
));

$vehicle->resolve('file',array(
	'source' => $aSources['input_tv_templates'],
	'target' => "return MODX_MANAGER_PATH . 'templates/default/element/tv/renders/input/';",
));

$vehicle->resolve('file',array(
	'source' => $aSources['input_tv_properties_templates'],
	'target' => "return MODX_MANAGER_PATH . 'templates/default/element/tv/renders/inputproperties/';",
));
	
/* ----- -------------- ----- */
	
$builder->putVehicle($vehicle);
unset($vehicle);

//Zip package up
$modx->log(modX::LOG_LEVEL_INFO,'Packing up transport package zip...');
$builder->pack();
	
//End of Building
$fEndTime = explode(' ', microtime());
$fEndTime = $fEndTime[0] + $fEndTime[1];
$fTime = sprintf("%2.4f seconds", ($fEndTime - $fStartTime));
$modx->log(modX::LOG_LEVEL_INFO,"Package built in {$fTime}");

exit();
?>