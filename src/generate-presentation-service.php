<?php

use Phalcon\Script\Color;

include_once('functions.php');

$shortopts  = '';
$shortopts .= 'n:';
$shortopts .= 'c:';

$options = getopt($shortopts);

if (!$options) {
    echo Color::colorize(
        PHP_EOL . 'Syntax: generate-presentation-service.php -n name service -c full name contract' . PHP_EOL,
        Color::FG_RED
    );
    exit;
}

if (!array_key_exists('n', $options)) {
    echo Color::colorize(
        PHP_EOL . 'You should set name of presentation service' . PHP_EOL,
        Color::FG_RED
    );
    exit;
}

if (!array_key_exists('c', $options)) {
    echo Color::colorize(
        PHP_EOL . 'You should set contract name of presentation service' . PHP_EOL,
        Color::FG_RED
    );
    exit;
}

$namePresentationService = $options['n'];
$contactName = $options['c'];
$partsOfContractName = explode('\\', $contactName);
$shortContractName = end($partsOfContractName);
$mainFolder = __DIR__ . '/generated/app/';

if (!is_dir($mainFolder)) {
    createFolder($mainFolder);
}

if (!is_dir($mainFolder . 'config')) {
    createFolder($mainFolder . 'config');
}

if (!is_dir($mainFolder . 'Services')) {
    createFolder($mainFolder . 'Services');
}

addPresentationService($mainFolder . 'Services',  $namePresentationService, $contactName, $shortContractName);

function addPresentationService(string $path, string $serviceName, string $contractName, string $shortContractName)
{
    file_put_contents(
        "$path/$serviceName.php",
        renderTemplate([
            'ServiceName' => $serviceName,
            'FullContactName' => $contractName,
            'ContractName' => $shortContractName
        ], TEMPLATES_PATH . '/PresentationService.tpl')
    );
}