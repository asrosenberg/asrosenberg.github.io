# asrosenberg-site

Source for [www.andrew-rosenberg.com](https://www.andrew-rosenberg.com), a
[Quarto](https://quarto.org) website deployed via GitHub Pages.

## Local development

```sh
quarto preview          # live preview at http://localhost:port
quarto render           # build the site into _site/
```

The published copy is built by a GitHub Actions workflow on every push to
`main` (see `.github/workflows/publish.yml`) and served from the `gh-pages`
branch.

## Layout

| File | Purpose |
|------|---------|
| `_quarto.yml`         | Site config — title, nav, theme |
| `index.qmd`           | Landing / about page |
| `publications.qmd`    | Peer-reviewed articles |
| `working-papers.qmd`  | Working papers and drafts |
| `books.qmd`           | Book project pages |
| `teaching.qmd`        | Course list |
| `contact.qmd`         | Contact info |
| `styles.css`          | Custom CSS overrides |
| `CNAME`               | Custom domain for GitHub Pages |
| `assets/`             | Headshot, CV PDF, favicon |

## Add or update a page

1. Edit the relevant `.qmd` file.
2. `quarto preview` to check locally.
3. Commit and push — Actions handles the rest.

## Updating the CV

Drop a new `asr-cv.pdf` into `assets/` and commit. The nav-bar CV link points
to that file.
