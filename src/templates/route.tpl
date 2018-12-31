<?php

use App\Services\{$ServiceName};
use OpenApi\Annotations\JsonContent;
use OpenApi\Annotations\Parameter;
use OpenApi\Annotations\Schema;
use OpenApi\Annotations\Put;
use OpenApi\Annotations\Post;
use OpenApi\Annotations\Delete;
use OpenApi\Annotations\RequestBody;
use OpenApi\Annotations\MediaType;
use OpenApi\Annotations\Property;
use OpenApi\Annotations\Response;
use OpenApi\Annotations\Get;

/**
 * @Get(
 *     tags={"{$resource}s"},
 *     path="/{$resource}s",
{$loadParameters} *     @Parameter(ref="#/components/parameters/limit"),
 *     @Parameter(ref="#/components/parameters/offset"),
 *     @Parameter(ref="#/components/parameters/orderByAsc"),
 *     @Parameter(ref="#/components/parameters/orderByDesc"),
 *     @Parameter(ref="#/components/parameters/like"),
 *     @Parameter(ref="#/components/parameters/gt"),
 *     @Parameter(ref="#/components/parameters/lt"),
 *     @Parameter(ref="#/components/parameters/ge"),
 *     @Parameter(ref="#/components/parameters/le"),
 *
 *     @Response(
 *          response="200",
 *          description="Return pagination collection of {$resource}s",
 *          @JsonContent(ref="#/components/schemas/{$ServiceName}PaginationCollection")
 *      )
 * )
 *
 * @Get(
 *     tags={"{$resource}s"},
 *     path="/{$resource}s/{id}",
 *     @Parameter(
 *          in="path",
 *          name="id", @Schema(type="string"), description="Id's {$resource}"
 *      ),
 *     @Response(
 *          response="200",
 *          description="Fetch {$resource} by id",
 *          @JsonContent(ref="#/components/schemas/{$ServiceName}")
 *      ),
 *     @Response(
 *          response="404",
 *          description="Not Found",
 *      )
 * )
 *
 * @Put(
 *     tags={"{$resource}s"},
 *     path="/{$resource}s/{id}",
 *     @Parameter(
 *          in="path",
 *          name="id", @Schema(type="string"), description="Id's {$resource}"
 *      ),
 *     @RequestBody(
 *         @MediaType(
 *             mediaType="application/json",
 *             @Schema(
{$updateProperties} *             )
 *         )
 *      ),
 *
 *     @Response(
 *          response="200",
 *          description="Replace {$resource} by id",
 *          @JsonContent(ref="#/components/schemas/{$ServiceName}")
 *      ),
 *     @Response(
 *          response="404",
 *          description="Not Found",
 *      )
 * )
 *
 * @Post(
 *     tags={"{$resource}s"},
 *     path="/{$resource}s",
 *     @RequestBody(
 *         @MediaType(
 *             mediaType="application/json",
 *             @Schema(
{$createProperties} *             )
 *         )
 *      ),
 *     @Response(
 *          response="201",
 *          description="Create a new {$resource}",
 *          @JsonContent(ref="#/components/schemas/{$ServiceName}")
 *      )
 * )
 *
 * @Delete(
 *     tags={"{$resource}s"},
 *     path="/{$resource}s/{id}",
 *     @Parameter(
 *          in="path",
 *          name="id", @Schema(type="string"), description="Id's {$resource}"
 *      ),
 *     @Response(
 *          response="204",
 *          description="Delete {$resource} by id",
 *      )
 * )
 */
$routesCollectionBuilder->addCRUD('/{$resource}s', {$ServiceName}::class);