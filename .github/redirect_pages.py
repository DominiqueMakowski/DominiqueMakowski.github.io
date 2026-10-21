"""Write a small redirect page at each old URL listed in 404.html's REDIRECTS map.

GitHub Pages serves 404.html with a 404 status, and search engines (and agents
that do not run JavaScript) never follow its script, so they would drop the old
pages instead of following them to their new home. These pages are served with a
200 status and redirect with an instant meta refresh, which search engines treat
as a permanent redirect. Run by the deploy workflow; the pages are not committed.
"""

import html
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

PAGE = """<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Moved · Dominique Makowski</title>
    <link rel="canonical" href="{url}" />
    <meta http-equiv="refresh" content="0; url={url}" />
</head>
<body>
    <p>This page has moved to <a href="{url}">{url}</a>.</p>
</body>
</html>
"""

source = (ROOT / "404.html").read_text(encoding="utf-8")
block = re.search(r"const REDIRECTS = \{(.*?)\n\s*\}", source, re.S)
redirects = re.findall(r'^\s*"([^"]+)":\s*"(https?://[^"]+)",?\s*$', block.group(1), re.M) if block else []
if not redirects:
    sys.exit("No redirects found in 404.html: has the format of its REDIRECTS map changed?")

written = 0
for path, url in redirects:
    page = ROOT / path / "index.html"
    # A real page always wins over a redirect
    if page.exists():
        print(f"skip /{path}/: a page already exists there")
        continue
    page.parent.mkdir(parents=True, exist_ok=True)
    page.write_text(PAGE.format(url=html.escape(url)), encoding="utf-8")
    written += 1

print(f"Wrote {written} redirect pages")
