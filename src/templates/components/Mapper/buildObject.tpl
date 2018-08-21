    /**
     * @param array ${$modelName}Data
     * @return {$ModelName}
     */
    public function buildObject(array ${$modelName}Data)
    {
        if (!count(${$modelName}Data)) {
            return new {$ModelName}NullObject();
        }

        return new {$ModelName}(
{$constructorValues}
        );
    }