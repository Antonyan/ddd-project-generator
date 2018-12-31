<?php

namespace App\Services;

use Exception;
use Infrastructure\Annotations\Validation;
use Infrastructure\Exceptions\InfrastructureException;
use Infrastructure\Models\CreateEntityJsonResponse;
use Infrastructure\Models\CRUDServiceInterface;
use Infrastructure\Models\DeleteEntityJsonResponse;
use Infrastructure\Models\GetEntityJsonResponse;
use Infrastructure\Models\UpdateEntityJsonResponse;
use Infrastructure\Services\BaseService;
use ReflectionException;
use Symfony\Component\HttpFoundation\Request;
use Infrastructure\Models\SearchCriteria\SearchCriteriaQueryString;

use {$FullContactName};

class {$ServiceName} extends BaseService implements CRUDServiceInterface
{
    /**
    {$LoadFields} * @Validation(name="limit", type="integer")
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
        return new GetEntityJsonResponse(
            $this->get{$ContractName}()->load{$EntityName}s(new SearchCriteriaQueryString($request->query->all()))->toArray()
        );
    }

    /**
    {$CreateFields} * @param Request $request
     * @return CreateEntityJsonResponse
     * @throws Exception
     */
    public function create(Request $request) : CreateEntityJsonResponse
    {
        return new CreateEntityJsonResponse($this->get{$ContractName}()->create{$EntityName}($request->request->all())->toArray());
    }

    /**
    {$UpdateFields} * @param Request $request
     * @param $id
     * @return UpdateEntityJsonResponse
     * @throws Exception
     */
    public function update(Request $request, $id) : UpdateEntityJsonResponse
    {
        return new UpdateEntityJsonResponse($this->get{$ContractName}()->update{$EntityName}($id, $request->request->all())->toArray());
    }

    /**
     * @param $id
     * @return DeleteEntityJsonResponse
     * @throws Exception
     */
    public function delete($id) : DeleteEntityJsonResponse
    {
        $this->get{$ContractName}()->delete{$EntityName}($id);
        return new DeleteEntityJsonResponse();
    }

     /**
     * @param $id
     * @return GetEntityJsonResponse
     * @throws Exception
     */
    public function get($id) : GetEntityJsonResponse
    {
        return new GetEntityJsonResponse($this->get{$ContractName}()->get{$EntityName}($id)->toArray());
    }

    /**
    * @return {$ContractName}
    * @throws InfrastructureException
    * @throws ReflectionException
    * @throws Exception
    */
    public function get{$ContractName}(): {$ContractName}
    {
        return $this->container()->get('{$ContextServiceName}');
    }
}
