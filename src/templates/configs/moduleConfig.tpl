<?php

return [
    '{$EntityName}DbTranslator' => [
        'table' => {$tableName},
        'columns' => [
{$columnsMapping}
        ],
        'create' => 'id',
        'update' => ['id'],
    ],
];
