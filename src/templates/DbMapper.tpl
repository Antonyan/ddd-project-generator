<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Mappers;

use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Infrastructure\Mappers\DbMapper;
use Infrastructure\Exceptions\InfrastructureException;

class {$EntityName}DbMapper extends DbMapper
{
    /**
    * @param array $objectData
    * @return {$EntityName}
    * @throws InfrastructureException
    */
    public function create(array $objectData) : {$EntityName}
    {
        return parent::create($objectData);
    }

    /**
    * @param array $objectData
    * @return {$EntityName}
    * @throws InfrastructureException
    */
    public function update(array $objectData) : {$EntityName}
    {
        return parent::update($objectData);
    }
}