# githubmngr: IaC for Github

This repo contains Terraform code for managing Github resources. 
Code is structured into [terragrunt][] project.

## What's managed by this repo?

- Github teams
- Github repositories

## Quick Start

```
$ brew install asdf
$ asdf install
$ <your commits>
$ task plan:github -- -var token=your_token
```

## FAQ

### What else can I do locally?

Ask `task`:

```
$ task -l
```

[terragrunt]: https://terragrunt.gruntwork.io/
