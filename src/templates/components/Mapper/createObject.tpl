    /**
     * @param {$ModelName} ${$modelName}
     * @return {$ModelName}
     * @throws DbException
     */
    public function createObject(${$modelName})
    {
        $insertValues = [
            // todo insert values
        ];

        $qb = new CompassQueryBuilder($this->getColumns());
        $insertQuery = $qb->getInsertQuery($insertValues, static::TABLE);
        $this->getDb()->execute($insertQuery->getQuery(), $insertQuery->getBindingValues());
        return $this->get({$getParams});
    }