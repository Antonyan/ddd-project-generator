<?php

use Contexts\{$ContextName}\{$ModuleName}\Factories\{$EntityName}Factory;
use Contexts\{$ContextName}\{$ModuleName}\Mappers\{$EntityName}DbMapper;
use Infrastructure\Models\EntityToDataSourceTranslator;
use Symfony\Component\DependencyInjection\Reference;

$containerBuilder->register('{$EntityName}Factory', {$EntityName}Factory::class);

$containerBuilder->register('{$EntityName}DbTranslator', EntityToDataSourceTranslator::class)
->addArgument($containerBuilder->get('config')->{$EntityName}DbTranslator);

$containerBuilder->register('{$EntityName}DbMapper', {$EntityName}DbMapper::class)
        ->addArgument(new Reference('{$EntityName}Factory'))
        ->addArgument(new Reference('{$EntityName}DbTranslator'))
        ->addArgument(new Reference('MySqlClient'));