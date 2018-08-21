<?php

use Contexts\{$ContextName}\{$ModuleName}\Factories\{$EntityName}Factory;
use Contexts\{$ContextName}\{$ModuleName}\Repositories\{$EntityName}DbRepository;
use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Symfony\Component\DependencyInjection\Reference;

$containerBuilder->register('{$EntityName}Factory', {$EntityName}Factory::class);

$containerBuilder->register('{$EntityName}DbRepository', {$EntityName}DbRepository::class)
    ->addArgument(new Reference('entityManager'))
    ->addArgument({$EntityName}::class)
    ->addArgument(new Reference('{$EntityName}Factory'));