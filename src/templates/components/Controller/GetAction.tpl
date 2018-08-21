    /**
     * @return array
     * @param array $data
     */
    public function getAction(array $data)
    {
        return $this->get{$controllerName}Service()->get($data[{$controllerName}::ID])->toArray();
    }