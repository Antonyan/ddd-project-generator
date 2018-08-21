<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Factories;

use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Infrastructure\Services\EntityFactory;

class {$EntityName}Factory extends EntityFactory
{
    /**
     * @param array $data
     * @return {$EntityName}
     */
    public function create(array $data) : {$EntityName}
    {
        return (new {$EntityName}())
            {$Setters}
        ;
    }
}