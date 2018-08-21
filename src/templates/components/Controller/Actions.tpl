
    /**
     * @return array
     * @throws EnergonCoreException
     * @throws DbException
     * @throws EnergonException
     */
    public function {$actionName}Action()
    {
        return $this->get{$controllerName}Service()->{$actionName}($this->getRequestData())->toArray();
    }
