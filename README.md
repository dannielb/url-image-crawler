# UrlImageCrawler

UrlImageCrawler is a web scraping tool that allows you to extract links and images from web pages.

## Installation

To get started, make sure you have [Docker](https://www.docker.com/), [Elixir](https://elixir-lang.org/) and
[Erlang](https://www.erlang.org/) installed.

In the root directory:
- Install the dependencies with `mix setup`.
- Start the splash container with `docker-compose up`
  - Splash will be available at port 8050

## Usage

#### Splash
This application uses [Splash](https://splash.readthedocs.io/en/stable/). Splash is a powerful JavaScript rendering service that allows us to extract data from dynamic websites. Many websites today rely on complex client-side JavaScript to render their content, which can make it difficult to scrape data using traditional HTTP requests. By using Splash, we're able to simulate a browser and execute JavaScript on the page, allowing us to extract data that would otherwise be difficult or impossible to obtain. Splash's lightweight design and HTTP API make it a great choice for integrating with our app.

### Exported functions
This project exports a function called `Splash.fetch/1`, that makes possible to get all the images and links from a web page, but it can also be used as a command line, by building the project:

#### Building
To build the application as a command line app, in the project`s root directory: 
- use `mix escript.build`. This will create a binary named `url_image_crawler`, which can be ran on any system with an Erlang VM.
- for example: `./url_image_crawler https://uplearn.co.uk/`

## Testing

In order to run automated tests, use `mix test`.

## Improvement points
> some improvements that can be done with more time.
- Add Elixir in the docker-compose.yml, making all the project runnable via Docker.
- Add validation checks to ensure that all returned images and links are valid
- The current Splash rendering configurations may not be the best fit for all projects. Depending on the specific use case, It may need to adjust the configurations for optimal performance, These are the current configuration:
  - `wait`: waits at least 5.5 seconds to get the pages results
  - `render_all`: extend the viewport to include the whole webpage (possibly very tall) before rendering
