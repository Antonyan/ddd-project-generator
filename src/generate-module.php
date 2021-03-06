<?php

use Phalcon\Script\Color;

require __DIR__.'/../../../autoload.php';

include_once('functions.php');

$shortopts  = '';
$shortopts .= 'n:';

$options = getopt($shortopts);

if (!$options){
    echo Color::colorize("\nSyntax: generate-module.php -n namespace\n", Color::BG_LIGHT_GRAY);
    exit();
}

if(!array_key_exists('n', $options)){
    echo Color::colorize("\nYou should specify path to Entity as -n namespace\n", Color::FG_RED);
    exit;
}

$entityNamespace = $options['n'];

$entity = new ReflectionClass($entityNamespace);

$properties = [];
$entityName = array_pop(explode('\\' , $entity->getName()));

foreach ($entity->getProperties() as $reflection) {
    $properties[] = $reflection->name;
}

$path = $entity->getFileName();

$pathArray = explode(DIRECTORY_SEPARATOR, $path);
array_pop($pathArray);
$contextName = end($pathArray);

$moduleName = $entityName . 'Module';
$modulePath = implode(DIRECTORY_SEPARATOR, $pathArray)
    . DIRECTORY_SEPARATOR . $entityName . 'Module' . DIRECTORY_SEPARATOR;

createFolder($modulePath);
createFolder($modulePath . 'config');
createFolder($modulePath . 'Services');
createFolder($modulePath . 'Models');
createFolder($modulePath . 'Mappers');
createFolder($modulePath . 'Factories');

addConfigFileWithEntityMapping($modulePath, $entityName, $properties);
addContainerFile($modulePath, $contextName, $moduleName, $entityName);
addFactoryFile($modulePath, $contextName, $moduleName, $entityName, $properties);

moveEntityToModuleModels($path, $entity, $contextName, $moduleName, $modulePath, $entityName);

addDbMapperFile($modulePath, $entityName, $contextName, $moduleName);
addModuleServiceFile($modulePath, $entityName, $contextName, $moduleName);



function addConfigFileWithEntityMapping($modulePath, $entityName, $properties)
{
    $columnMap = [];
    $tableName = tableName($entityName);
    
    foreach ($properties as $property) {
        $columnMap[] = "\t\t\t" . '\'' . $property . '\' => \'' . $tableName . '.' . $property . '\',';
    }

    file_put_contents(
        $modulePath . '/config/config.php',
        renderTemplate([
            'EntityName' => $entityName,
            'tableName' => '\'' . $tableName . '\'',
            'columnsMapping' => implode("\n", $columnMap),
        ], TEMPLATES_PATH . '/configs/moduleConfig.tpl')
    );
}

/**
 * @param $entityName
 * @return string
 */
function tableName($entityName): string
{
    return lcfirst($entityName) . 's';
}

/**
 * @param $modulePath
 * @param $entityName
 * @param $contextName
 * @param $moduleName
 */
function addModuleServiceFile($modulePath, $entityName, $contextName, $moduleName): void
{
    file_put_contents(
        $modulePath . '/Services/' . ucfirst($entityName) . 'Service.php',
        renderTemplate([
            'ContextName' => $contextName,
            'ModuleName' => $moduleName,
            'EntityName' => $entityName,
        ], TEMPLATES_PATH . '/ModuleWithMappersService.tpl')
    );
}

/**
 * @param $mainFolder
 */
function addContainerFile($mainFolder, $contextName, $moduleName, $entityName): void
{
    file_put_contents(
        $mainFolder . '/config/container.php',
        renderTemplate([
            'ContextName' => $contextName,
            'ModuleName' => $moduleName,
            'EntityName' => $entityName,
        ], TEMPLATES_PATH . '/moduleWithMapperContainer.tpl')
    );
}

/**
 * @param $mainFolder
 */
function addFactoryFile($mainFolder, $contextName, $moduleName, $entityName, $properties): void
{
    file_put_contents(
        $mainFolder . '/Factories/' . ucfirst($entityName) . 'Factory.php',
        renderTemplate([
            'ContextName' => $contextName,
            'ModuleName' => $moduleName,
            'EntityName' => $entityName,
            'params' => createParams($properties),
        ], TEMPLATES_PATH . '/FactoryMappers.tpl')
    );
}

/**
 * @param $properties
 * @return string
 */
function createObjectSetters($properties): string
{
    $setters = '';

    foreach ($properties as $property) {

        if ($property === 'id') {
            $setters .= '->set' . ucfirst($property) . '(array_key_exists(\'id\', $data) ? $data[\'id\'] : 0)' . "\n";
            continue;
        }

        $setters .= "\t\t\t" . '->set' . ucfirst($property) . '($data[\'' . $property . '\'])' . "\n";
    }

    return $setters;
}

/**
 * @param $properties
 * @return string
 */
function createParams($properties) 
{
    $params = '';

    foreach ($properties as $property) {
        if ($property == 'id'){
            continue;
        }
        
        $params .= "\t\t\t" . '$data[\'' . $property . '\'],' . "\n";
    }
    
    return rtrim($params, ',' . "\n");
}

/**
 * @param $path
 * @param $entity
 * @param $contextName
 * @param $moduleName
 * @param $modulePath
 * @param $entityName
 */
function moveEntityToModuleModels($path, $entity, $contextName, $moduleName, $modulePath, $entityName): void
{
    $entityFile = file_get_contents($path);
    $entityFile = str_replace('namespace ' . $entity->getNamespaceName(),
        'namespace Contexts\\' . $contextName . '\\' . $moduleName . '\\Models', $entityFile);
    file_put_contents($path, $entityFile);
    rename($path, $modulePath . DIRECTORY_SEPARATOR . 'Models' . DIRECTORY_SEPARATOR . $entityName . '.php');
}

/**
 * @param $modulePath
 * @param $entityName
 * @param $contextName
 * @param $moduleName
 */
function addDbMapperFile($modulePath, $entityName, $contextName, $moduleName): void
{
    file_put_contents(
        $modulePath . '/Mappers/' . ucfirst($entityName) . 'DbMapper.php',
        renderTemplate([
            'ContextName' => $contextName,
            'ModuleName' => $moduleName,
            'EntityName' => $entityName,
        ], TEMPLATES_PATH . '/DbMapper.tpl')
    );
}