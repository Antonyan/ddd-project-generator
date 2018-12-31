<?php

use OpenApi\Annotations\Schema;
use OpenApi\Annotations\Property;
use OpenApi\Annotations\Items;

/**
 * @Schema(
 *   schema="{$EntityName}",
 *   description="",
 *   type="object",
 *   properties= {
{$SchemaProperties} * }
 * )
 */

/**
 * @Schema(
 *   schema="{$EntityName}PaginationCollection",
 *   description="",
 *   type="object",
 *   properties= {
 *     @Property(property="limit", description="Limit fetching items", type="integer"),
 *     @Property(property="offset", description="Fetching items with offset", type="integer"),
 *     @Property(property="totalCount", description="Total count", type="integer"),
 *     @Property(property="items", description="Items", type="array", @Items(ref="#/components/schemas/{$EntityName}"))
 * }
 * )
 */