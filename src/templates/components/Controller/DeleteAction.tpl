    /**
     * @return array
     * @throws EnergonCoreException
     * @throws DbException
     * @throws EnergonException
     */
    public function deleteAction()
    {
        $this->get{$controllerName}Service()->delete($this->getRequestData());
        $this->getResponse()->setStatus(HttpResponse::CODE_NO_CONTENT);
        return true;
    }