    /**
     * @param {$ModelName} ${$modelName}
     * @return {$ModelName}
     * @throws DbException
     */
    public function updateObject(${$modelName})
    {
        $updateValues = [
            // todo insert values
        ];

        $whereValues = [
            // todo insert values
        ];

        $qb = new CompassQueryBuilder($this->getColumns());
        $updateQuery = $qb->getUpdateQuery($updateValues, $whereValues, static::TABLE);
        $this->getDb()->execute($updateQuery->getQuery(), $updateQuery->getBindingValues());
        return $this->get(
{$getParams}
        );
    }