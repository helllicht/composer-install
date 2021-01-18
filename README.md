# helllicht/composer-install

> https://docs.github.com/en/free-pro-team@latest/actions/creating-actions/creating-a-composite-run-steps-action

## Active versions
+ master
+ v0.1

## How to use this action
If not already done, add following folder structure to the project (name of the yml-file is up to you).
```
.
└── .github/
    └── workflows/
        └── deployment.yml
```
Example:
> In this example just the 'staging'-Branch is deployed!
> read more about 'on:'
> here: https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions#on
```
name: Deployment (Staging)

on:
    push:
        branches:
            - staging

jobs:
    build:
        name: Deployment
        runs-on: ubuntu-18.04
        steps:
            - name: Checkout Repository
              uses: actions/checkout@v2
            - name: Install PHP dependencies
              uses: helllicht/composer-install@v1
            - ...
```

## Update composer installation file
1) Go to: https://github.com/composer/getcomposer.org/commits/master
2) Get the latest commit sha
3) replace it in the script

## Update an active version
Breaking changes are not allowed when updating an active version!
1) checkout the branch (e.g. v1)
2) ...change code
3) commit & push

## Release new version
Make release note with a short overview.
1) create a new branch (e.g. v3)
2) ...change code
3) commit & push (with dist folder!)
