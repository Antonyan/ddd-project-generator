# Generator

This part of the DDD project which allows you to generate contexts and modules in one click

## Installation instruction
To install module update your compose.json with the following lines

```json
{
    "require-dev": {
        "ddd-project/generator": "dev-master"
    },
    "repositories": [
        {
            "type": "vcs",
            "url":  "git@github.com:Antonyan/ddd-project-generator.git"
        }
    ]
}
```
And then run `compose update`

After the tool be installed you can use it by the command: `vendor/bin/generate`
