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
use Infrastructure\Models\SearchCriteria\SearchCriteriaQueryString;

use {$FullContactName};

/**
 * Class {$ServiceName}
 * @package App\Services
 */
class {$ServiceName} extends BaseService implements CRUDServiceInterface
{
    /**
     * @Validation(name="offset", type="string")
     * @Validation(name="offset", type="string")
     * @Validation(name="orderByAsc", type="string")
     * @Validation(name="orderByDesc", type="string")
     * @Validation(name="like", type="string")
     * @Validation(name="gt", type="string")
     * @param Request $request
     * @return GetEntityJsonResponse
     * @throws \Exception
     */
    public function load(Request $request) : GetEntityJsonResponse
    {
        return new GetEntityJsonResponse(
            $this->get{$ContractName}()->load(new SearchCriteriaQueryString($request->query->all()))->toArray()
        );
    }

    /**
     * @param Request $request
     * @return CreateEntityJsonResponse
     * @throws \Exception
     */
    public function create(Request $request) : CreateEntityJsonResponse
    {
        return new CreateEntityJsonResponse($this->get{$ContractName}()->create($request->request->all())->toArray());
    }

    /**
     * @param Request $request
     * @param $id
     * @return UpdateEntityJsonResponse
     * @throws \Exception
     */
    public function update(Request $request, $id) : UpdateEntityJsonResponse
    {
        return new UpdateEntityJsonResponse($this->get{$ContractName}()->update($id, $request->request->all())->toArray());
    }

    /**
     * @param $id
     * @return DeleteEntityJsonResponse
     * @throws \Exception
     */
    public function delete($id) : DeleteEntityJsonResponse
    {
        $this->get{$ContractName}()->delete($id);
        return new DeleteEntityJsonResponse();
    }

     /**
     * @param $id
     * @return GetEntityJsonResponse
     * @throws \Exception
     */
    public function get($id) : GetEntityJsonResponse
    {
        return new GetEntityJsonResponse($this->get{$ContractName}()->get($id)->toArray());
    }

    /**
    * @return {$ContractName}
    */
    public function get{$ContractName}(): {$ContractName}
    {
        return $this->container()->get('{$ContractName}');
    }
}
