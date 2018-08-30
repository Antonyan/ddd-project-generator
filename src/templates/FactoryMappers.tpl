<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Factories;

use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Infrastructure\Services\BaseFactory;

class {$EntityName}Factory extends BaseFactory
{
    /**
     * @param array $data
     * @return {$EntityName}
     */
    public function create(array $data) : ArraySerializable
    {
        return new {$EntityName}(
            $this->setDefaultIfNotExists('id', 0, $data),
{$params}
        );

    }
}