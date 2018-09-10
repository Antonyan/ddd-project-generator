<?php

namespace App\Services;

use Infrastructure\Annotations\Validation;
use Infrastructure\Models\CreateEntityJsonResponse;
use Infrastructure\Models\CRUDServiceInterface;
use Infrastructure\Models\DeleteEntityJsonResponse;
use Infrastructure\Models\GetEntityJsonResponse;
use Infrastructure\Models\UpdateEntityJsonResponse;
use Infrastructure\Services\BaseService;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class {$ServiceName}
 * @package App\Services
 */
class {$ServiceName} extends BaseService
{
    /**
     * @Validation(name="offset", type="string")
     * @Validation(name="orderByAsc", type="string")
     * @Validation(name="orderByDesc", type="string")
     * @Validation(name="like", type="string")
     * @Validation(name="gt", type="string")
     * @param Request $request
     * @return GetEntityJsonResponse
     * @throws Exception
     */
    public function load(Request $request) : GetEntityJsonResponse
    {
        throw new \BadMethodCallException('Not implemented');
    }

    /**
     * @param Request $request
     * @return CreateEntityJsonResponse
     * @throws Exception
     */
    public function create(Request $request) : CreateEntityJsonResponse
    {
        throw new \BadMethodCallException('Not implemented');
    }

    /**
     * @param Request $request
     * @param $id
     * @return UpdateEntityJsonResponse
     * @throws Exception
     */
    public function update(Request $request, $id) : UpdateEntityJsonResponse
    {
        throw new \BadMethodCallException('Not implemented');
    }

    /**
     * @param $id
     * @return DeleteEntityJsonResponse
     * @throws Exception
     */
    public function delete($id) : DeleteEntityJsonResponse
    {
        throw new \BadMethodCallException('Not implemented');
    }

     /**
     * @param $id
     * @return GetEntityJsonResponse
     * @throws Exception
     */
    public function get($id) : GetEntityJsonResponse
    {
        throw new \BadMethodCallException('Not implemented');
    }
}
