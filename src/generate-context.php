<?php

use Phalcon\Script\Color;

include_once('functions.php');

$shortopts  = '';
$shortopts .= 'n:';

$options = getopt($shortopts);

if (!$options){
    echo Color::colorize("\nSyntax: generate-context.php -n name\n", Color::BG_LIGHT_GRAY);
    exit();
}

if(!array_key_exists('n', $options)){
    echo Color::colorize("\nYou should specify context name as -n name\n", Color::FG_RED);
    exit;
}

$contextName = $options['n'];

$mainFolder = __DIR__ . '/generated/' . $contextName . DIRECTORY_SEPARATOR;

createFolder($mainFolder);
createFolder($mainFolder . 'config');
createFolder($mainFolder . 'Services');

addConfigFile($mainFolder);
addContainerFile($mainFolder);
addContractFile($mainFolder, $contextName);
addContextServiceFile($mainFolder, $contextName);

/**
 * @param $mainFolder
 * @param $contextName
 */
function addContextServiceFile($mainFolder, $contextName): void
{
    file_put_contents(
        $mainFolder . 'Services' . DIRECTORY_SEPARATOR . $contextName . 'Service.php',
        renderTemplate(['ContextName' => $contextName], TEMPLATES_PATH . '/ContextService.tpl')
    );
}

/**
 * @param $mainFolder
 * @param $contextName
 */
function addContractFile($mainFolder, $contextName): void
{
    file_put_contents(
        $mainFolder . $contextName . 'Contract.php',
        renderTemplate(['ContextName' => $contextName], TEMPLATES_PATH . '/Contract.tpl')
    );
}

/**
 * @param $mainFolder
 */
function addContainerFile($mainFolder): void
{
    file_put_contents(
        $mainFolder . '/config/container.php',
        renderTemplate([], TEMPLATES_PATH . '/emptyContainer.tpl')
    );
}







