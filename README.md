# Scout Sitemaps

Crawls a list of sites and generates XML sitemaps, committed to this repo under `public/sitemaps/`. Sites with an existing `sitemap.xml` are skipped automatically.

## How it works

A daily GitHub Actions workflow reads `.github/sites.yaml`, batches sites into parallel jobs, and runs the [PHP-XML-Sitemap-Generator](https://github.com/iprodev/PHP-XML-Sitemap-Generator) for each one. Results are committed back to the repo.

## Running locally with Docker

### Build

```bash
docker build -t sitemap-generator .
```

### Run

```bash
docker run --rm -v $(pwd):/output sitemap-generator \
  --url=https://example.com \
  --out=/output \
  --concurrency=2 \
  --max-depth=5 \
  --verbose
```

Output is written to `./output` on your host.

See the [PHP-XML-Sitemap-Generator](https://github.com/iprodev/PHP-XML-Sitemap-Generator) documentation for all available configuration options.

## Adding a site

Add an entry to [.github/sites.yaml](.github/sites.yaml):

```yaml
- name: my-site
  url: https://my-site.example.com
  concurrency: 1
  max_depth: 10
  enable_javascript: false
```

| Field               | Description                                          |
| ------------------- | ---------------------------------------------------- |
| `name`              | Slug used for the output directory and artifact name |
| `url`               | Root URL to crawl                                    |
| `concurrency`       | Number of parallel requests                          |
| `max_depth`         | Maximum link depth to follow                         |
| `enable_javascript` | Use headless Chromium to render pages                |
