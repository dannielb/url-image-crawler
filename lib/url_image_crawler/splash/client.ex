defmodule UrlImageCrawler.Splash.Client do
  @moduledoc """
  Splash API client implementation, for more information visit: https://splash.readthedocs.io/en/stable/index.html.
  """
  @behaviour UrlImageCrawler.Splash.Api

  @impl true
  def get(url) do
    with {:ok, %{status: 200, body: body}} <-
           Req.get(client(), url: "/render.html", params: request_params(url)) do
      {:ok, body}
    end
  end

  defp request_params(url) do
    [url: url, wait: 5.5, render_all: 1]
  end

  defp client, do: Req.new(base_url: Application.fetch_env!(:url_image_crawler, :splash_url))
end
