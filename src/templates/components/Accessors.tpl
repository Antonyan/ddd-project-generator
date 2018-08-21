    /**
     * @param {$typeDoc} ${$field}
     * @return {$ModelName}
     */
    public function set{$Field}({$typeSetter}${$field})
    {
        $this->{$field} = ({$typeDoc})${$field};
        return $this;
    }

    /**
     * @return {$typeDoc}
     */
    public function get{$Field}()
    {
        return $this->{$field};
    }
