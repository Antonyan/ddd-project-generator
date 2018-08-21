    /**
{$docParams}
     * @return {$ModelName}
     * @throws DbException
     */
    public function get({$params})
    {
        $filter = new CompassFilter();
{$filterConditions}
        $filter->setLimit(1);
        ${$modelName} = $this->load($filter)->getFirst();
        return ${$modelName} === null ? new {$ModelName}NullObject() : ${$modelName};
    }