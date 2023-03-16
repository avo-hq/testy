# Avo monorepo setup

The monorepo setup helps us easily manage all of Avo's packages.

You should have the following directory structure. I keep my `root` in `~/work/gems` the `gems/` part is important. That is the root of the project when working with the Pro packages.

In the `root` directory you should have `avo` directory (the public repo `gihub.com/avo-hq/avo`), the root-level `prommy` app (how we test the Pro packages), the pro packages and some support files.

### Structure

```sh
gems/ # root
├─ avo/ # the main Avo repo
│  ├─ dummy/ # the app where we test just the Avo repo functionality
├─ bin/dev/ # the script that we run to bring everything up.
├─ bud/ # the CLI that helps us manage all these pacakges
├─ prommy/ # The app where we test the Pro packages functionality
├─ avo_dashboards/
├─ avo_filters/
├─ .../ # Other pro Avo packages
├─ Procfile # the Procfile that manages all the processes from all pacakges
├─ Gemfile # the Gemfile that installs all the packages needed for bud and to run this infrastructure
├─ gems.yml # a list of all the Pro Avo engines
```

## Architecture

We have a few things to discuss here.

1. Local development
2. Deployment

## 1. Local development

We are shooting for the most seamless development environment. We'd like to continue to ship fast without `cd`-ing from one directory to another. So when doing work on the Free repo, we run commands from the `avo` directory as with Avo 2, and when doing work for any of the pro packages, we should run commands from the root (`gems`) directory.

## 2. Deployment

The deployment process should be easy and should follow the same processes as the development ones (same tailwind configuration, same JS compilation process, etc.).


## Tailwind CSS

Tailwind will work a bit differently from Avo 2. For the free repo it will compile using a list of common files and directories for Avo engines

```js
// Common files and dirs for Avo engines.
const paths = (name, path) => ([
  `${path}/app/helpers/**/*.rb`,
  `${path}/app/views/**/*.erb`,
  `${path}/app/javascript/**/*.js`,
  `${path}/app/components/**/*.erb`,
  `${path}/app/components/**/*.rb`,
  `${path}/app/controllers/**/*.rb`,
  `${path}/app/javascript/**/*.js`,
  `${path}/lib/${name}/**/*.rb`,
])
```

## VSCode

You can open the `root` directory in one VSCode window and it will know that you have multiple repos in there.