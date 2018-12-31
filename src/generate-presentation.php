<?php

use Phalcon\Script\Color;

require __DIR__.'/../../../autoload.php';

include_once('functions.php');

$shortopts  = '';
$shortopts .= 'n:';

$options = getopt($shortopts);

if (!$options){
    echo Color::colorize("\nSyntax: generate-presentation.php -n namespace\n", Color::BG_LIGHT_GRAY);
    exit();
}

if(!array_key_exists('n', $options)){
    echo Color::colorize("\nYou should specify path to Entity as -n namespace\n", Color::FG_RED);
    exit;
}

$entityNamespace = $options['n'];

$entityReflection = new ReflectionClass($entityNamespace);


$properties = [];
$entityName = array_pop(explode('\\' , $entityReflection->getName()));

foreach ($entityReflection->getProperties() as $reflection) {
    $output_array = [];
    $propertyName = $reflection->name;
    preg_match('/@var\s*(\w*)/m', $entityReflection->getProperty($propertyName)->getDocComment(), $output_array);
    $properties[] = new Property($propertyName, $output_array[1]);
}
$path = $entityReflection->getFileName();

// -------------
$partFromContextName = substr($path, strpos($path, "contexts/") + strlen("contexts/"));
$contextName = substr($partFromContextName,0, strpos($partFromContextName, "/"));

$contractName = $contextName . "Contract";

$contractNameSpace = 'Contexts\\' . $contextName . '\\' . $contractName;

// -------------

$contract = new Contract($contractNameSpace, $contractName, $contextName . 'Service');

$contextService = new ContextService(
    'Contexts\\' . $contextName . '\\Services\\' . $contextName . 'Service',
    $contextName . 'Service'
);

$entity = new Entity($entityName, $properties);

$presentationServicesPath = __DIR__ . '/../../../../src/app/Services/';
$configDir = __DIR__ . '/../../../../src/app/config/';
$presentationServicesContainerPath = $configDir . 'container.php';
$presentationServicesRoutePath = $configDir . 'restRoutes.php';
$presentationServicesRoutesDirPath = $configDir . 'routes/';

if (!file_exists($presentationServicesPath)){
    createFolder( $presentationServicesPath);
}

//addPresentationService($presentationServicesPath, $entity, $contract);

$container = file_get_contents($presentationServicesContainerPath);

if (!strpos($container, '\'' . $contextService->getName() . '\'')){
    $container .= "\n" . '$containerBuilder->register(\'' . $contextService->getName() . '\', ' . $contextService->getNamespace() . '::class);';
    file_put_contents($presentationServicesContainerPath, $container);
}

//-------------

$resRoutes = file_get_contents($presentationServicesRoutePath);

if (!strpos($resRoutes,  lcfirst($entity->getClassName()) . '.php')){
    $replacement = 'require_once \'routes/' . lcfirst($entity->getClassName() . '.php\';' ) . "\n";
    $resRoutes = substr_replace($resRoutes, $replacement , strpos($resRoutes, 'return $routesCollectionBuilder->build();'), 0);
    file_put_contents($presentationServicesRoutePath, $resRoutes);

    if (!file_exists($presentationServicesRoutesDirPath)){
        createFolder( $presentationServicesRoutesDirPath);
    }

    addRouteAndSchemaFile($presentationServicesRoutesDirPath, $entity, $contract);
}

function addPresentationService(string $path, Entity $entity, Contract $contract)
{
    $loadFields = '';
    $createFields = '';
    $updateFields = '';

    /** @var Property $property */
    foreach ($entity->getClassProperties() as $property){
        $loadFields .= ' * @Validation(name="' . $property->getName() . '", type="string")' . "\n\t";

        if ($property->getName() === 'id'){
            $updateFields .= ' * @Validation(name="' . $property->getName() . '", type="string", required=true)' . "\n\t";
            continue;
        }

        $updateFields .= ' * @Validation(name="' . $property->getName() . '", type="' . $property->getType() . '", required=true)' . "\n\t";
        $createFields .= ' * @Validation(name="' . $property->getName() . '", type="' . $property->getType() . '", required=true)' . "\n\t";
    }

    file_put_contents(
        $path . '/' . $entity->getClassName() . '.php',
        renderTemplate([
            'ServiceName' => $entity->getClassName(),
            'FullContactName' => $contract->getNamespace(),
            'ContractName' => $contract->getName(),
            'ContextServiceName' => $contract->getContextServiceName(),
            'EntityName' => $entity->getClassName(),
            'LoadFields' => $loadFields,
            'CreateFields' => $createFields,
            'UpdateFields' => $updateFields,
        ], TEMPLATES_PATH . '/PresentationService.tpl')
    );
}

function addRouteAndSchemaFile(string $path, Entity $entity, Contract $contract)
{
    $loadParameters = '';
    $createParameters = '';
    $schemaParameters = '';
    $resource = lcfirst($entity->getClassName());

    /** @var Property $property */
    foreach ($entity->getClassProperties() as $property){

        $loadParameters .= ' *     @Parameter(in="query", name="' . $property->getName() . '", @Schema(type="string"), '
            .'description=""),' . "\n";

        if ($property->getName() === 'id'){
            $schemaParameters .= ' *' . "\t\t" . '@Property(property="' . $property->getName() .
                '", type="' . ($property->getType() === 'int' ? 'integer' : $property->getType()) . '", description=""),' . "\n";
            continue;
        }

        $createParameters .= ' *' . "\t\t\t\t" . '@Property(property="' . $property->getName() .
            '", type="' . ($property->getType() === 'int' ? 'integer' : $property->getType()) . '", description=""),' . "\n";
        $schemaParameters .= ' *' . "\t\t" . '@Property(property="' . $property->getName() .
            '", type="' . ($property->getType() === 'int' ? 'integer' : $property->getType()) . '", description=""),' . "\n";
    }

    file_put_contents(
        $path . '/' . $resource . '.php',
        renderTemplate([
            'ServiceName' => $entity->getClassName(),
            'resource' => $resource,
            'loadParameters' => $loadParameters,
            'updateProperties' => $createParameters,
            'createProperties' => $createParameters,
        ], TEMPLATES_PATH . '/route.tpl')
    );

    file_put_contents(
        $path . '/../../doc/schemas/' . $resource . '.php',
        renderTemplate([
            'EntityName' => $entity->getClassName(),
            'SchemaProperties' => $schemaParameters,
        ], TEMPLATES_PATH . '/schema.tpl')
    );
}

class ContextService
{
    /**
     * @var string
     */
    private $namespace;

    /**
     * @var string
     */
    private $name;

    /**
     * ContextService constructor.
     * @param string $namespace
     * @param string $name
     */
    public function __construct(string $namespace, string $name)
    {
        $this->namespace = $namespace;
        $this->name = $name;
    }

    /**
     * @return string
     */
    public function getNamespace(): string
    {
        return $this->namespace;
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }
}

class Contract
{
    /**
     * @var string
     */
    private $namespace;

    /**
     * @var string
     */
    private $name;

    /**
     * @var string
     */
    private $contextServiceName;

    /**
     * Contract constructor.
     * @param string $namespace
     * @param string $name
     * @param string $contextServiceName
     */
    public function __construct(string $namespace, string $name, string $contextServiceName)
    {
        $this->namespace = $namespace;
        $this->name = $name;
        $this->contextServiceName = $contextServiceName;
    }

    /**
     * @return string
     */
    public function getNamespace(): string
    {
        return $this->namespace;
    }

    public function getServiceNamespace(): string
    {
        $replacedContract = str_replace( 'Contract', 'Service', $this->namespace . '\\Services\\');
        return str_replace( 'Contract', '\\' . $this->getName() . '\\', $this->namespace . '\\Services\\');;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @return string
     */
    public function getContextServiceName(): string
    {
        return $this->contextServiceName;
    }
}


class Entity
{
    /**
     * @var string
     */
    private $className;

    /**
     * @var array
     */
    private $classProperties;

    /**
     * Entity constructor.
     * @param string $className
     * @param array $classProperties
     */
    public function __construct(string $className, array $classProperties)
    {
        $this->className = $className;
        $this->classProperties = $classProperties;
    }

    /**
     * @return string
     */
    public function getClassName(): string
    {
        return $this->className;
    }

    /**
     * @return array
     */
    public function getClassProperties(): array
    {
        return $this->classProperties;
    }
}

class Property
{
    /**
     * @var string
     */
    private $name;

    /**
     * @var string
     */
    private $type;

    /**
     * Property constructor.
     * @param string $name
     * @param string $type
     */
    public function __construct(string $name, string $type)
    {
        $this->name = $name;
        $this->type = $type;
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }

    /**
     * @return string
     */
    public function getType(): string
    {
        return $this->type;
    }
}
