    /**
     * @return {$ModelName}Service
     * @throws EnergonCoreException
     */
    private function get{$ModelName}Service()
    {
        return $this->getServiceLocator()->get('{$ModelName}Service');
    }