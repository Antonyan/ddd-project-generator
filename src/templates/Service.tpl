<?php

namespace Modules\{$ModuleName};

use Energon\Exceptions\EnergonCoreException;
use Modules\LibraryModule\Exceptions\DbException;
use Modules\LibraryModule\Exceptions\EnergonException;
use Modules\LibraryModule\Services\BaseService;
use Modules\LibraryModule\Models\PaginationCollection;
use Modules\{$ModuleName}\Models\{$Name};
use Modules\{$ModuleName}\Mappers\{$Name}DbMapper;
use Modules\{$ModuleName}\Builders\{$Name}Builder;

/**
 * Class {$Name}Service
 * @package Modules\{$Name}Module
 */
class {$Name}Service extends BaseService
{
    /**
     * @param array ${$name}Data
     * @return PaginationCollection
     * @throws EnergonException
     * @throws DbException
     * @throws EnergonCoreException
     */
    public function load(array ${$name}Data)
    {
        return $this->get{$Name}DbMapper()->load($this->buildFilters(${$name}Data, []));
    }

    /**
     * @param $id
     * @return {$Name}
     * @throws EnergonCoreException
     */
    public function get($id)
    {
        return $this->get{$Name}DbMapper()->get([{$Name}::ID => $id]);
    }

    /**
     * @param array ${$name}Data
     * @return {$Name}
     * @throws EnergonException
     * @throws DbException
     * @throws EnergonCoreException
     */
    public function create(array ${$name}Data)
    {
        return $this->get{$Name}DbMapper()->create($this->get{$Name}Builder()->build(${$name}Data));
    }

    /**
    * @param array ${$name}Data
    * @return {$Name}
    * @throws EnergonException
    * @throws DbException
    * @throws EnergonCoreException
    */
    public function update(array ${$name}Data)
    {
        return $this->get{$Name}DbMapper()->update($this->get{$Name}Builder()->build(${$name}Data));
    }

    /**
     * @param array ${$name}Data
     * @return bool
     * @throws EnergonException
     * @throws DbException
     * @throws EnergonCoreException
     */
    public function delete(array ${$name}Data)
    {
        return $this->get{$Name}DbMapper()->delete($this->buildFilters(${$name}Data, []));
    }

    /**
     * @return {$Name}DbMapper
     * @throws EnergonCoreException
     */
    private function get{$Name}DbMapper()
    {
        return $this->getServiceLocator()->get('{$Name}DbMapper');
    }

    /**
    * @return {$Name}Builder
    * @throws EnergonCoreException
    */
    private function get{$Name}Builder()
    {
        return $this->getServiceLocator()->get('{$Name}Builder');
    }
}
