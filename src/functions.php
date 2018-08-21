<?php

use Phalcon\Script\Color;

define('TEMPLATES_PATH',  __DIR__ . '/templates/');
define('MODULES_PATH',  __DIR__ . '/templates/');
define('TAB', '    ');

include_once(__DIR__ . '/utility/Color.php');

/**
 * @param $mainFolder
 */
function addConfigFile($mainFolder): void
{
    file_put_contents(
        $mainFolder . '/config/config.php',
        renderTemplate([], TEMPLATES_PATH . '/configs/general.tpl')
    );
}

/**
 * @param $path
 */
function createFolder($path)
{
    if (!mkdir($path, 0755, true)) {
        die("\nFailed to create folder:" . $path . "\n");
    }
}

function extractFieldsStructure($fieldsData)
{
	$fields = explode(',', $fieldsData);

	foreach ($fields  as $key => $field) {
		$fieldValue = explode(':', $field);
		if (count($fieldValue) < 2){
			$fieldValue[1] = 'string';
		}
		$fields[$fieldValue[0]] = $fieldValue[1];
		unset($fields[$key]);
	}

	return $fields;
}

function extractDefaults(array $fieldsData)
{
    $defaults = [];
    foreach ($fieldsData  as $key => $default) {
        if (!empty($default)){
            $fieldValue = explode(':', $key);
            $defaults[$fieldValue[0]] = $default;
        }
    }
    return $defaults;
}

function renderTemplate(array $valuesMap, $templatePath)
{
	$content = file_get_contents($templatePath);

	foreach ($valuesMap as $label => $value) {
		$content = templateReplace($label, $value, $content);
	}

	return $content;
}

function templateReplace($search, $replaceValue, $stringToReplace)
{
	return str_replace('{$'.$search.'}', $replaceValue, $stringToReplace);
}

function generateConstants(array $fields)
{
	$constants = [];
	foreach ($fields as $field => $type) {
		$constants[] = renderTemplate(
				[
						'name' => getConstant($field),
						'value' => $field,
				],
				TEMPLATES_PATH.'/components/Constant.tpl'
		);
	}

	return implode("\n", $constants);
}

function generateFields(array $fields)
{
	$resultFields = [];
	foreach ($fields as $field => $type) {
		$resultFields[] = renderTemplate(
				[
						'field' => $field,
						'type' => $type,
						'typeDefaultValue' => getTypeDefaultValue($type),
				],
				TEMPLATES_PATH.'/components/PrivateField.tpl'
		);
	}

	return implode("\n", $resultFields);
}

function generateConstructor(array $fields)
{
	$docParams = [];
	$constructorParams = [];
	$setters = [];
	foreach ($fields as $field => $type) {
		$docParams[] = TAB.' * @param '.$type.' $'.$field;
		$constructorParams[] = TAB.TAB.getTypeForMethodDeclaration($type).'$'.$field;
		$setters[] = TAB.TAB.TAB.'->set'.ucfirst($field).'($'.$field.')';
	}

	return renderTemplate(
			[
					'docParams' => implode("\n", $docParams),
					'paramethers' => implode(",\n", $constructorParams),
					'setters' => TAB.TAB."\$this\n".implode("\n", $setters).';',
			],
			TEMPLATES_PATH.'/components/Constructor.tpl'
	);
}

function generateToArray(array $fields)
{
	$toArrayFields = [];
	$typesWithoutToArraySuffix = ['string', 'int', 'integer', 'array', 'float'];
	foreach ($fields as $field => $type) {
		$toArrayString = TAB.TAB.TAB.'self::'.getConstant($field).' => $this->get'.ucfirst($field).'()';
		$toArrayString .= in_array($type, $typesWithoutToArraySuffix) ? ',' : '->toArray(),';
		$toArrayFields[] = $toArrayString;
	}

	return renderTemplate(
			[
					'fields' => implode("\n", $toArrayFields),
			],
			TEMPLATES_PATH.'/components/ToArray.tpl'
	);
}

function generateAccessors(array $fields, $modelName)
{
	$accessors = [];
	foreach ($fields as $field => $type) {
		$accessors[] = renderTemplate(
				[
						'field' => $field,
						'Field' => ucfirst($field),
						'typeDoc' => $type,
						'typeSetter' => getTypeForMethodDeclaration($type),
						'ModelName' => $modelName,
				],
				TEMPLATES_PATH.'/components/Accessors.tpl'
		);
	}

	return implode("\n", $accessors);
}

function getTypeForMethodDeclaration($type)
{
	switch ($type) {
		case 'int' :
		case 'float' :
		case 'integer' :
		case 'string' :
			return '';
		default :
			return $type.' ';
	}
}

function getTypeDefaultValue($type)
{
	switch ($type) {
		case 'int' :
		case 'float' :
		case 'integer' :
			return '0';
		case 'string' :
			return '\'\'';
		default :
			return 'null';
	}
}

function getConstant($field)
{
	$constant = '';
	for ($i = 0; $i < strlen($field); ++$i) {
		if (preg_match('/[a-z]/', $field[$i])) {
			$constant .= strtoupper($field[$i]);
			continue;
		}
		if (preg_match('/[A-Z]/', $field[$i])) {
			$constant .= '_'.$field[$i];
			continue;
		}
		$constant .= $field[$i];
	}

	return $constant;
}

function getToArrayMarker($action)
{
	switch ($action) {
		case 'load':
		case 'create':
		case 'update':
			return '->toArray()';
		default:
			return '';

	}
}

function getReturnType($action)
{
	switch ($action) {
		case 'load':
		case 'create':
		case 'update':
			return 'array';
		default:
			return 'boolean';

	}
}

function addDi($diFile, $content)
{
	$currentDI = file_get_contents($diFile);
	$currentDI .= $content;

	file_put_contents($diFile, $currentDI);
}

function getFieldsWithShortType($fields)
{
	$fieldsWithShortType = [];
	foreach ($fields as $field => $type) {
		preg_match('/[^\\\\]+$/', $type, $matches);
		$fieldsWithShortType[$field] = $matches[0];
	}

	return $fieldsWithShortType;
}

function tittleWithDash($moduleName)
{
	$tittle = lcfirst($moduleName);
	$newTittleArray = [];
	for ($i = 0;$i < strlen($moduleName);++$i) {
		if ($tittle[$i] == strtoupper($tittle[$i])) {
			array_push($newTittleArray, '-'.lcfirst($tittle[$i]));
		} else {
			array_push($newTittleArray, $tittle[$i]);
		}
	}
	$newTittle = implode($newTittleArray);

	return $newTittle;
}

function info($message)
{
    echo Color::info($message);
}
function debug($message)
{
    echo Color::head("[Debug] $message\n");
}
function warning($message)
{
    echo Color::colorize("[Warning] $message\n", Color::FG_YELLOW);
}
function error($message)
{
    echo Color::error($message);
}
function success($message)
{
    echo Color::success($message);
}
function text($message)
{
    echo Color::colorize("$message\n", Color::FG_WHITE);
}