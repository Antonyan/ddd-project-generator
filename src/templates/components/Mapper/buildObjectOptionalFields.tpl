    /**
     * @param array ${$modelName}Data
     * @return {$ModelName}
     */
    protected function buildObjectOptionalFields(array ${$modelName}Data)
    {
        return $this->buildObject(${$modelName}Data)
{$optionalFieldsSetters}
    }