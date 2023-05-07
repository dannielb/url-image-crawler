defmodule UrlImageCrawler.Splash do
  @moduledoc """
  Splash handling module. Splash is a powerful JavaScript rendering service that
  allows us to extract data from dynamic websites.
  """

  @doc """
  Fetches images and links from a given URL.

  ## Parameters

  * `url` - A string representing the URL of the website to fetch.

  ## Returns

  A tuple with the following values:

  * `:ok` - Indicates that the operation was successful.
  * `{links, images}` - A tuple with two values:
  *  - A list of link URLs found on the website.
  *  - A list of image URLs found on the website.
  """
  def fetch(url) do
    with {:ok, body} <- splash_client().get(url),
         {:ok, document} <- Floki.parse_document(body) do
      {:ok, {parse_links(document), parse_images(document)}}
    else
      {:error, %Mint.TransportError{reason: :econnrefused}} -> {:error, :connection_refused}
    end
  end

  defp parse_links(document) do
    document
    |> Floki.find("a")
    |> Floki.attribute("href")
  end

  defp parse_images(document) do
    document
    |> Floki.find("img")
    |> Floki.attribute("src")
  end

  defp splash_client, do: Application.fetch_env!(:url_image_crawler, :splash_client)
end
