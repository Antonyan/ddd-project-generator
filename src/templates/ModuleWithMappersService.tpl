<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Services;

use Contexts\{$ContextName}\{$ModuleName}\Mappers\{$EntityName}DbMapper;
use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Infrastructure\Exceptions\InfrastructureException;
use Infrastructure\Models\PaginationCollection;
use Infrastructure\Models\SearchCriteria\SearchCriteria;
use Infrastructure\Services\BaseService;
use ReflectionException;

class {$EntityName}Service extends BaseService
{
    /**
     * @param SearchCriteria $conditions
     * @return PaginationCollection
     * @throws InfrastructureException
     * @throws ReflectionException
     */
    public function load(SearchCriteria $conditions) : PaginationCollection
    {
        return $this->get{$EntityName}DbMapper()->load($conditions);
    }

    /**
    * @param array $data
    * @return {$EntityName}
    * @throws InfrastructureException
    * @throws ReflectionException
    * @throws InfrastructureException
    */
    public function create(array $data) : {$EntityName}
    {
        $data['id'] = 0;
        return $this->get{$EntityName}DbMapper()->create($data);
    }

    /**
    * @param $id
    * @param array $data
    * @return {$EntityName}
    * @throws InfrastructureException
    * @throws ReflectionException
    */
    public function update($id, array $data) : {$EntityName}
    {
        return $this->get{$EntityName}DbMapper()->update(array_merge(['id' => $id], $data));
    }

    /**
    * @param $id
    * @return bool
    * @throws InfrastructureException
    * @throws ReflectionException
    */
    public function delete($id) : bool
    {
        return $this->get{$EntityName}DbMapper()->delete({$EntityName}::ID, $id);
    }

    /**
    * @param $id
    * @return {$EntityName}
    * @throws InfrastructureException
    * @throws ReflectionException
    */
    public function get($id) : {$EntityName}
    {
        return $this->get{$EntityName}DbMapper()->get(['id' => $id]);
    }

    /**
    * @return {$EntityName}DbMapper
    * @throws InfrastructureException
    * @throws ReflectionException
    */
    private function get{$EntityName}DbMapper() : {$EntityName}DbMapper
    {
        return $this->container()->get('{$EntityName}DbMapper');
    }
}