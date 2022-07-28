# <project-name>


## Links

- [issues]()
- [discussion]()
- git

## How to use this template

```bash
#!/usr/bin/env bash

PROJECT_DIR=${PROJECT_NAME:?"PROJECT_NAME environment variable must be set."}

git clone --depth=1  git@github.com:leventogut/project-template.git ${PROJECT_DIR}
cd ${PROJECT_DIR}
rm -rf .git
cp .envrc.example
cp .envrc.example .envrc
cp .env.example .env
git init
```

