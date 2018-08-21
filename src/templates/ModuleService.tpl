<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Services;

use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Contexts\{$ContextName}\{$ModuleName}\Repositories\{$EntityName}DbRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Exception;
use Infrastructure\Exceptions\InfrastructureException;
use Infrastructure\Models\SearchCriteria\SearchCriteria;
use Infrastructure\Services\BaseService;
use ReflectionException;

class {$EntityName}Service extends BaseService
{
    /**
     * @param SearchCriteria $conditions
     * @return ArrayCollection
     * @throws InfrastructureException
     * @throws ReflectionException
     */
    public function load(SearchCriteria $conditions) : ArrayCollection
    {
        return $this->get{$EntityName}DbRepository()->load($conditions);
    }

    /**
     * @param array $data
     * @return {$EntityName}
     * @throws InfrastructureException
     * @throws ReflectionException
     * @throws Exception
     */
    public function create(array $data) : {$EntityName}
    {
        $data['id'] = 0;
        return $this->get{$EntityName}DbRepository()->create($data);
    }

    /**
     * @param $id
     * @param array $data
     * @return {$EntityName}
     * @throws Exception
     */
    public function update($id, array $data) : {$EntityName}
    {
        $this->get{$EntityName}DbRepository()->update(array_merge(['id' => $id], $data));
        return $this->get($id);
    }

    /**
     * @param $id
     * @return bool
     * @throws InfrastructureException
     * @throws Exception
     */
    public function delete($id) : bool
    {
        return $this->get{$EntityName}DbRepository()->delete($id);
    }

    /**
     * @param $id
     * @return {$EntityName}
     * @throws InfrastructureException
     * @throws ReflectionException
     */
    public function get($id) : {$EntityName}
    {
        return $this->get{$EntityName}DbRepository()->get($id);
    }

    /**
     * @return {$EntityName}DbRepository
     * @throws InfrastructureException
     * @throws ReflectionException
     */
    private function get{$EntityName}DbRepository() : {$EntityName}DbRepository
    {
        return $this->container()->get('{$entityName}DbRepository');
    }
}