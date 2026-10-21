# DominiqueMakowski.github.io

A one-page signpost to my lab, CV, software, teaching, consulting and artistic projects. Edit `index.html` (styles in `style.css`, card thumbnails in `img/`, 800×450 px); every push to `master` is deployed to the `gh-pages` branch.

- `404.html` forwards the old website's pages (posts, publications, projects, `/cv/`, `/services/`) to their new homes, mostly on the [lab website](https://realitybendinglab.com/). Add a line to its `REDIRECTS` map to forward another old URL. On deploy, `.github/redirect_pages.py` also writes a small redirect page at each of these paths, so that search engines follow them too.
- `robots.txt`, `sitemap.xml`, `llms.txt` (a plain summary for AI agents) and the JSON-LD block at the top of `index.html` describe the site to search engines and agents: update them when the page changes.
- `publication/` keeps the PDFs that the old website hosted, so existing links to them still work.
- `drafts/` holds unfinished post ideas (Markdown). It is not deployed; finished posts go on the lab website.

The previous Hugo/Wowchemy website is in the git history, up to commit `6918c47`.
