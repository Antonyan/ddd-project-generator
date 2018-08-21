<?php

namespace Application\Controllers;

use Energon\Controller\RestController;
use Energon\Exceptions\EnergonCoreException;
use Energon\Responses\HttpResponse;
use Modules\LibraryModule\Exceptions\DbException;
use Modules\LibraryModule\Exceptions\EnergonException;
use Modules\{$ModuleName}\Models\{$ModelName};
use Modules\{$ModuleName}\{$ModelName}Service;

/**
 * Class {$ControllerName}Controller
 * @package Application\Controllers
 */
class {$ControllerName} extends RestController
{
{$getAction}
{$actions}
{$deleteAction}
{$serviceGetter}
}
