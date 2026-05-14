# Deployment & DNS cutover

The site lives in two places:

| What | Where |
|------|-------|
| Source code | `main` branch of [asrosenberg/asrosenberg.github.io](https://github.com/asrosenberg/asrosenberg.github.io) |
| Rendered HTML | `gh-pages` branch, auto-built on every push to `main` by `.github/workflows/publish.yml` |
| Hosted by | GitHub Pages, served at `https://www.andrew-rosenberg.com` once DNS is migrated |

You can preview the rendered site at the temporary GitHub URL — but only after
DNS is moved (right now the `CNAME` file forces the github.io URL to redirect
to your custom domain).

---

## Step 1 — Log into GoDaddy

Both `andrew-rosenberg.com` and `asrosenberg.com` are registered with
**GoDaddy** (nameservers `NS71/NS72.DOMAINCONTROL.COM` and
`NS05/NS06.DOMAINCONTROL.COM` respectively — these are GoDaddy's own DNS
servers, so DNS is managed inside the GoDaddy panel, not delegated elsewhere).

1. Sign in at <https://account.godaddy.com/>.
2. Go to **My Products → Domains**.
3. Click `andrew-rosenberg.com` → **DNS** (or **Manage DNS**).

---

## Step 2 — Replace the DNS records on `andrew-rosenberg.com`

In the DNS table:

**Remove** any existing `A`, `AAAA`, or `CNAME` records on `@` (apex) and `www`
that point to Squarespace.

**Add four `A` records on the apex (`@`)** pointing to GitHub Pages:

```
@   A   185.199.108.153
@   A   185.199.109.153
@   A   185.199.110.153
@   A   185.199.111.153
```

**Add one `CNAME` record on `www`** pointing to GitHub:

```
www   CNAME   asrosenberg.github.io.
```

(Trailing dot if your registrar requires fully-qualified names.)

If your registrar offers `AAAA` (IPv6) records, you can also add:

```
@   AAAA   2606:50c0:8000::153
@   AAAA   2606:50c0:8001::153
@   AAAA   2606:50c0:8002::153
@   AAAA   2606:50c0:8003::153
```

Save changes.

---

## Step 3 — Wait for propagation, then enable HTTPS

DNS propagation typically takes 5–30 minutes; sometimes longer. Check from
your terminal:

```sh
dig +short www.andrew-rosenberg.com
dig +short andrew-rosenberg.com
```

You should see `asrosenberg.github.io` resolved to GitHub's `185.199.*` IPs
once it's propagated.

Once it has resolved, visit
<https://github.com/asrosenberg/asrosenberg.github.io/settings/pages>, scroll
to **Custom domain**, and click **Enforce HTTPS**. (GitHub provisions a free
Let's Encrypt cert; this can take a few minutes.)

---

## Step 4 — Redirect `asrosenberg.com` → `www.andrew-rosenberg.com`

In GoDaddy, open `asrosenberg.com`:

1. **My Products → Domains → asrosenberg.com → Manage**.
2. Find **Forwarding** (under the domain settings).
3. Add a forward:
   - **Forward to:** `https://www.andrew-rosenberg.com`
   - **Forward type:** Permanent (301)
   - **Forward settings:** Forward only (not masking)
4. Save.

This preserves any existing inbound links pointing to `asrosenberg.com`.
Note that GoDaddy implements forwarding by parking the domain on its own
servers and serving a redirect — DNS records for `asrosenberg.com` will be
managed automatically by GoDaddy.

---

## Step 5 — Cancel Squarespace hosting

Once `https://www.andrew-rosenberg.com` is serving the new site cleanly:

1. Confirm by opening the site in a private/incognito window.
2. Click through Publications, Working Papers, Books, Teaching, Contact.
3. Download the CV from the nav-bar link.
4. Cancel your Squarespace **site** subscription. *Keep* the domain
   registration if it lives at Squarespace Domains — only cancel the
   hosting/site plan.

---

## Future updates

Edit any `.qmd` file locally, then:

```sh
cd ~/Library/CloudStorage/Dropbox-Personal/Projects/asrosenberg-site
quarto preview     # live preview at http://localhost:4444
git add -A && git commit -m "Update X"
git push           # GitHub Actions rebuilds and redeploys in ~30 seconds
```

To update the CV, drop a new `asr-cv.pdf` into `assets/` and push.
