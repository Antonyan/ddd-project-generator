<?php

use Phalcon\Script\Color;

include_once('functions.php');

$shortopts  = '';
$shortopts .= 'n:';

$options = getopt($shortopts);

if (!$options) {
    echo Color::colorize(PHP_EOL . 'Syntax: generate-presentation-service.php -n name service', Color::BG_LIGHT_GRAY);
    exit;
}

if (!array_key_exists('n', $options)) {
    echo Color::colorize(
        PHP_EOL . 'You should name of presentation service' . PHP_EOL,
        Color::FG_RED
    );
    exit;
}

$namePresentationService = $options['n'];
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

addPresentationService($mainFolder . 'Services',  $namePresentationService);

function addPresentationService(string $path, string $name)
{
    file_put_contents(
        "$path/$name.php",
        renderTemplate(['ServiceName' => $name], TEMPLATES_PATH . '/PresentationService.tpl')
    );
}






