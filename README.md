# Scrapers for the Real word project at Codaisseur

For the last project at Codaisseur academy I was part of the project which needed scraping script. I did it with Ruby using gems (Watir and Nikogiri).

Scripts are scraping some basic trademark information like the name of the owner, the name of the trademark, expiration day... I am getting my data from https://www.tmdn.org/tmview/welcome.html and http://www.wipo.int/branddb/en/index.jsp# and  I am returning it to terminal as a JSON.


## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org/en/) and [Bundler](http://bundler.io/) installed.

```bash
git clone git@github.com:aljazskrinjar/scraping.git
cd scraping
bundle install
ruby scrapingWIPO.rb "name_of_the_company"
```
Good to know:
  1. When running scrapngTMDN.rb script, you should you the whole name of the company. For example:

  ```bash
  ruby scrapingWIPO.rb "Witloft B.V."
  ```
  In case you write you write just "Witloft" you might not get any results.
  
  2. The scrapingWIPO.rb will return first 30 results (or less if there is less trademarks) of your query. You don't have to write the whole name of the company.



