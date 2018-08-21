
    /**
     * @return string
     */
    protected function getSelectQuery()
    {
        return parent::getSelectQuery() .
{$join}
    }
