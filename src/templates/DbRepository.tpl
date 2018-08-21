<?php

namespace Contexts\{$ContextName}\{$ModuleName}\Repositories;

use Contexts\{$ContextName}\{$ModuleName}\Factories\{$EntityName}Factory;
use Contexts\{$ContextName}\{$ModuleName}\Models\{$EntityName};
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Exception;
use Infrastructure\Repository\DbRepository;

class {$EntityName}DbRepository extends DbRepository
{
    /**
     * @var {$EntityName}Factory
     */
    private ${$entityName}Factory;

    public function __construct(EntityManager $entityManager, $entity, {$EntityName}Factory ${$entityName}Factory)
    {
        parent::__construct($entityManager, $entity);
        $this->{$entityName}Factory = ${$entityName}Factory;
    }

    /**
     * @param array $data
     * @return {$EntityName}
     */
    protected function createObject(array $data) : {$EntityName}
    {
        return $this->{$entityName}Factory->create($data);
    }

    /**
     * @param array $data
     * @return {$EntityName}
     * @throws Exception
     */
    public function create(array $data) : {$EntityName}
    {
        return $this->createEntity($data);
    }

    /**
     * @param array $data
     * @return {$EntityName}
     * @throws Exception
     */
    public function update(array $data) : {$EntityName}
    {
        return $this->updateEntity($data);
    }

    /**
     * @param int $id
     * @return bool
     * @throws Exception
     */
    public function delete(int $id) : bool
    {
        return $this->deleteEntity($id, {$EntityName}::class);
    }
}