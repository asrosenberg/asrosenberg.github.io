# asrosenberg-site

Source for [andrewrosenberg.com](https://andrewrosenberg.com), a
[Quarto](https://quarto.org) website deployed via GitHub Pages.

## How to update the site (without any special tools)

1. Edit the relevant `.qmd` file in any text editor (see the layout table below).
2. Save, then run these three commands in Terminal:

   ```sh
   cd ~/Library/CloudStorage/Dropbox-Personal/Projects/asrosenberg-site
   git add -A
   git commit -m "Describe what you changed"
   git push
   ```

3. That's it. A GitHub Actions workflow rebuilds and redeploys the site
   automatically — the live site refreshes about a minute after you push.

You do **not** need Quarto installed to make text changes — GitHub builds
the site for you. Quarto is only needed if you want to preview locally first.

### Optional: preview locally before pushing

```sh
quarto preview          # live preview at http://localhost:4444
```

Press `Ctrl+C` to stop the preview.

## Updating the CV

Your CV lives at `~/Dropbox/CV/asr-vita.pdf`. To publish a new version:

```sh
cd ~/Library/CloudStorage/Dropbox-Personal/Projects/asrosenberg-site
bash update-cv.sh
```

That script copies the latest CV into the site, commits it, and pushes —
the new CV is live a minute later. (A direct symlink can't work: GitHub
only publishes committed files, so the PDF has to be copied into the repo.)

## Layout

| File | Purpose |
|------|---------|
| `_quarto.yml`         | Site config — title, nav, analytics |
| `theme.scss`          | Theme and all custom styling |
| `index.qmd`           | Landing / about page |
| `publications.qmd`    | Peer-reviewed articles |
| `working-papers.qmd`  | Working papers |
| `books/undesirable.qmd`, `books/hierarchies.qmd` | Book pages |
| `teaching.qmd`        | Course list |
| `contact.qmd`         | Contact info |
| `CNAME`               | Custom domain for GitHub Pages |
| `assets/`             | Headshot, CV PDF, journal covers, syllabi, papers |
| `update-cv.sh`        | One-command CV publish script |

## Hosting

- Source on the `main` branch; the rendered site is published to `gh-pages`
  by `.github/workflows/publish.yml` on every push.
- Custom domain: `andrewrosenberg.com` (set in the `CNAME` file).
