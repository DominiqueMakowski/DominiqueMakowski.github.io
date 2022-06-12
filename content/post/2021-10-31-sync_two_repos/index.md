---
authors:
- Dominique Makowski
categories:
- Reproducibility
date: "2021-10-31T00:00:00Z"
draft: false
featured: false
image:
  caption: ''
  placement: 0
title: 'How to sync two folders in two separate GitHub repositories'
subtitle: 'Say you have a repo A, in which you want to duplicate some content with repo B.'
summary: Say you have a repo A, in which you want to duplicate some content with repo B. You can do that easily using GitHub actions.
tags:
- R
- Reproducibility
---

# How to sync two folders in two separate GitHub repositories

## The Problem

I have a personal website, stored in a GitHub repo (and hosted via GitHub pages), as well as a lab website (a "company" website, if you will). Both are fairly similar, as they are built using Wowchemy's [academic theme](https://wowchemy.com/). Importantly, there is a blog in the company websites with posts, but I have one on my personal website too. **I would like that every time I post something on my website, that it gets automatically copied over to the company website.** So that I don't have to manually maintain the content at two separate places.

## The Solution

1. The first step is to go to the settings of your GitHub account, to developers settings, and to [*personal access tokens*](https://github.com/settings/tokens). You have to generate a token, and tick the **repo** authorizations. Copy-paste the key.
2. Go to the settings of the personal website repo (the source from which the content will be copied), to "Secrets", and add a new secret called "API_TOKEN_GITHUB" (with the key you just copied).
3. Create a new GitHub action workflow such as [**this one**](https://github.com/DominiqueMakowski/DominiqueMakowski.github.io/blob/master/.github/workflows/copy_content.yml). The things to change are the `source_file`, `destination_repo` and `destination_folder`.

Tada :tada: Everytime I push to my personal repo, the new content of one of the subfolder gets copied to another repo.

**Note:** this is a one-way sync, so updates on the target repo won't affect the source repo (but might get overridden!).




---

*Thanks for reading! Do not hesitate to share or tweet this post, or leave a comment below* :hugs:
